#!/bin/bash
# Will generate a list of current updates
# Usage: bash generate-update-list.sh

if [[ $EUID -ne 0 ]]; then
  echo "This script has to be run as root" 1>&2
  exit 1
fi

# set variable with date
now=$(date +"%Y_%m_%d")
filename=update-list_$now.txt

touch $filename

# append update list
sudo apt-get dist-upgrade -y --simulate | grep "Inst" | awk -F " " {'print $2'} >> $filename

# message
echo "$filename created."
