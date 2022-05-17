#!/bin/bash
# Updating everything... Made by Argantiu
# Don't edit this here
. ./config/values.conf
. $DSERVERFOLDER/config/mcsys.conf
# Path generating
LPATH=/$OPTBASE/$SERVERBASE
#
apt-get -qq update
cd $LPATH/mcsys || exit 1
wget -q https://raw.githubusercontent.com/Argantiu/system-api/main/api/v1/restart.sh -O restart.sh
wget -q https://raw.githubusercontent.com/Argantiu/system-api/main/api/v1/start.sh -O start.sh
wget -q https://raw.githubusercontent.com/Argantiu/system-api/main/api/v1/stop.sh -O stop.sh
chmod +x *.sh
cd $LPATH/mcsys/updater || exit 1
wget -q https://raw.githubusercontent.com/Argantiu/system-api/main/api/v1/updater.sh -O updater.sh
exit 1

