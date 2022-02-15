#!/bin/bash

set -u

in_path=$1
out_path=$2

export LD_LIBRARY_PATH=/mnt/c/data/consulting/tech/kakadu/kakadu_8.2.1/v8_2_1-00462N/lib/Linux-x86-64-gcc
kdu_compress_executable=/mnt/c/data/consulting/tech/kakadu/kakadu_8.2.1/v8_2_1-00462N/bin/Linux-x86-64-gcc/kdu_compress

encoding_parameters="Clayers=1 Clevels=7 Cprecincts={256,256},{256,256},{256,256},{256,256},{256,256},{256,256},{256,256},{128,128} Corder=RPCL Cblk={64,64} Cuse_sop=yes ORGgen_plt=yes ORGtparts=R ORGgen_tlm=8 Cmodes=HT Cplex={6,EST,0.25,-1}"

$kdu_compress_executable -i $in_path -o $out_path -rate 3 $encoding_parameters

