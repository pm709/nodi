#!/bin/bash

TEMP_FOLDER='/tmp/temp_ns'

NS_USER='nightscout'
NS_FOLDER='/opt/nightscout'

create_user() {
    echo "Creating new user $1 with shell $2 (sudo $3)"
    userdel --force -r $1
    useradd -m -U -u $4 -s $2 $1
    echo "Set password for user $1"
    read -s -p "Password: " PASSWD 
    echo "$1:$PASSWD" | chpasswd
    if [ $3 = "Y" ]
    then
        echo "$1 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$1-nopasswd
    else
        rm -f /etc/sudoers.d/$1-nopasswd
    fi
}

reset_folder() {
    echo "Resetting folder tree $1 of user $2"
    rm -rf $1
    mkdir -p $1/{config,scripts,backup}
    chown -R $2 $1
}

install_mongodb() {
    curl https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
    apt-get update -qq 
    apt-get install -qq  -y mongodb-org
    
    systemctl enable mongod.service
    systemctl start mongod.service && sleep 5
}

install_nodejs() {
    curl -sL https://deb.nodesource.com/setup_10.x | bash -
    apt-get install -y nodejs
}

checkout_ns() {
    echo "Cloning $4 branch of $3 in $2 with user $1"
    pushd $2
    runuser -u $1 git clone $3 
    cd cgm-remote-monitor 
    runuser -u $1 git checkout $4
    popd
}

install_ns_dependencies() {
    echo "Installing nighstcout dependencies"
    pushd $1
    cd cgm-remote-monitor
    runuser -u $2 npm install
    popd
}

configure_httpd() {
    echo "Creating NGINX configuration for $1"
    cp config/nginx-site.conf /etc/nginx/sites-available/$1
    sed -i 's@URL_TO_CHANGED@'"$1"'@g' /etc/nginx/sites-available/$1
    ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/
    systemctl restart nginx
    certbot --nginx -d $1
}

configure_mongodb() {
    echo "Configuring MongoDB"
    . config/mongodb.env
    cat scripts/create_admin.js | envsubst | mongo
    systemctl stop mongod.service
    systemctl start mongod.service && sleep 5
    cat scripts/create_user.js | envsubst | mongo
    if [ -f backup/backup.bson.gz ]
    then
        echo "Restoring database from backup"
        mongorestore --host $MONGO_HOST --port $MONGO_PORT -d $MONGO_DB -u $MONGO_USER -p $MONGO_PASWD --archive=backup/backup.bson.gz --gzip
    fi
}

configure_ns() {
    for filename in config/cronfile config/mongodb.env config/10-nightscout.conf scripts/backup_mongo.sh scripts/start_nightscout.sh scripts/nightscout.service
    do
        FP=$2/$filename
        cp $filename $FP
        chown $1 $FP
        sed -i 's@URL_TO_CHANGED@'"$3"'@g' $FP
        sed -i 's@ROOT_TO_CHANGED@'"$2"'@g' $FP
        if [[ $filename == *"scripts"* ]]; then
            chmod +x $FP
        fi
    done

    runuser -u $1 crontab $NS_FOLDER/config/cronfile
}


autostart() {
    echo "Configure nightscout to start on boot"
    pushd $1
    cp scripts/nightscout.service /etc/systemd/system/nightscout.service
    cp config/10-nightscout.conf /etc/rsyslog.d
    chown root:root /etc/systemd/system/nightscout.service /etc/rsyslog.d/10-nightscout.conf

    systemctl start rsyslog
    systemctl start nightscout 
    systemctl enable nightscout
    popd
}

read -p "Your nighscout url (without https://): " NS_URL 

echo "Updating OS"
apt-get update -qq && apt-get upgrade -y -q

echo "Installing needed packages"
apt-get install -y -qq git nginx certbot python3-certbot-nginx wget curl build-essential sudo

echo "Creating new temp folder"
rm -rf $TEMP_FOLDER
mkdir -p $TEMP_FOLDER

echo "Creating users"
create_user $NS_USER '/bin/bash' 'Y' 2000
create_user 'mongodb' '/bin/false' 'N' 2001

reset_folder $NS_FOLDER $NS_USER

echo "Installing MongoDB"
install_mongodb

echo "Installing NodeJS"
install_nodejs

echo "Retrieve latest nighscout version"
checkout_ns $NS_USER $NS_FOLDER 'https://github.com/nightscout/cgm-remote-monitor.git' 'master'

install_ns_dependencies $NS_FOLDER $NS_USER

configure_httpd $NS_URL
configure_mongodb

configure_ns $NS_USER $NS_FOLDER $NS_URL

autostart $NS_FOLDER
