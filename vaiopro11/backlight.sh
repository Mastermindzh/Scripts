#!/bin/sh
path="/sys/devices/platform/sony-laptop/kbd_backlight"
if [ $(<$path) -eq 1 ]
then
	newval=0
else
	newval=1
fi
echo "$newval" > $path
