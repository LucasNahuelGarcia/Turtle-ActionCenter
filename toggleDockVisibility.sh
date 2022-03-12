#!/usr/bin/env bash

tempFolder="/tmp/turtle-actionCenter"
mkdir $tempFolder

switchStateFile="$tempFolder/switchState"
windowIDFile="$tempFolder/dockID"

switchState=$( cat $switchStateFile )
dockID=$( cat $windowIDFile )

echo $dockID
if [[ "$switchState" == "on" ]]
then
    echo "turning off"
    echo "off" > $switchStateFile
    xdotool windowunmap ${dockID}
else
    echo "turning on"
    echo "on" > $switchStateFile
    xdotool windowmap ${dockID}
fi
