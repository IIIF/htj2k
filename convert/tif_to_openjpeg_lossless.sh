#!/bin/bash

set -u

in_path=$1
out_path=$2

encoding_parameters="-n 7 -c [256,256],[256,256],[256,256],[256,256],[256,256],[256,256],[256,256],[128,128] -b 64,64 -p RPCL -SOP -TP R -PLT -threads ALL_CPUS"

opj_compress -i $in_path -o $out_path -rate 1 $encoding_parameters
