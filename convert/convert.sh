#!/bin/bash

if [[ ( -z "${1}" ) || ( -z "${2}" ) || ( "${3}" != "ptiff" && "${3}" != "jp2" && "${3}" != "jp2_legacy" ) ]]; then
    echo "Usage: ${0} <source> <base output path> <output format>\n"\
        "Where <source> is the full "\
        "path to the source file(s) (glob patterns and directories are "\
        "allowed, enclosed in quotes), <base output path> is the path under "\
        "which per-format output folders will be created and <output format> "\
        "is one of 'ptiff', 'jp2' or 'jp2_legacy'."
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
        out_path="${out_base_path}/ptiff/${in_fname%.*}.tif"
        cmd="./tiff_to_pyramid.sh /tmp ${in_path} ${out_path}"
    elif [ "${format}" = "jp2_legacy" ]; then
        out_path="${out_base_path}/jp2_legacy/${in_fname%.*}.jp2"
        cmd="./tiff_to_jp2_legacy.sh ${in_path} ${out_path}"
    else
        out_path="${out_base_path}/jp2/${in_fname%.*}.jp2"
        cmd="./tiff_to_jp2.sh ${in_path} ${out_path}"
    fi

    $cmd

    echo "...Done."
    echo
done
