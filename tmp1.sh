#!/bin/bash

function show_help { 
    echo "./doLimits.sh [-c to clean up] -r [rebin] [-d debug combine]" 
}
#masses=(600 750 1000 1500 2000 2500 3000 3500)
cleanUp=0
rebin=10
debug=0
dirname=$1

while getopts "h?cr:d" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    r)
        rebin=$OPTARG
        ;;
    d) 
        debug=1
        ;;
    c)  cleanUp=1
        ;;
    esac
done

num=640
mult=10
for m in {1..36}

#num=1300
#for m in {1..236}
do
    expr $num \+ $m \* $mult
    if [ $cleanUp -eq 0 ]; then
        vmass=`expr $num \+ $m \* $mult`
        ./buildInputs.sh $rebin $vmass 0 $dirname
        ./buildDatacards.sh $vmass
        ./runLimits.sh $debug $vmass
    fi

    if [ $cleanUp -eq 1 ]; then
        ./cleanUp.sh $m
    fi
done
