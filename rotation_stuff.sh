#!/bin/bash
# Auto rotate screen based on device orientation

# Receives input from monitor-sensor (part of iio-sensor-proxy package)
# Screen orientation and launcher location is set based upon accelerometer position
# Launcher will be on the left in a landscape orientation and on the bottom in a portrait orientation
# This script should be added to startup applications for the user

# Clear sensor.log so it doesn't get too long over time
echo '' > /tmp/sensor.log

OUTPUT="eDP-1"

killall -9 monitor-sensor &
sleep 2;
# Launch monitor-sensor and store the output in a variable that can be parsed by the rest of the script
#monitor-sensor >> /tmp/sensor.log 2>&1 &
# why write everything, when we only care about orientation changes..
monitor-sensor | grep --line-buffered 'orientation' >> /tmp/sensor.log 2>&1 &

function set_prop {
	devices=(
		'Wacom HID 50FB Finger touch'
		'Wacom HID 50FB Pen stylus'
		'Wacom HID 50FB Pen eraser'
	)
	pos_matrix=$1
	for device in "${devices[@]}"; do
		xinput set-prop "${device}" --type=float "Coordinate Transformation Matrix" $pos_matrix
	done
}

# Parse output or monitor sensor to get the new orientation whenever the log file is updated
# Possibles are: normal, bottom-up, right-up, left-up
# Light data will be ignored
while inotifywait -e modify /tmp/sensor.log > /dev/null 2>&1; do
	# Read the last line that was added to the file and get the orientation
	ORIENTATION=$(tail -n 1 /tmp/sensor.log | awk 'NF{ print $NF }')
	export DISPLAY=:0

	if [ "$ORIENTATION" == "normal" ] || [ "$ORIENTATION" == "normal)" ]; then
		xrandr --output $OUTPUT --rotate normal &
		set_prop "0 0 0 0 0 0 0 0 0"
		echo 'normal' > /tmp/screen_orientation &
	fi
	if [ "$ORIENTATION" == "bottom-up" ]; then
		xrandr --output $OUTPUT --rotate inverted &
		set_prop "-1 0 1 0 -1 1 0 0 1"
		echo 'inverted' > /tmp/screen_orientation &
	fi
	if [ "$ORIENTATION" == "right-up" ]; then
		xrandr --output $OUTPUT --rotate right &
		set_prop "0 1 0 -1 0 1 0 0 1"
		echo 'right' > /tmp/screen_orientation &
	fi
	if [ "$ORIENTATION" == "left-up" ]; then
		xrandr --output $OUTPUT --rotate left &
		set_prop "0 -1 1 1 0 0 0 0 1"
		echo 'left' > /tmp/screen_orientation &
	fi

done
