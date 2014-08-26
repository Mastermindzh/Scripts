#!/bin/sh
#Arch dependencies: lsof & id3lib
#Ubuntu dependencies: lsof & libid3-tools
apps="vlc totem rhythmbox banshee mplayer gnome-mplayer xnoise"
for app in $apps
do
	pat="([^\w-]$app)"
	if ps ux | grep -P "$pat" | grep -vq grep; then
		program=$app
	else :
	fi
done

while true
do
file=$(lsof -F n -c "$program" | egrep -i "^.*\.(mp3|flac|ogg|m4a|wma|wav)$" | sed 's/^n//g')
if [ ! -z "$file" ]; then
	if [ "$oldfile" = "$file" ];then
		:
	else
		oldfile=$file
		title=$(id3info "$file" | grep "Title" | sed 's/^===.*[:].//g')
		perf=$(id3info "$file" | grep "performer" | sed 's/^===.*[:].//g')
		album=$(id3info "$file" | grep "Album" | sed 's/^===.*[:].//g')
		year=$(id3info "$file" | grep "Year" | sed 's/^===.*[:].//g')
		track=$(id3info "$file" | grep "Track" | sed 's/^===.*[:].//g')
		bitrate=$(id3info "$file" | grep "Bitrate" | sed 's/^===.*[:].//g')
		frequency=$(id3info "$file" | grep "Frequency" | sed 's/^===.*[:].//g')
		if [ -z "$title" ] && [ -z "$perf" ]; then
			echo "No MP3 info"
		else  
			echo "Titel: $title"
			echo "Artiest: $perf"
			echo "Album: $album"
			echo "Jaar: $year"
			echo "Nummer: $track"
			echo "Bitrate: $bitrate"
			echo "Frequentie: $frequency"
			echo ""
		fi
	fi
	else
	echo "Er wordt geen muziek afgespeeld."
fi
sleep 5

done
