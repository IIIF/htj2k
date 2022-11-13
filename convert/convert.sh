#!/bin/bash

set -u
#set -e
#set -x

if [[ "$#" -lt 4 || ( "${3}" != "ptiff_lossy" && "${3}" != "ptiff_lossless" && "${3}" != "j2k1_lossy" && "${3}" != "j2k1_lossless" && "${3}" != "htj2k_lossy" && "${3}" != "htj2k_lossless") ]]; then
    echo -e "Usage: ${0} <source> <base output path> <output format> <logs_directory> <iterations>\n" \
        "Where:\n"\
        " * <source> is the full path to the source file(s) (glob patterns and directories are allowed), \n" \
        " * <base output path> is the path under which per-format output folders will be created  \n" \
        " * <output format> is one of 'ptiff_lossy', 'ptiff_lossless' 'j2k1_lossy', 'j2k1_lossless', 'htj2k_lossy' or 'htj2k_lossless'\n" \
        " * <logs_directory> is a directory where the timing logs will be stored (note this will only work if you have GNU date installed)\n" \
        " * <iterations> number of iterations. Defaults to 10"
    exit 1
fi

doTiming=false 
if date --version >/dev/null 2>&1 ; then
    # GNU date installed so OK to do timings
    doTiming=true
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

in_ptn=$1
out_base_path=$2
format=$3
logs_directory=$4
echo "Input pattern: ${in_ptn}"
if [[ "$#" -eq 5 ]]; then
    number_of_encode_cycle_iterations=$5
else
    number_of_encode_cycle_iterations=10
fi    

# setup log files
if $doTiming; then
    date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
    log_filename="$logs_directory/$format.${date_for_filename}.log.txt" 

    # write header to log file
    printf "input_filepath,input_filename,width,height,format," > $log_filename
    for encoding_cycle_iteration in $(seq 1 $number_of_encode_cycle_iterations); do
        printf "encode_time_in_seconds_iteration_%d," $encoding_cycle_iteration >> $log_filename 
    done
    printf "encode_time_in_seconds_average,compressed_size_in_bytes\n" >> $log_filename
fi    

for in_path in $in_ptn/*.{tif,TIF}; do
    echo "input image: ${in_path}"
    in_fname=$(basename $in_path)

    echo "Converting $in_fname to $format format..."
    width=$(vipsheader -f Xsize $in_path)
    height=$(vipsheader -f Ysize $in_path)

    if $doTiming; then
        # add initial log entries
        printf "%s,%s,%s,%s,%s," $in_path $in_fname $width $height $format >> $log_filename

        # start timer
        let duration_all_iterations_nanoseconds=0
    fi    
    for encoding_cycle_iteration in $(seq 1 $number_of_encode_cycle_iterations)
    do
        if $doTiming; then
            # start timer
            start_iteration_time=`date +%s%N`    
        fi    

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

        # do the encoding for this iteration
        $cmd

        if $doTiming; then
            end_iteration_time=`date +%s%N` 

            # compute timing stats for the encoding iteration
            let duration_iteration_nanoseconds=$end_iteration_time-$start_iteration_time
            number_of_nanoseconds_in_one_second=1000000000
            duration_iteration_total_seconds=$(echo "scale=5;$duration_iteration_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)

            # print timing of iteration to file
            printf "%s," $duration_iteration_total_seconds >> $log_filename

            duration_all_iterations_nanoseconds=$(($duration_all_iterations_nanoseconds+$duration_iteration_nanoseconds))
        fi
    done
    
    if $doTiming; then
        # compute timing stats for the sequence
        number_of_nanoseconds_in_one_second=1000000000
        encode_time_per_iteration_seconds=$(echo "scale=5;($duration_all_iterations_nanoseconds/$number_of_encode_cycle_iterations)/$number_of_nanoseconds_in_one_second" | bc)

        # print timing of iteration to file
        printf "%s," $encode_time_per_iteration_seconds >> $log_filename

        # get filesize and print to file
        compressed_file_bytes=$(du -sb ${out_path} | cut -f1) 
        printf "compressed_file_bytes = %s\n" $compressed_file_bytes 
        printf "%s\n" $compressed_file_bytes >> $log_filename
    fi
    echo "...Done."
    echo
done


  
# compute timing stats for the sequence
#let duration_job_nanoseconds=$end_job_time-$start_job_time
#number_of_nanoseconds_in_one_second=1000000000
#duration_job_total_seconds=$(echo "scale=5;$duration_job_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)
#encode_time_per_iteration_seconds=$(echo "scale=5;($duration_job_nanoseconds/$number_of_encode_cycle_iterations)/$number_of_nanoseconds_in_one_second" | bc)
  
# get number of bytes for the folder of compressed files
#executing_directory=$(pwd)
#cd $out_base_path
#bytes_in_compressed_folder_with_dot_dir=`du -sb | awk '{print $1}'`
# subtract 4096 for the '.' dir
##let bytes_in_compressed_folder=$bytes_in_compressed_folder_with_dot_dir-4096 
#cd $executing_directory
  
# print results to screen
##printf "%s %s %s seconds %s bytes\n" $in_ptn ${format} $encode_time_per_iteration_seconds $bytes_in_compressed_folder

# add timing info to log

#printf "%s,%s,%s,%s\n" $in_ptn ${format} $encode_time_per_iteration_seconds $bytes_in_compressed_folder >> $log_filename
