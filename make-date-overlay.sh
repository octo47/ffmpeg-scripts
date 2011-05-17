if [ \! -f "$1" ]; then
	echo "usage: make-script file"
	exit 1
fi
videofile=$1
labelfile="/var/tmp/$(uuidgen).gif"

convert -density 120 -background transparent -fill lightblue  \
           -strokewidth 1  -stroke white   -undercolor transparent \
           -size 130x60 -gravity center label:"$(date +%Y-%m-%d --reference="$videofile")" $labelfile
echo $labelfile
