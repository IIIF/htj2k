#!/bin/bash

if [[ ( -z "${1}" ) || ( -z "${2}" ) || ( "${3}" != "ptiff" && "${3}" != "jp2" ) ]]; then
    echo -e "Usage: ${0} <source> <base output path> <output format>\n"\
        "Where <source> is the full "\
        "path to the source file(s) (glob patterns and directories are "\
        "allowed), <base output path> is the path under "\
        "which per-format output folders will be created and <output format> "\
        "is one of 'ptiff' or 'jp2'."
    exit 1
fi

in_ptn=$1
out_base_path=$2
format=$3
echo "Input pattern: ${in_ptn}"

for in_path in $in_ptn; do
    echo "input image: ${in_path}"
    in_fname=$(basename $in_path)

    echo "Converting $in_fname to $format format..."

    if [ "${format}" = "ptiff" ]; then
        out_path="${out_base_path}/${in_fname%.*}.tif"
        cmd="./imgconv_ptiff.py ${in_path} ${out_path}"
    else
        out_path="${out_base_path}/${in_fname%.*}.jp2"
        cmd="./tiff_to_jp2.sh ${in_path} ${out_path}"
    fi

    $cmd

    echo "...Done."
    echo
done
