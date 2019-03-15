#!/bin/bash
# perf_matadd.sh
# Get performance of matadd.s for loop unroll levels

runCount=5
executable="matadd"
output="perf_${runCount}runs.csv"
temp="rawoutput.tmp"
CFLGln=$(grep -n "SRCS =" Makefile | cut -f1 -d:)

printf "Optimization Level, Run Number, Cycles, Instructions, Clock Speed (GHz), Branch Misses, Execution time(s)\n" > $output
for i in 1 2 4 8; do
    echo "Unroll Level $i"
    sed "${CFLGln}s/SRCS = matadd.s/SRCS = matadd_${i}.s/" Makefile > Makefile.tmp && mv Makefile.tmp Makefile
    make --quiet
    for j in $(seq 1 $runCount); do
        echo "Run $j"
        printf "$i, " >> $output
        printf "$j, " >> $output
        perf stat ./$executable > /dev/null 2> $temp
        cat $temp | grep -Po "[0-9,]+(?= *cycles)" | tr -d "," | tr -d "\n" >> $output
        printf ", " >> $output
        cat $temp | grep -Po "[0-9,]+(?= *instructions)" | tr -d "," | tr -d "\n" >> $output
        printf ", " >> $output
        cat $temp | grep -Po "[0-9.]+(?= *GHz)" | tr -d "\n" >> $output
        printf ", " >> $output
        cat $temp | grep -Po "[0-9,]+(?= *branch-misses)" | tr -d "," | tr -d "\n" >> $output
        printf ", " >> $output
        cat $temp | grep -Po "[0-9.]+(?= *seconds)" | tr -d "\n" >> $output
        printf "\n" >> $output
    done
    rm -f $temp
    make --quiet clean
    sed "${CFLGln}s/SRCS = matadd_${i}.s/SRCS = matadd.s/" Makefile > Makefile.tmp && mv Makefile.tmp Makefile
done

