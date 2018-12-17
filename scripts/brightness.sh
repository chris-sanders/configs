#!/bin/bash

delta=$1
current=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
percent=$((max/100))
value=$(($percent * $delta + $current))
if [ $value -gt $max ]
then
    value=$max
fi
if [ $value -lt 0 ]
then
    value=0
fi
echo $value | sudo tee /sys/class/backlight/intel_backlight/brightness
