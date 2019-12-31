#######################################################################
#                                                                     #
#    Generate Images for tagging and load them with neccesary tags    #
#                                                                     #
#######################################################################

# in case exiftool is not in your path already
export PATH=/usr/local/bin:$PATH

for arg in "$@"
do
	echo "Recursing into $arg"
	
	#extract images from all .MOV files in the current folder to use for geotagging
	for i in `find "$arg" -type f -iname "*.mov"`
	do
		echo "Processing $i"
		
		#get the base filename of the current file
		name=`echo "$i" | cut -d'.' -f1`
		
		#Get a frame from 3 seconds in
		ffmpeg -i "$i" -ss 00:00:03.000 -vframes 1 "${name}.JPG"
		
		#this step is ONLY for my specific X100f issues with MacOS Photos not picking up the information from other tags, only uncomment if you are sure
		#exiftool '-Keys:CreationDate<System:FileModifyDate' '-Keys:Make<IFD0:Make' '-Keys:Model<IFD0:Model' -P -overwrite_original_in_place "$i"
		
		#clone the existing tags from the movie file into the jpeg (as well as modify date, just in case)
		exiftool -tagsfromfile "$i" "-all:all" -filemodifydate "${name}.JPG" -P -overwrite_original_in_place
	done
done

#a nice friendly confirmation toast
osascript -e 'display notification "Ready for geotagging" with title "Process Complete"'

# Now go geotag these newly generated photos in HoudahGeo or whatever
