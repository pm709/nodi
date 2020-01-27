# Nightscout on debian installer (NODI)
NODI is a tool to install [nightscout](https://github.com/nightscout/cgm-remote-monitor) on a debian instance.
Additionnaly it will install some relative dependencies :
  * mongodb
  * ssl certificate using [let's encrypt](https://letsencrypt.org/)

It also trigger daily mongodb backup, monthly restart of the server, ssl certificate renewal


# Requirements
Having a debian 10 (buster) instance running

# Configure NODI
## Mongo
According to your wanted credentials, change the file  mongodb.env

## Nightscout
In file scripts/start_nightscout, be sure to change values of 
  * CUSTOM_TITLE
  * API_SECRET

Do not forget to customize others nightscout variables if needed. For a full list of variables check https://github.com/nightscout/cgm-remote-monitor#environment

If you want to use service like [autotuneweb](https://autotuneweb.azurewebsites.net/) then change the value of AUTH_DEFAULT_ROLES

# Using NODI
Once configuration is done, execute the bash script __./nodi.sh__ with root user

During the installation process, you're will be asked for :
  * your nighscout url (e.g. my-nighscout.on-myserver.org )
  * password of nighscout and mongodb users
  * let's encrypt needed data

# Links
  * Nightscout
    * [homepage](https://www.nightscoutfoundation.org/)
    * [git](https://github.com/nightscout/cgm-remote-monitor)

# Thanks
  * Everyone involved in the #wearenotwaiting movement.
  * Sandra Keßler and its [nighscout installer for rasperry pi](https://github.com/SandraK82/deploy-ns-local-raspi)
