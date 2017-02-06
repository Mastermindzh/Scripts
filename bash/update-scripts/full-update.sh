#!/bin/bash
# USAGE: sudo bash update.sh

# function to print a seperator
printLine(){
	echo ""
	echo ""
	echo "------------"
	echo ""
	echo ""
}

if [[ $EUID -ne 0 ]]; then
   echo "This script has to be run as root" 1>&2
   exit 1
fi

now=$(date +"%Y_%m_%d")
filename=update_$now.txt

# move to the update folder
if [ ! -d "$DIRECTORY" ]; then
	mkdir "./updates"
fi
cd "./updates"

# specify filename in the file
echo $now >> $filename

# print a seperator
printLine >> $filename

# create the file
touch $filename

# run the update and update the update file
sudo apt-get update -y >> $filename

# print a seperator
printLine >> $filename

# run a simulation of the upgrade command
sudo apt-get upgrade --simulate >> $filename

# print a seperator
printLine >> $filename

# run the upgrade and update the update file
sudo apt-get upgrade -y >> $filename

# print a seperator
printLine

# run a simulation of the dist-upgrade command
sudo apt-get dist-upgrade -y --simulate >> $filename

# print a seperator
printLine >> $filename

# run the dist-upgrade and update the update file
sudo apt-get dist-upgrade -y --simulate >> $filename

# print a seperator
printLine >> $filename

# run the dist-upgrade and update the update file
sudo apt-get upgrade -y >> $filename
