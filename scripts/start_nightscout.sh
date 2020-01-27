#!/bin/bash
cd ROOT_TO_CHANGED/cgm-remote-monitor
source ../config/mongodb.env

# See the full list of variables on nightscout github
# https://github.com/nightscout/cgm-remote-monitor#environment

BASE_URL="https://URL_TO_CHANGED/"
HOSTNAME=localhost
PORT=1337

export CUSTOM_TITLE="TO BE EDITED"
export API_SECRET=TO_BE_EDITED

npm start
