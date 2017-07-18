#!/bin/bash   







#PBS -l nodes=1:ppn=1                                                           
cd $PBS_O_WORKDIR


/opt/matlab/8.6/bin/matlab  -nodisplay -r "helper8 ; exit"

