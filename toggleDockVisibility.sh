#!/usr/bin/env bash

switchState=`cat ./switchState`
dockID=`cat ./dockID`
# echo $switchState
# echo test $switchState="on"
if [[ "$switchState" == "on" ]]
then
    echo "turning off"
    echo "off" > ./switchState
    xdotool windowunmap ${dockID}
else
    echo "turning on"
    echo "on" > ./switchState
    xdotool windowmap ${dockID}
fi
