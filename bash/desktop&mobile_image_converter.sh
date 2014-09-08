#!/bin/bash
echo "Wat voor extentie wordt er gebruikt voor de foto's? *zonder de punt*"
 read -p "" ext
myDir=.
mkdir -p $myDir/mobile/ &
mkdir -p $myDir/desktop/
wait
chmod 777 $myDir/mobile/ &
chmod 777 $myDir/desktop/
wait
mogrify -path "./desktop/" -geometry 600x -format "-desktop.$ext" *.$ext
mogrify -path "./mobile/" -geometry 300x -format "-mobile.$ext" *.$ext
cd ./mobile/

for f in *.$ext; do
        f=${f%.$ext}
        mv -- "${f}.$ext" "${f//./}.$ext"
done

cd ..
cd $myDir/desktop/

for f in *.$ext; do
        f=${f%.$ext}
        mv -- "${f}.$ext" "${f//./}.$ext"
done

echo "Alle foto's zijn succesvol omgezet!"
