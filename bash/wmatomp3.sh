#!/bin/bash

current_directory=$( pwd )

#remove spaces
for i in *.wma; do mv "$i" `echo $i | tr ' ' '_'`; done

#Rip with Mplayer / encode with LAME
for i in *.wma ;
 do mplayer -vo null -vc dummy -af resample=44100 -ao pcm:waveheader $i && lame -m s audiodump.wav -o $i; 
done

#convert file names
for i in *.wma;
 do mv "$i" "`basename "$i" .wma`.mp3"; 
done

#add spaces as origins (if there are spaces)
for i in *.mp3;
 do mv "$i" "`echo "$i" | tr '_' ' '`"; 
done

rm audiodump.wa
