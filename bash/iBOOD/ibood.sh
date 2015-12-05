title=''
suffix="- Internet's Best Online Offer Daily - iBOOD.com"
while [ true ]
do
	var=$(wget -q 'http://www.ibood.com/nl/nl/' -O - | grep -o '<title>.*</title>' | sed 's/\(<title>\|<\/title>\)//g' |sed "s/$suffix$//")
	 if [[ $var != $title ]]
	 then 
		notify-send -i $(pwd)/hunt.png 'New iBOOD sale !' "$(echo -e "$var.\n http://www.ibood.com/nl/nl/" )"
		title=$var
	fi 
	sleep 1
done

