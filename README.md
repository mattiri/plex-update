# Description
Automatically update Plex Media Server on Raspbian

# How to
Download this script and run it or create a scheduler task. The script will auto check to see if the current version is lower than the latest and then proceed to update as needed.

This script is configured to use the plex-pass repo. It picks up the plex-token from your plex-installation

### Download Script
SSH in to the rasbian and download this script, via a command like `sudo wget https://github.com/mattiri/plex-update/raw/master/plexupdate.sh`

inspired and based on script by nitantsoni found here - https://github.com/nitantsoni/plexupdate

Original source found here - https://forums.plex.tv/t/script-to-auto-update-plex-on-synology-nas-rev4/479748/36?u=martino
