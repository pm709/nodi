#!/bin/bash
cd ROOT_TO_CHANGED/backup

source ../config/mongodb.env

OUTFILE=$MONGO_DB.`date +'%Y_%m_%d_%H:%M:%S'`.bson.gz

/usr/bin/mongodump --host $MONGO_HOST --port $MONGO_PORT -d $MONGO_DB -u $MONGO_USER -p $MONGO_PASWD --archive=$OUTFILE --gzip
