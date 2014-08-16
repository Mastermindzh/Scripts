#!/bin/bash
#test
test=`kalu -m | grep updates | cut -c 1-10 | grep -oE '[0-9]{1,9}'`; if [ $test -gt  0 ] ; then echo "$test" ; else echo "0" ; fi
