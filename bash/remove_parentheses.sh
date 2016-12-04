#!/bin/bash
# will recursively remove ( and ) from all files

for d in /mnt/series/Smallville/*; do
  if [ -d "$d" ]; then
	echo ""
	echo "=> moving to: $d"
    cd "$d"
	for f in *.*; do
		echo "processing: $f"
		des=$(echo "$f" | tr -d '()')
		if [ "$f" != "$des" ]; then
		  mv "$f" "$des"
		fi	
	done    
  fi
done


