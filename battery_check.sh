#!/bin/bash
WARN_PERCENT=15
SUSPEND_PERCENT=5
LOCK_FILE=/tmp/low_battery_warning
BATTERY_LEVEL=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | sed -E 's/^\s+percentage\:\s+//g' | sed -E 's/\%$//g')

if [ $BATTERY_LEVEL -le $WARN_PERCENT ] && [ ! -f $LOCK_FILE ]; then
	echo $BATTERY_LEVEL > $LOCK_FILE
	DISPLAY=:0 dunstify -u critical 'Low Battery!' "The battery level is at ${BATTERY_LEVEL}%"
	mplayer /usr/share/sounds/freedesktop/stereo/suspend-error.oga
fi

if [ $BATTERY_LEVEL -gt $WARN_PERCENT ] && [ -f $LOCK_FILE ]; then
	rm $LOCK_FILE
fi

# systemctl suspend
