#!/bin/bash

# JP2 compression currently used for the Museum images. Use for comparison
# purposes. The '-jp2_space sRGB' parameter has been added recently to deal
# with a color aberration issue, but it is omitted here to replicate exactly
# the legacy behavior.

in_path=$1
out_path=$2

kdu_compress -i $in_path -o $out_path \
    -rate -,2.4,1.48331273,.91673033,.56657224,.35016049,.21641118,.13374944,.08266171  \
    Creversible=yes Clevels=7 "Cblk={64,64}" Cuse_sop=yes \
    Cuse_eph=yes Corder=RLCP ORGgen_plt=yes ORGtparts=R \
    "Stiles={1024,1024}" -double_buffering 10 -num_threads 4 -no_weights \
    -quiet

