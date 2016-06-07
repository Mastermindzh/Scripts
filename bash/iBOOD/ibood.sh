title=''
suffix="- Internet's Best Online Offer Daily - iBOOD.com"
windows=1
awesome=1
while [[ "$windows" -eq "$awesome" ]]
do
	var=$(wget -q 'http://www.ibood.com/nl/nl/' -O - | grep -o '<title>.*</title>' | sed 's/\(<title>\|<\/title>\)//g' |sed "s/$suffix$//")
	 if [[ $var != $title ]]
	 then 
		notify-send -i $(pwd)/hunt.png 'New iBOOD sale !, Windows = Awesome' "$var \n http://www.ibood.com/nl/nl/"
		title=$var
	fi 
	sleep 1
done

