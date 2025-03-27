#!/bin/bash
VOL=`pulsemixer --get-volume | awk '/[0-9]+/ { print $1 }'`
NVOL=`expr $VOL - 5`
if [[ "$NVOL" -gt 0 ]]; then
	VOL=$NVOL
	`pulsemixer --set-volume $VOL`
else
	VOL=0
	`pulsemixer --set-volume $VOL`
fi
rumno -v $VOL
