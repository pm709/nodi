#!/bin/bash
cd ROOT_TO_CHANGED/cgm-remote-monitor
source ../config/mongodb.env

# Variable taken from nightscout github
# https://github.com/nightscout/cgm-remote-monitor#environment

BASE_URL="https://URL_TO_CHANGED/"
HOSTNAME=localhost
PORT=1337

export CUSTOM_TITLE="TO BE EDITED"
export API_SECRET=TO_BE_EDITED


export AUTH_DEFAULT_ROLES=denied
export DISPLAY_UNITS=mg/dl
export ENABLE="delta direction timeago devicestatus ar2 profile careportal boluscalc food rawbg iob cob bwp cage sage bage iage treatmentnotify basal pump openaps"
export DISABLE="upbat errorcodes simplealarms bridge mmconnect loop"

export TIME_FORMAT=24
export NIGHT_MODE=off
export SHOW_RAWBG=always

export THEME=colors

export ALARM_TIMEAGO_WARN=on
export ALARM_TIMEAGO_WARN_MINS=15
export ALARM_TIMEAGO_URGENT=on
export ALARM_TIMEAGO_URGENT_MINS=30

export PROFILE_HISTORY=on
export PROFILE_MULTIPLE=on

export BWP_WARN=0.50
export BWP_URGENT=1.00
export BWP_SNOOZE_MINS=10
export BWP_SNOOZE=0.10

export BAGE_ENABLE_ALERTS=true
export BAGE_INFO=288
export BAGE_WARN=312
export BAGE_URGENT=336

export CAGE_ENABLE_ALERTS=true
export CAGE_INFO=44
export CAGE_WARN=48
export CAGE_URGENT=72

export SAGE_ENABLE_ALERTS=false
export SAGE_INFO=144
export SAGE_WARN=164
export SAGE_URGENT=166

export IAGE_ENABLE_ALERTS=false
export IAGE_INFO=44
export IAGE_WARN=48
export IAGE_URGENT=72

export TREATMENTNOTIFY_SNOOZE_MINS=10

export BASAL_RENDER=default

export BRIDGE_USER_NAME=
export BRIDGE_PASSWORD=
export BRIDGE_INTERVAL=150000
export BRIDGE_MAX_COUNT=1
export BRIDGE_FIRST_FETCH_COUNT=3
export BRIDGE_MAX_FAILURES=3
export BRIDGE_MINUTES=1400

export MMCONNECT_USER_NAME=
export MMCONNECT_PASSWORD=
export MMCONNECT_INTERVAL=60000
export MMCONNECT_MAX_RETRY_DURATION=32
export MMCONNECT_SGV_LIMIT=24
export MMCONNECT_VERBOSE=false
export MMCONNECT_STORE_RAW_DATA=false

export DEVICESTATUS_ADVANCED="true"

export PUMP_ENABLE_ALERTS=true
export PUMP_FIELDS="reservoir battery clock status"
export PUMP_RETRO_FIELDS="reservoir battery clock"
export PUMP_WARN_CLOCK=30
export PUMP_URGENT_CLOCK=60
export PUMP_WARN_RES=50
export PUMP_URGENT_RES=10
export PUMP_WARN_BATT_P=30
export PUMP_URGENT_BATT_P=20
export PUMP_WARN_BATT_V=1.35
export PUMP_URGENT_BATT_V=1.30

export OPENAPS_ENABLE_ALERTS=false
export OPENAPS_WARN=30
export OPENAPS_URGENT=60
export OPENAPS_FIELDS="status-symbol status-label iob meal-assist rssi freq"
export OPENAPS_RETRO_FIELDS="status-symbol status-label iob meal-assist rssi"

export LOOP_ENABLE_ALERTS=false
export LOOP_WARN=30
export LOOP_URGENT=60

export SHOW_PLUGINS=careportal
export SHOW_FORECAST="ar2 openaps"

export LANGUAGE=en
export SCALE_Y=log
export EDIT_MODE=on

npm start
