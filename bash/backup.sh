#!/bin/bash
#
# This script will make periodic backups of your Copy folder and 
# store them in your dropbox
# It will also delete backups older than 7 days

#Source path
SOURCE="/home/$(whoami)/Copy"
#Destination path
DESTINATION="/home/$(whoami)/Dropbox/backups/"
echo $SOURCE
if [ ! -d "$SOURCE" ]; then
	echo "Invalid source directory"
else
	#check wether destination exists, if it doesn't create it
	if [ ! -d "$DESTINATION" ]; then
			mkdir -p $DESTINATION
	fi
	
	tar czf $SOURCE $DESTINATION$(date +%Y-%m-%d)
	find /home/$(whoami)/Dropbox/backups/ -mtime +7 -exec rm {} \;
fi


