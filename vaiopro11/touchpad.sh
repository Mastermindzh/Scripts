#!/bin/sh
if synclient -l | egrep "TouchpadOff.*=*0" ; then
	synclient TouchpadOff=1 ;
else
	synclient TouchpadOff=0 ;
fi