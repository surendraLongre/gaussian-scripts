#!/bin/bash

#add colors
red=$(tput setaf 1)
bold=$(tput bold)
nc_red=$(tput sgr0)
nc='\033[0m' # reset color
blue=$(tput setaf 4)

if [ $# -gt 0 ];
then

for file in "$@";
do

#start the processes from here
script_name="script_$(echo $file | cut -d '.' -f1).sh"
log_name="script_$(echo $file | cut -d '.' -f1).log"

script_sample="#PBS -l walltime=100:00:00
#PBS -l nodes=1:ppn=8
#PBS -l pmem=5120mb
#PBS -q workq
#PBS -nupur_transition_opt_irc_reactant_h

cd \$PBS_O_WORKDIR

mkdir /scratch/\$USER/\$PBS_JOBID/
export g09root=/home/admin/rbs
export GAUSS_EXEDIR=/home/admin/rbs/g09
export GAUSS_SCRDIR=/scratch/\$USER/\$PBS_JOBID/

export PATH=\$GAUSS_EXEDIR:\$PATH

g09 <\"$file\">\"$file.log\"

if [ -d \"\$GAUSS_SCRDIR\" ]; then
rm -r \"\$GAUSS_SCRDIR\"
fi
"
echo "$script_sample" > "$script_name"
qsub "$script_name"
echo "SUCCESSFULL! Your process is running in the background"
done


else
echo "${bold}${red}usage:${nc_red} multirun <file>"

fi
