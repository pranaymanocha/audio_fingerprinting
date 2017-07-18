#!/bin/bash


errd="errfls14"
log="logfls14"



        evJbnm="123."
        errPt=$errd/"err."$evJbnm
        outPt=$errd/"out."$evJbnm
        logfl=$log/"log."$evJbnm


qsub -q hplong -N $evJbnm -e $errPt -o $outPt slep.sh
