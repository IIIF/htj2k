#!/bin/bash

set -u

in_path=$1
out_path=$2


# layers 1 (default)
# resolutsion 7 (-n)
# -c precincts (-c)
# -EPH end of packet header is this the same as ORCgen_plt?
# Cplex looks to be kakadu specific
# CodeBlockDim 64x64 default
encoding_parameters="-Mode 64 -n 7 -c [256,256],[256,256],[256,256],[256,256],[256,256],[256,256],[256,256],[128,128] -ProgressionOrder RPCL -SOP -EPH -TP R "

grk_compress -i $in_path -o $out_path $encoding_parameters
#$kdu_compress_executable -i $in_path -o $out_path -rate 3 $encoding_parameters

