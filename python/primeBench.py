# primeBench.py
# Version 0.1
# Description
#	PyPi is a set of python benchmarks to test a python capable device's speed.
#
# Usage:
#	python2 primeBench.py 100
#	# replace 100 with desired upper limit
#

# we need some stuff first
import datetime, sys, math, time
 
# Function to print message
def print_result(x):
  print "Prime = %d" %x

# Function to print an empty line
def emptyline():
	print ""
 
# Function to search for prime numbers
#
# Trial division explanation
#   1. Start with your number and an empty list.
#   2. Let the new divisor be the smallest whole number bigger than 1   
#      you haven't yet used.
#   3. Divide the number by the divisor.
#   4. If it doesn't go in evenly, go back to step 2.
#   5. It it does go in evenly, write down the divisor in the list.
#   6. Replace your number with the quotient you got in step 3.
#   7. If the new number is 1, stop.
#   8. Go back to step 3.
#
# More info: http://mathforum.org/library/drmath/view/58851.html
def count_primes(upper_limit):
	count = 1     					# start with 1 prime because 2 is always a prime
	candidate = 3 					# start at 3, only even prime = 2
	upper_limit = upper_limit -1  	# -1 because we already know the first prime to be 2
	print_result(2)					# 2 is the only even prime, print it.

	while(candidate <= upper_limit):
		trial_divisor = 2
		prime = 1
		while(trial_divisor**2 <= candidate):
			if(candidate%trial_divisor == 0):
				prime = 0
			trial_divisor+=1
		if(prime):
			count += 1
			print_result(candidate)
		candidate += 2 	# only odd numbers so +2
	return count 		# return number of primes found
  
  
  
# Script start
# if an argument has been passed use that, if not use 100.000 as upper limit
if len(sys.argv) != 2:
  upper_limit=100000
else:
  upper_limit=int(sys.argv[1])
 
# Record the current time (starting time)
startTime = datetime.datetime.now()
 
# Start the process
emptyline()
print "Starting with an upper limit of: %d in 3 sec" %(upper_limit)
time.sleep(3)
emptyline()
count = count_primes(upper_limit)
emptyline()
 
# Measure and print the elapsed time
elapsed=datetime.datetime.now()-startTime
print " Found %d primes in %s" %(count,elapsed)
emptyline()
