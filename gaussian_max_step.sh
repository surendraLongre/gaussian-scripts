#!/bin/bash

output_file="$(echo $1 | cut -d '.' -f1)_max_count.txt"

if ! [ -e $output_file ];
then
touch $output_file;
echo "no previous data" > "$output_file"

fi


#output

tail -2 $output_file
echo -e " ..."
echo " number of lines: $(wc -l $1 | awk '{print $1}')" > $output_file
echo "$(grep maximum $1 | tail -1)" >> $output_file
tail -1 $output_file
sed -n "1p" $output_file
