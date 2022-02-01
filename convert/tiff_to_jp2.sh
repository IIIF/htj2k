#!/bin/bash

in_path=$1
out_path=$2

kdu_compress -i $in_path -o $out_path Clevels=6 Clayers=6 \
"Cprecincts={256,256},{256,256},{128,128}" "Stiles={512,512}" Corder=RPCL \
ORGgen_plt=yes ORGtparts=R "Cblk={64,64}" -jp2_space sRGB Cuse_sop=yes \
Cuse_eph=yes -flush_period 1024 -rate 3

