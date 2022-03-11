#!/usr/bin/env bash
# thanks to Airblader
# https://gist.github.com/Airblader/d4fe0088b05f720fb4a3291cd9ec5e9a
# call like this:
#     /path/to/this/script.sh <window_id> <dock height>

win="${1:-}"
width="${2:-}"
height="${3:-}"
positionDescription="${4}"
resolutionX=$(xrandr -q | head -n1 | awk '{print $8}');
resolutionY=$(xrandr -q | head -n1 | awk '{print $10}' | cut -d ',' -f 1)
posX=0
posY=0

### Setting default width and height as max resolution
if [[ "$width" == "0" ]]
then
    width=${resolutionX}
fi
if [[ "$height" == "0" ]]
then
    height=${resolutionY}
fi

### Calcuating window position from description
if [[ "$positionDescription" == "right" ]]
then
    posX=$(($resolutionX - $width))
fi

xdotool windowunmap --sync ${win}
xdotool windowsize --sync ${win} ${width} ${height}
xdotool windowmove --sync ${win} ${posX} ${posY}
xprop -id "${win}" -format _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE "_NET_WM_WINDOW_TYPE_DOCK"
# xprop -id "${win}" -format _NET_WM_STRUT_PARTIAL 32cccccccccccc -set _NET_WM_STRUT_PARTIAL "0,0,${height},0,0,0,0,0,0,${width},0,0"
xdotool windowmap ${win}
