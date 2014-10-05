#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import Tkinter as tk
import termios, fcntl, sys, os
fd = sys.stdin.fileno()
oldterm = termios.tcgetattr(fd)
newattr = termios.tcgetattr(fd)
newattr[3] = newattr[3] & ~termios.ICANON & ~termios.ECHO
termios.tcsetattr(fd, termios.TCSANOW, newattr)
oldflags = fcntl.fcntl(fd, fcntl.F_GETFL)
fcntl.fcntl(fd, fcntl.F_SETFL, oldflags | os.O_NONBLOCK)
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

# method to turn a light on or off
def flip ( i ):
	if GPIO.input(i) == 1:
		GPIO.output(i, GPIO.LOW)
	else:
		GPIO.output(i, GPIO.HIGH)

# init list with pin numbers
pinList = [2, 3, 4, 17, 27, 22, 10, 9]
# loop through pins and set mode and state to 'low'

for i in pinList: 
    GPIO.setup(i, GPIO.OUT) 
    GPIO.output(i, GPIO.HIGH)
    
try:
    while 1:
        try:
            c = sys.stdin.read(1)
            if c == 'w': flip(9)#9 is the first relay
            elif c == 'r': flip(10)#10 is the second relay
            elif c == 'g': flip(22)#22 is the third relay
        except IOError: pass
		
finally:
    termios.tcsetattr(fd, termios.TCSAFLUSH, oldterm)
    fcntl.fcntl(fd, fcntl.F_SETFL, oldflags)

# Reset GPIO settings
GPIO.cleanup()


