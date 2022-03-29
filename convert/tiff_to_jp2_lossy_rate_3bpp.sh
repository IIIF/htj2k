#!/bin/bash

set -u

in_path=$1
out_path=$2

encoding_parameters="Clayers=1 Clevels=7 Cprecincts={256,256},{256,256},{256,256},{256,256},{256,256},{256,256},{256,256},{128,128} Corder=RPCL Cblk={64,64} Cuse_sop=yes ORGgen_plt=yes ORGtparts=R ORGgen_tlm=8"

kdu_compress -i $in_path -o $out_path -rate 3 $encoding_parameters

