#!/bin/bash
VOL=`pulsemixer --get-volume | awk '/[0-9]+/ { print $1 }'`
NVOL=`expr $VOL + 5`
if [[ $NVOL -lt 100 ]]; then
	VOL=$NVOL
	`pulsemixer --set-volume $VOL`
else
	VOL=100
	`pulsemixer --set-volume $VOL`
fi
#volnoti-show $VOL
rumno -v $VOL
