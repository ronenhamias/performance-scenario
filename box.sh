#!/bin/bash

ACCESS_TOKEN="$1"
BOX_PATH="$2"
FILE="$3"
FOLDER_ID=0
LIMIT=100
OFFSET=0
NEXT_FOLDER_ID=$FOLDER_ID
HEADER="Authorization: Bearer $ACCESS_TOKEN"

echo upload file: $FILE
echo box path: $BOX_PATH

ZIP_FILE=report-$(($(date +%s%N)/1000000)).zip 
zip -r $ZIP_FILE $FILE

STATUS=`curl "https://upload.box.com/api/2.0/files/content" -H "$HEADER" \
	-F parent_id=17045000106  \
	-F filename=@${ZIP_FILE} -i -s | grep HTTP/1.1 | tail -1 | awk {'print $2'}` > /dev/null 


echo $STATUS
	
if [ $STATUS != 201 ]
	then
		ERROR="true"
	else
		echo "upload succcessful"
	fi


if [ "$ERROR" =  "true" ]
then
	echo "upload failed"
	exit 1
fi
