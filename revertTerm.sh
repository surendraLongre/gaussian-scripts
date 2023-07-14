#!/bin bash

#get the currently running jobs
cjobs="$(echo $(ps -ef | grep g16 | grep .com | awk '{print $NF}' ))"
cjpath=~/'currentJobs.txt'
error_path=~/'error_in_multirun_process.txt'


#check if the currently running jobs exists in the currentJobs file, if not append them to the currentJobs file
#for file in $cjobs;
#do
#	if ! grep "$file" ~/currentJobs.txt >/dev/null;
#	then
#		echo "$file">>$cjpath
#	fi
#done


#check if the jobs in the jobsfile are not running
for file in $(cat $cjpath);
do

	log_name="$(echo $file | cut -d '.' -f1).log"
	echo $log_name
# if the job already running don't do anything
	if grep -qz "$file" <<< $cjobs>/dev/null;
	then
		echo "$file running" 
#check if the process had any error
#if it had delete from the cjpath file and store error in erorr file
	elif grep "Error termination" "$log_name" >/dev/null;
	then
		sed -i "/$file/d" ~/currentJobs.txt
		echo -e "error: \t$file">>$error_path
		echo 'error terminated'
#check if process terminated normally
#then delte it from the cjobs
	elif grep "Normal termination" "$log_name" >/dev/null;
	then
		sed -i "/$file/d" ~/currentJobs.txt
		echo 'normally terminated'
# else rerun the process
	else
#if opt=restart not exsits in the file then add it
		if grep -v 'opt=restart' "$file">/dev/null;
		then
			sed -i 's/opt/opt=restart/g' "$file"

		fi
#rerun the process
		multirun "$file"
		echo "$file is running"
	fi

done



#echo ''>$cjpath
#for line in $cjobs;
#do
#	echo $line>>~/currentJobs.txt
#done
#sed -i '/^$/d' ~/currentJobs.txt


#if process gets terminated change opt to otp=restart in the .com file




################################################################################
#to delete a file
#sed -i '/migratory_inserted.com/d' ~/currentJobs.txt
