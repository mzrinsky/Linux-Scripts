#!/bin/bash
MUTE=`pulsemixer --get-mute | awk '/[0-9]+/ { print $1 }'`
if [[ $MUTE -lt 1 ]]; then
	MUTE=1
	`pulsemixer --mute`
	rumno -m
else
	VOL=`pulsemixer --get-volume | awk '/[0-9]+/ { print $1 }'`
	pulsemixer --unmute
	rumno -v $VOL
fi
