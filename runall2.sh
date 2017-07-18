#!/bin/bash                                                                                                                               

function join_by { local IFS="$1"; shift; echo "$*"; }

#this uses the qsub to submit jobs                                                                                                        

#if [ $# != 2 ];then
#    echo "arg1 - allocType, arg2 - bestClass"
#    exit 1
#fi
#alctyp=$1
#bstcl=$2



#bsub='/home/alnu/bin/tqsub -q hplong'                                                                                                    
errd="errfls14"
log="logfls14"
#jbend="do."$alctyp

#resfil="epsilonLibSvm/accBsdAna/200/results_1_3_0.mat"
#dtfil="epsilonLibSvm/accBsdAna/200/test/test_labels"

declare -a stno=(10 40)
declare -a strtyp=(0 4 10)
declare -a maxpeak=(4 10)
declare -a array4=()
main_main=0
#declare -a nooftimes=(1 1001)
#declare -a start=(1 51)                                                                                                                      
#declare -a strtyp=(1 2 3 4 5 6 8 11)                                                                                                     
#declare -a array=()
#declare -a array1=()
#declare -a array2=()

qsz=long
qsz1=hplong
qsz2=hp
#algtyp=-100
#insmp=-100
#stpsmsz=-100
#mulwt=-100
#sstr=-100

for stn in "${stno[@]}"
do
    #echo $stsz                                                                                                                           
    for sttyp in "${strtyp[@]}"
    do
        for max in "${maxpeak[@]}"
        do
         # for tim in "${nooftimes[@]}"
         # do
          #echo $styp                                                                                                                       
        #jbid=`$bsub -N $evJbnm -e $errPt -o $outPt ./runExFn.sh $dtfile $resfile $bestcl $stsz $styp $alctype $algtyp $inismp $stsmpsz $sstrp $multwt  $logfl`                                                                                                                     
        #echo "./runExFnV2.sh dtfile=$dtfil resfile=$resfil bestcl=$bstcl stsz=$stn styp=$sttyp alctype=$alctyp algtype=$algtyp inismp=$insmp stsmpsz=$stpsmsz sstrp=$sstr multwt=$mulwt logf=$logfl" | qsub -N $evJbnm -e $errPt -o $outPt 
          
        declare -a array=()
        declare -a array1=()
        declare -a array2=()
        declare -a array3=()  
        declare -a array5=()     
        COUNTER=1
        count23=1

        while [ $COUNTER -lt 230001 ]; do
        evJbnm=$stn"."$sttyp"."$max"."$COUNTER
        errPt=$errd/"err."$evJbnm
        outPt=$errd/"out."$evJbnm
        logfl=$log/"log."$evJbnm
        
	if [ $main_main -gt 0 ]; then
	cnt=${#array4[@]}
	for ((i=0;i<cnt;i++)); do
	array5[i]="${array4[i]}.lti.cs.cmu.edu"
	echo "${array5[i]}"
	done


if [ $(($count23 % 4 )) -eq 0 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))

elif [ $(($count23 % 5 )) -eq 1 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))


elif [ $(($count23 % 5 )) -eq 2 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))


elif [ $(($count23 % 5 )) -eq 3 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))


else

OUTPUT="$(qsub -q $qsz -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))
fi
# if [ $(($main_main % 2 )) -eq 0 ]; then
#OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
#main_main=$((main_main+1))
#    else




#OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
#main_main=$((main_main+1))





# fi

#OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
#main_main=$((main_main+1))



#fi




               #    OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"  
            # main_main=$((main_main+1))             
else


if [ $(($count23 % 5 )) -eq 0 ]; then
OUTPUT="$(qsub -q $qsz -N $evJbnm -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))

elif [ $(($count23 % 5 )) -eq 1 ]; then
  
OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))  



elif [ $(($count23 % 5 )) -eq 2 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,st
yp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))


elif [ $(($count23 % 5 )) -eq 3 ]; then

OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,st
yp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))


else
OUTPUT="$(qsub -q $qsz1 -N $evJbnm -W depend=afterany:"$(join_by : "${array5[@]}")" -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
main_main=$((main_main+1))

fi

fi
 #if [ $(($main_main % 2 )) -eq 0 ]; then


 
 #               OUTPUT="$(qsub -q $qsz1 -N $evJbnm -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
 #               main_main=$((main_main+1))
 #else
 #OUTPUT="$(qsub -q $qsz1 -N $evJbnm -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
             #  main_main=$((main_main+1))

      


        # qsub -q $qsz1 -N $evJbnm -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh
        # OUTPUT="$(qsub -q $qsz1 -N $evJbnm -e $errPt -o $outPt -v stnno=$stn,styp=$sttyp,maxp=$max,star=$COUNTER,logf=$logfl submit_script1.sh)"
        # echo "$OUTPUT"
         array+=("$(echo "$OUTPUT" | cut -c1-17)")
         #echo $array 
         let COUNTER=COUNTER+1800
        let count23=count23+1
       done                            
       echo "Hello"   
#array=(a b c d e)
cnt=${#array[@]}
for ((i=0;i<cnt;i++)); do
    array[i]="${array[i]}.lti.cs.cmu.edu"
    echo "${array[i]}"
done      
echo "Hello1"
 # echo "$evJbnm submitted"

#        tLen=${#array[@]}
#echo "Hello" 
# use for loop read all nameservers
#for (( i=0; i<${tLen}; i++ ));

#do
#  echo ${array[$i]}
#done


      #ing=$(join_by : "${array[@]}")`:wq
       # (join_by : "${array[@]}")

        evJbnm="neglet."$main_main
        errPt=$errd/"err."$evJbnm
        outPt=$errd/"out."$evJbnm
        logfl=$log/"log."$evJbnm

 
       OUTPUT1="$(qsub -q $qsz -N neglet -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array[@]}")" -v logf=$logfl submit_script3.sh) "
          array1+=("$(echo "$OUTPUT1" | cut -c1-17)") 
          cnt=${#array1[@]}
for ((i=0;i<cnt;i++)); do
    array1[i]="${array1[i]}.lti.cs.cmu.edu"
    echo "${array1[i]}"
done     
        parse=1
        while [ $parse -lt 300 ]; do

        evJbnm="last_part."$parse
        errPt=$errd/"err."$evJbnm
        outPt=$errd/"out."$evJbnm
        logfl=$log/"log."$evJbnm

# echo "Hello2"



      # parse=2
#if [ $(($parse % 2 )) -eq 0 ]; then



if [ $(($parse % 3 )) -eq 0 ]; then

    OUTPUT2="$(qsub -q $qsz1 -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star=$parse,logf=$logfl submit_script2.sh)"
elif [ $(($parse % 3 )) -eq 1 ]; then
OUTPUT2="$(qsub -q $qsz1 -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star=$parse,logf=$logfl submit_script2.sh)"
else
OUTPUT2="$(qsub -q $qsz -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star=$parse,logf=$logfl submit_script2.sh)"
fi



#OUTPUT2="$(qsub -q $qsz -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star=$parse,logf=$logfl submit_script2.sh)"
#else
#OUTPUT2="$(qsub -q $qsz1 -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star
#=$parse,logf=$logfl submit_script2.sh)"
#fi












  #         OUTPUT2="$(qsub -q $qsz -N last_part -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array1[@]}")" -v stnno=$stn,styp=$sttyp,maxp=$max,star=$parse,logf=$logfl submit_script2.sh)"
       array2+=("$(echo "$OUTPUT2" | cut -c1-17)")
       let parse=parse+5
       done  
       cnt=${#array2[@]}
for ((i=0;i<cnt;i++)); do
    array2[i]="${array2[i]}.lti.cs.cmu.edu"
    echo "${array2[i]}"
done
echo "Hello3"

        evJbnm="last_last."$pmain_main
        errPt=$errd/"err."$evJbnm
        outPt=$errd/"out."$evJbnm
        logfl=$log/"log."$evJbnm



      OUTPUT3="$(qsub -q $qsz -N last_last -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array2[@]}")" -v logf=$logfl submit_script4.sh )"
array3+=("$(echo "$OUTPUT3" | cut -c1-17)")
cnt=${#array3[@]}
for ((i=0;i<cnt;i++)); do
    array3[i]="${array3[i]}.lti.cs.cmu.edu"
    echo "${array3[i]}"
done
echo "Hello4"
   OUTPUT4="$(qsub -q $qsz1 -N remove_all -e $errPt -o $outPt -W depend=afterany:"$(join_by : "${array3[@]}")" -v logf=$logfl submit_script5.sh )"
    
   array4+=("$(echo "$OUTPUT4" | cut -c1-17)")







#     cnt=${#array4[@]}
#for ((i=0;i<cnt;i++)); do
#    array4[i]="${array4[i]}.lti.cs.cmu.edu"
#    echo "${array4[i]}"
#done
#echo "$OUTPUT"
        # array1[0]= $(echo "$OUTPUT" | cut -c1-17 )

         #qsub -q $qsz -W depend=afterany:$array submit_script3.sh
          # done

         # do while loop
        # qsub -q $qsz1 -N $evJbnm -v stnno=$stn,styp=$sttyp,maxp=$max,start=$tim,logf=$logfl -W depend=afterany:array1 submit_script2.sh
        
      done
    done
done

