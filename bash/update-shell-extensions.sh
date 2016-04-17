#!/bin/bash
# requires: jq
# replaces the shell-version json part in metadata.json for each gnome extension

jqver=$(jq --version)
if [ $? -eq 0 ]; then
    echo "jq seems to be installed. will continue.."
else
    exit 0
fi

ver=$(gnome-shell --version | awk '{print $NF}' | cut -d '.' -f -2)
tmp="/tmp/shellupdatejson.json"

echo "shell version: $ver"
echo "writing to temp file: $tmp"
echo "{\"shell-version\": [ \"$ver\" ]}" > $tmp

for ext in $(find ~/.local/share/gnome-shell/extensions/ -name 'metadata.json'); do
	cp "$ext" "`echo $ext | rev | cut -c 5- | rev`bak"
	var=$(jq -s '.[0] * .[1]' $ext $tmp)
	echo $var > $ext
done

echo "removing tmp file...."
rm $tmp

echo "done"
