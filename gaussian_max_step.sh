#!/bin/bash

output_file="$(echo $1 | cut -d '.' -f1)_max_count.txt"

if ! [ -e $output_file ];
then
touch $output_file;
echo "no previous data" > "$output_file"

fi


#output

tail -1 $output_file
echo -e " ...  "
grep maximum $1 > $output_file 
tail -1 $output_file
