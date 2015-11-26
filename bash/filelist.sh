#!/bin/bash

#create new file, might use -- flag later
f="list.html"

echo '
<!DOCTYPE html>
  <head>
    <title>Filelist</title>
    <style>
      #wrapper{
	width:100%;
	max-width:960px;
	height:100%;
	overflow:auto;
	margin:auto;
	border: 1px double black;
      }
      img{
	width:100px;
	height:100px;
	border: 1px black;
      }
      h1{
	margin-bottom:5px;
	margin-top:5px;
      }
    </style>
  </head>
  <body>
  <div id="wrapper"><div style = "padding:20px;">
  <h1>File List of:
' >$f
echo `pwd` >> $f
echo '</h1><hr />' >> $f
for x in $(ls)
do

if [ ! -d "$x" ]; then
  if [ "$x" != "list.html" ] && [ "$x" != "filelist.sh" ]; then
    echo "<a href=\"$x\">$x</a></br>" >> $f
  fi  
fi
done

echo '<h1>Gallery</h1><hr>' >>$f;
for img in {*.jpg,*.png,*.JPG,*.PNG}
do
if [ -f "$img" ]; then
   echo "<a href = \"$img\"><img src = \"$img\" alt = \"$var\"/></a>" >> $f
fi
done



echo '</div></div></body></html>' >> $f


