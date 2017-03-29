#!/bin/bash
clear
echo ""

h=`date +%H`
MONTHS=(NULL January February March April May June July August September October November December)
DAYS=(NULL Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

# greet user
if [ $h -lt 12 ]; then
  echo "Good morning, $(whoami)!"
elif [ $h -lt 18 ]; then
  echo "Good afternoon, $(whoami)!"
else 
  echo "Good evening, $(whoami)!"
fi

# separator
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

echo "Date: ${DAYS[$(date +%u)]} $(date +%d) ${MONTHS[$(date +%m)]} $(date +%Y)"
echo ""

echo "Ext: $(curl -s http://www.ipecho.net/plain; echo)"

echo "IP : $(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')"

free -m | awk 'NR==2{printf "MEM: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'

df -h | awk '$NF=="/"{printf "HDD: %d/%dGB (%s)\n", $3,$2,$5}'

top -bn1 | grep load | awk '{printf "CPU: %.2f\n", $(NF-2)}' 

echo ""
