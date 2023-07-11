#!/bin/bash

#colors
red=$(tput setaf 1)
green=$(tput setaf 2)
bright_yellow=$(tput setaf 11)
bright_cyan=$(tput setaf 14)
bold=$(tput bold)
nc_red=$(tput sgr0)
nc='\033[0m' # reset color
blue=$(tput setaf 4)

#write a for loop for more than one file

	if [ $# -gt 0 ];
	then

	for file in "$@";
	do
#check whether file exist or not
	if ! [[ -e $file && $(echo $file | cut -d '.' -f2) = 'log' ]];
	then
	echo "${red}$file does not exist or file extension is not .log${nc_red}"
	exit
	fi

#check if the process has already normally terminated
#tail -1 "$file" | awk '{print $file}' - | if [ "$(cat -)" = 'Normal' ]; then echo "${bright_yellow}The process has Normally terminated${nc_red}"; exit 0; fi
	result=$(tail -1 "$file" | awk '{print $1}' -)
	output_file="$(echo $file | cut -d '.' -f1)_max_count.txt"
	if [ "$result" = 'Normal' ]; then
	echo "${bold}${bright_cyan} $file${nc_red}"
	echo "${bold}${bright_cyan} Normally terminated${nc_red}"
	echo
	continue
	fi

#step3: check if file does not exist
	if ! [ -e $output_file ];
	then
	touch $output_file;
	echo "no previous data" > "$output_file"
	fi

#output

	echo "${bold}${bright_yellow} $file${nc_red}"
	echo " $( head -1 $output_file) --> $(wc -l $file | awk '{print $1}')" 
	tail -1 $output_file
	echo -e " ..."
	echo "$(wc -l $file | awk '{print $1}')" > $output_file
	echo "$(grep maximum $file | tail -1)" >> $output_file
	tail -1 $output_file
	echo

	done
	fi
