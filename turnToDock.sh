#!/usr/bin/env bash
# thanks to Airblader
# https://gist.github.com/Airblader/d4fe0088b05f720fb4a3291cd9ec5e9a
# call like this:
#     /path/to/this/script.sh <window_id> <dock height>

win="${1:-}"
width="${2:-}"
height="${3:-}"
positionDescription="${4:-}"
showHideToggle="${5:-}"
resolutionX=$(xrandr -q | head -n1 | awk '{print $8}');
resolutionY=$(xrandr -q | head -n1 | awk '{print $10}' | cut -d ',' -f 1)
posX=0
posY=0
frameCorrection=2

### Setting default width and height as max resolution
if [[ "$width" == "full" ]]
then
    width=${resolutionX}
fi
if [[ "$height" == "full" ]]
then
    height=${resolutionY}
fi

### Calcuating window position from description
if [[ "$positionDescription" == "right" ]]
then
    posX=$(($resolutionX - $width))
fi

posY=$(($posY-$frameCorrection))

xdotool windowunmap --sync ${win}

xdotool windowsize --sync ${win} ${width} ${height}
xdotool windowmove --sync ${win} ${posX} ${posY}
xprop -id "${win}" -format _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE "_NET_WM_WINDOW_TYPE_DOCK"
xprop -id "${win}" -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
# xprop -id "${win}" -format _NET_WM_STRUT_PARTIAL 32cccccccccccc -set _NET_WM_STRUT_PARTIAL "0,0,${height},0,0,0,0,0,0,${width},0,0"

xdotool windowmap ${win}
echo ${win} > ./dockID
