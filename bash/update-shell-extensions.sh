#!/bin/bash
# requires: jq
# replaces the shell-version json part in metadata.json for each gnome extension

ver=$(gnome-shell --version | awk '{print $NF}' | cut -d '.' -f -2)
tmp="/tmp/shellupdatejson.json"

echo "shell version: $ver"
echo "writing to temp file: $tmp"
echo "{\"shell-version\": [ \"$ver\" ]}" > $tmp

for ext in $(find ~/.local/share/gnome-shell/extensions/ -name 'metadata.json'); do
	var=$(jq -s '.[0] * .[1]' $ext $tmp)
	echo $var > $ext
done

echo "done"
