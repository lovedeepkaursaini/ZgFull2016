#!/bin/bash

postfix=(
    `cat inputs_to_process.txt`
)

rebin=$1
mass=$2
fitModel=$3
dirname=$4

for name in ${postfix[@]}
do
    mkdir info_${mass}_${name}
    echo $name
    echo
    echo "root -x -b -l -q Display_SignalFits.cc\(\"${name}\"\,\"../${dirname}/\",\"\",${mass},${rebin}\) > info_${mass}_${name}/signal${mass}_${name}_sig.log"
    echo
    root -x -b -l -q Display_SignalFits.cc\(\"${name}\"\,\"../${dirname}/\",\"histos_signal-\",${mass},${rebin}\) > info_${mass}_${name}/signal${mass}_${name}_sig.log
    #root -x -b -l -q Display_SignalFits.cc\(\"${name}\"\,\"../${dirname}/\",\"histZg_minitree_mrgd_GluGluSpin0ToZGamma_ZToQQ_W_0-p-014_M_\",${mass},${rebin}\) > info_${mass}_${name}/signal${mass}_${name}_sig.log
    echo
    echo "root -x -b -l -q BackgroundPrediction.c\(\"${name}\",\"../histZg_minitree_mrgd_SP_Run2016BtoH.root\",${rebin},${fitModel},${mass}\) > info_${mass}_${name}/data_${name}_bkg.log"
    #echo
    #root -x -b -l -q BackgroundPrediction.c\(\"${name}\",\"../${dirname}/\",\"../histos_bkg.root\",${rebin},${fitModel},${mass}\) > info_${mass}_${name}/data_${name}_bkg.log
    root -x -b -l -q BackgroundPrediction.c\(\"${name}\",\"../histZg_minitree_mrgd_SP_Run2016BtoH.root\",${rebin},${fitModel},${mass}\) > info_${mass}_${name}/data_${name}_bkg.log
    
done

