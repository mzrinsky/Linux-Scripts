#!/bin/bash

STEP=5
if [[ "$1" != "" ]]; then
	STEP=$1
fi
CURRENT=`xfpm-power-backlight-helper --get-brightness`
MAX=`xfpm-power-backlight-helper --get-max-brightness`
MIN=5
NEXT=$(($CURRENT - $STEP))
if [ $NEXT -lt $MIN ]; then
	NEXT=$MIN
fi
PERCENT=$(($NEXT * 200 / $MAX))
pkexec xfpm-power-backlight-helper --set-brightness $NEXT && rumno -b $PERCENT --bar-overreach-color ff0057ff
