#!/bin/bash

#add colors variables
red=$(tput setaf 1)
bold=$(tput bold)
nc_red=$(tput sgr0)
nc='\033[0m' # reset color
blue=$(tput setaf 4)


#add condition to check whether a g16 or g09 command is availabel or not
if command -v g16 >/dev/null 2>&1; then
	g16_avail=0
elif command -v g09 >/dev/null 2>&1; then
	g16_avail=1
else
	echo "command g16 or g09 is not found"
	exit
fi


if [ $# -gt 0 ];
then

	for files in "$@";
	do
		if [ $g16_avail -eq 0 ]; then
			g16 $files &

		else
			g09 $files &
		fi
	done

	echo "SUCCESSFULL! Your process is running in the background"
else
	echo "${bold}${red}usage:${nc_red} multirun <file>"
fi
