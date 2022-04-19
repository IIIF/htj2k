#!/bin/bash

set -u
#set -e
set -x

if [[ ( -z "${1}" ) || ( -z "${2}" ) || ( "${3}" != "ptiff_lossy" && "${3}" != "ptiff_lossless" && "${3}" != "j2k1_lossy" && "${3}" != "j2k1_lossless" && "${3}" != "htj2k_lossy" && "${3}" != "htj2k_lossless") ]]; then
    echo -e "Usage: ${0} <source> <base output path> <output format> <logs_directory>\n"\
        "Where <source> is the full "\
        "path to the source file(s) (glob patterns and directories are "\
        "allowed), <base output path> is the path under "\
        "which per-format output folders will be created and <output format> "\
        "is one of 'ptiff_lossy', 'ptiff_lossless' 'j2k1_lossy', 'j2k1_lossless', 'htj2k_lossy' or 'htj2k_lossless'."
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

in_ptn=$1
out_base_path=$2
format=$3
logs_directory=$4
echo "Input pattern: ${in_ptn}"

number_of_encode_cycle_iterations=5

# setup log files
date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
log_filename="$logs_directory/$format.${date_for_filename}.log.txt" 

# write header to log file
printf "in_ptn,format,encode_time_seconds,bytes_in_compressed_folder\n" > $log_filename

# start timer
start_job_time=`date +%s%N`

for in_path in $in_ptn/*.tif; do
    echo "input image: ${in_path}"
    in_fname=$(basename $in_path)

    echo "Converting $in_fname to $format format..."

    for encoding_cycle_iteration in $(seq 1 $number_of_encode_cycle_iterations)
    do
        if [ "${format}" = "ptiff_lossy" ]; then
            out_path="${out_base_path}/${in_fname%.*}.tif"
            cmd="$SCRIPT_DIR/tiff_to_ptiff_lossy_jpeg_Q90.sh ${in_path} ${out_path}"

        elif [ "${format}" = "ptiff_lossless" ]; then
            out_path="${out_base_path}/${in_fname%.*}.tif"
            cmd="$SCRIPT_DIR/tiff_to_ptiff_lossless.sh  ${in_path} ${out_path}"
            
        elif [ "${format}" = "j2k1_lossy" ]; then
            out_path="${out_base_path}/${in_fname%.*}.jp2"
            cmd="$SCRIPT_DIR/tiff_to_jp2_lossy_rate_3bpp.sh ${in_path} ${out_path}"
        
        elif [ "${format}" = "j2k1_lossless" ]; then
            out_path="${out_base_path}/${in_fname%.*}.jp2"
            cmd="$SCRIPT_DIR/tiff_to_jp2_lossless.sh ${in_path} ${out_path}"

        elif [ "${format}" = "htj2k_lossy" ]; then
            out_path="${out_base_path}/${in_fname%.*}.htj2k.jp2"
            cmd="$SCRIPT_DIR/tiff_to_htj2k_lossy_rate_3bpp.sh ${in_path} ${out_path}"

        elif [ "${format}" = "htj2k_lossless" ]; then
            out_path="${out_base_path}/${in_fname%.*}.htj2k.jp2"
            cmd="$SCRIPT_DIR/tiff_to_htj2k_lossless.sh ${in_path} ${out_path}"

        fi

    done

    $cmd

    echo "...Done."
    echo
done

end_job_time=`date +%s%N`
  
# compute timing stats for the sequence
let duration_job_nanoseconds=$end_job_time-$start_job_time
number_of_nanoseconds_in_one_second=1000000000
duration_job_total_seconds=$(echo "scale=5;$duration_job_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)
encode_time_per_iteration_seconds=$(echo "scale=5;($duration_job_nanoseconds/$number_of_encode_cycle_iterations)/$number_of_nanoseconds_in_one_second" | bc)
  
# get number of bytes for the folder of compressed files
executing_directory=$(pwd)
cd $out_base_path
bytes_in_compressed_folder_with_dot_dir=`du -sb | awk '{print $1}'`
# subtract 4096 for the '.' dir
let bytes_in_compressed_folder=$bytes_in_compressed_folder_with_dot_dir-4096 
cd $executing_directory
  
# print results to screen
printf "%s %s %s seconds %s bytes\n" $in_ptn ${format} $encode_time_per_iteration_seconds $bytes_in_compressed_folder

# add timing info to log

printf "%s,%s,%s,%s\n" $in_ptn ${format} $encode_time_per_iteration_seconds $bytes_in_compressed_folder >> $log_filename
