#!/bin/bash

if [[ "$#" -ne 1 ]]; then
    echo "Usage ${0} <data set folder>"
    exit 1
fi
src=$1
orig="/data/images/${src}/original"
logs="/data/images/${src}/log"
formats=( "ptiff_lossless" "ptiff_lossy" "htj2k_lossless" "htj2k_lossy" "j2k1_lossless" "j2k1_lossy" )

for fmt in ${formats[@]}; do
    dest=/data/images/$src/$fmt
    /usr/local/src/htj2k/convert/convert.sh $orig $dest $fmt $logs
done
