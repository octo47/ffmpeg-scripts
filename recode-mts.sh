#!/bin/sh
HOME=$(dirname $0)
D=$(dirname "$1")
B=$(basename "$1" .MTS)
T="$D/$B.mp4"
exiftool "-DateTimeOriginal>FileModifyDate" "$1"
labelfile=$($HOME/make-date-overlay.sh "$1")
ffmpeg -i "$1" -deinterlace -s hd720 -bf 2 -b 16000k -sameq -ab 256k -y \
	-vf "movie=$labelfile [wm];[in][wm] overlay=W-w-20:H-h-10:1 [out]" \
	"$T"
rm -f $labelfile
if [ \! -s "$T" ]; then
	echo "No file created"
	rm -f "$T"
	exit 1
fi
touch -r "$1" "$D/$B.mp4"

