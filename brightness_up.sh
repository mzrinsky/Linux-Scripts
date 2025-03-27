#!/bin/bash

STEP=5
if [[ "$1" != "" ]]; then
	STEP=$1
fi
MAX=`xfpm-power-backlight-helper --get-max-brightness`
CURRENT=`xfpm-power-backlight-helper --get-brightness`
NEXT=$(($CURRENT + $STEP))
if [[ $NEXT -gt $MAX ]]; then
	NEXT=$MAX
fi
PERCENT=$(($NEXT * 200 / $MAX))
pkexec xfpm-power-backlight-helper --set-brightness $NEXT && rumno -b $PERCENT --bar-overreach-color ff0057ff
