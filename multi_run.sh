#!/bin/bash

if [ $# -gt 0 ];
then

	for files in "$@";
	do
		g16 $files &
	done

	echo "SUCCESSFULL! Your process is running in the background"
else
	echo "usage: multirun <file>"
	
fi
