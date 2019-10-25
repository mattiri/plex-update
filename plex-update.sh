#!/bin/bash

# Script to automagically update Plex Media Server on raspbian
#
# Must be run as root.
# @source @mattiri https://github.com/mattiri/plex-update
# @source @martinorob https://github.com/martinorob/plexupdate
# @author @nitantsoni https://github.com/nitantsoni/

installdir=/tmp
token=$(cat /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml | grep -oP 'PlexOnlineToken="\K[^"]+')
url=$(echo "https://plex.tv/api/downloads/5.json?channel=plexpass&X-Plex-Token=$token")
jq=$(curl -s ${url})
newversion=$(echo $jq | jq -r .computer.Linux.version)
#echo New Ver: $newversion
curversion=$(dpkg -s plexmediaserver | grep -i version)
curversion=${curversion/"Version: "/""}


if [ "$newversion" != "$curversion" ];then
echo "New Plex Media Server Version Available"

cpu=$(uname -m)
#echo $cpu

echo
if [ "$cpu" = "armv7l" ]; then
url=$(echo $jq | jq -r ".computer.Linux.releases[3] | .url")

mkdir -p $installdir/tmp/

rm $installdir/tmp/*
telegram-send "Downloading new Version ($newversion) ..."
wget $url -P $installdir/tmp/
dpkg -i $installdir/tmp/*armhf.deb
mv $installdir/tmp/*.dpkg $installdir/
echo "New Plex Media Server Installed (Old Version: $curversion, New Version: $newversion)"
#sleep 30

else
echo "No New Version"
fi

else
echo "No New Version for Plex Media Server (Ver. $curversion)"

fi

exit
