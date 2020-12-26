#!/bin/bash

json_file=$1
src_dir=$2
dest_dir=$3

json=$(cat $json_file)

mkdir $dest_dir
cd $src_dir

length=$(echo $json | jq length)

echo "Processed to..."
for i in $( seq 0 $(($length - 1)) );
do
	dir=$(echo $json | jq -r .[$i].dir_id)
	change=$(echo $json | jq -r .[$i].change_name)
	if [ -e $dir ]; then
		mv $dir $change
		mv $change -t ../$dest_dir
		echo "😁 No. $i SUCCESS: Change dir name to "\"${change}\"" from "\"${dir}\""."
	else
	    echo "❌ No.$i FAILED: Cannot find dir "\"${dir}\""."
	fi
done

echo "Completed! 🍺 Well done!"

exit 0