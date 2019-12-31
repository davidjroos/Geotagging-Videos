###########################################
#                                         #
#    Copy GPS tags from Image to Video    #
#                                         #
###########################################

# in case exiftool is not in your path already
export PATH=/usr/local/bin:$PATH

for arg in "$@"
do
  echo "Recursing into $arg"
	
  #for every .MOV file, find a corresponding .JPG in the current folder to copy geotagging from
  for i in `find "$arg" -type f -iname "*.mov"`
  do
    echo "Processing $i"
    
    name=`echo "$i" | cut -d'.' -f1`
    echo "cleaning up old GPS tags in $i"

    #erase existing GPS tagging (this ensures that if you try to re-tag a video it will actually work)
    exiftool '-gps*=' "$i" -P -overwrite_original_in_place
    exiftool '-Keys:GPSCoordinates=' "$i" -P -overwrite_original_in_place

    #copy tags from xyz123.JPG to xyz123.MOV"
    exiftool -tagsfromfile "${name}.JPG" "-all:all" -filemodifydate "$i" -P -overwrite_original_in_place
    exiftool '-Keys:GPSCoordinates<Composite:GPSPosition' -P -overwrite_original_in_place "$i"
    
    #get rid of the unneded jpeg dummies
    rm -f "${name}.JPG"
  done
done
