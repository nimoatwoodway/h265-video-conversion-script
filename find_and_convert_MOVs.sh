#!/usr/local/bin/zsh

# by chris@wunderwerk.io
# finds *.MOV files and convert them to HEVC aka h265 mov files.
# Preserve all Apple needed meta data to work with Apple Photos.
# usage: ./find_and_convert.sh /filepath/to/start/searching

filePath=$1
echo $filePath

ffmpegSettings="-stats -probesize 50M -analyzeduration 100M -y -ignore_unknown -map_metadata 0 -map 0:0 -map 0:1 -c:a aac -b:a 384k -strict -2 -c:s copy -c:v libx265 -tune grain -tag:v hvc1 -preset medium -level 4.2 -crf 27 -x265-params deblock=-1,-1"

findString="*.MOV"

#execute find and do the converting
find $filePath -type f -name $findString -exec sh -c 'x="{}"; /usr/local/bin/ffmpeg -i {} '$ffmpegSettings' -f mov "${x%.MOV}.h265.mov" && touch -r {} "${x%.MOV}.h265.mov" && rm {}' \;
