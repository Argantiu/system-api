#!/bin/bash
# Minecraft Server auto stop script - Do not configure this scipt!!
# Version 3.0.0.0-#0 made by Argantiu GmBh 06/21/2022 UTC/GMT +1 https://crazycloudcraft.de
MAINVERSION=
MCNAME=
LPATH=
RAM=
JAVABIN=
#Mohist: Getting Update form your selected version.
mkdir -p $LPATH/mcsys/jar
cd $LPATH/mcsys/jar || exit 1
DATE=$(date +%Y.%m.%d.%H.%M.%S)
wget -q https://mohistmc.com/api/$MAINVERSION/latest/download -O mohist-$MAINVERSION-$DATE.jar
unzip -qq -t  mohist-$MAINVERSION-$DATE.jar
if [ "$?" -ne 0 ]; then
 echo "Downloaded mohist-$MAINVERSION-$DATE.jar is corrupt. No update." | /usr/bin/logger -t $MCNAME
else
 diff -q mohist-$MAINVERSION-$DATE.jar $LPATH/$MCNAME.jar >/dev/null 2>&1
 if [ "$?" -eq 1 ]; then
  cp mohist-$MAINVERSION-$DATE.jar  mohist-$MAINVERSION-$DATE.jar.backup
  mv mohist-$MAINVERSION-$DATE.jar $LPATH/$MCNAME.jar
  /usr/bin/find $LPATH/mcsys/jar/* -type f -mtime +10 -delete 2>&1 | /usr/bin/logger -t $MCNAME
  echo "mohist-$MAINVERSION-$DATE.jar has been updated" | /usr/bin/logger -t $MCNAME
 else
  echo "No mohist-$MAINVERSION-$DATE.jar update neccessary" | /usr/bin/logger -t $MCNAME
  rm mohist-$MAINVERSION-$DATE.jar
 fi
fi
# Starting server
cd $LPATH || exit 1
echo "Starting $LPATH/$MCNAME.jar" | /usr/bin/logger -t $MCNAME
screen -d -m -L -S $MCNAME  /bin/bash -c "$JAVABIN -Xms$RAM -Xmx$RAM -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar $MCNAME.jar nogui"
exit 1
