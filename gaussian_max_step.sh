#!/bin/bash

output_file="$(echo $1 | cut -d '.' -f1)_max_count.txt"

#check whether file exist or not
if ! [ -e $1 ];
then
echo "$1 file does not exist"
exit
fi

if ! [ -e $output_file ];
then
touch $output_file;
echo "no previous data" > "$output_file"

fi


#output


echo " $( head -1 $output_file) --> $(wc -l $1 | awk '{print $1}')" 
echo
tail -1 $output_file
echo -e " ..."
echo "$(wc -l $1 | awk '{print $1}')" > $output_file
echo "$(grep maximum $1 | tail -1)" >> $output_file
tail -1 $output_file
