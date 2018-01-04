#!/bin/bash

# Check for dotfile updates daily, but only on login

dotFilesDir="$(dirname $(realpath $0))"

checkMarkerFile="$dotFilesDir/checked.marker"

# If the marker file does not exist, create it with 0 as the time
[ -e "$checkMarkerFile" ] || echo 0 > "$checkMarkerFile"

lastCheckedEpoch="$(cat $checkMarkerFile)"
currentEpoch="$(date -u +%s)"

# If the cheked time is less than a day in the past, just exit
[ $[$currentEpoch-$lastCheckedEpoch] -le 86400 ] && exit

echo -n "Checking for dotFile updates... " >&2

preUpdateHash=$(cat "$dotFilesDir/.git/refs/remotes/origin/master")
git --git-dir="$dotFilesDir/.git" fetch 1>&- 2>&-
postUpdateHash=$(cat "$dotFilesDir/.git/refs/remotes/origin/master")

if [ "$preUpdateHash" = "$postUpdateHash" ]; then
    echo "dotFiles already at latest"
else 

git --git-dir="$dotFilesDir/.git" --work-tree="$dotFilesDir" reset --hard origin/master 1>&- 2>&-

echo "dotFiles updated"
fi

# Store the current date as the "Last Checked" time
echo "$currentEpoch" > "$checkMarkerFile"
