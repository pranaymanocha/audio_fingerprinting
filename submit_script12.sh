#!/bin/bash                                                                     

#PBS -l nodes=1:ppn=1                                                        
cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

/opt/matlab/8.6/bin/matlab  -nodisplay -r "helper12 ; exit" > $logf
