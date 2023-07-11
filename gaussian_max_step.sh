#!/bin/bash

#colors
red=$(tput setaf 1)
green=$(tput setaf 2)
bold=$(tput bold)
nc_red=$(tput sgr0)
nc='\033[0m' # reset color
blue=$(tput setaf 4)
output_file="$(echo $1 | cut -d '.' -f1)_max_count.txt"

#check whether file exist or not
if ! [ -e $1 ];
then
echo "$1 file does not exist"
exit
fi

#check if the process has already normally terminated
#tail -1 "$1" | awk '{print $1}' - | if [ "$(cat -)" = 'Normal' ]; then echo "${bold}${green}The process has Normally terminated${nc_red}"; exit 0; fi
result=$(tail -1 "$1" | awk '{print $1}' -)
if [ "$result" = 'Normal' ]; then
  echo "${bold}${green}Normally terminated${nc_red}"
  exit 0
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
