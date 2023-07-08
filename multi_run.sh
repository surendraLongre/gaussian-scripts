#!/bin/bash
red=$(tput setaf 1)
bold=$(tput bold)
nc_red=$(tput sgr0)
nc='\033[0m' # reset color
blue=$(tput setaf 4)

if [ $# -gt 0 ];
then

	for files in "$@";
	do
		g16 $files &
	done

	echo "SUCCESSFULL! Your process is running in the background"
else
	echo "${bold}${red}usage:${nc_red} multirun <file>"
	
fi
