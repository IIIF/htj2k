#!/bin/bash
set -u
# setup log files
date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
log_filename="../../logs/__compressed_htj2k_lossless_plt_codeblock_64,64_.${date_for_filename}.log.csv"
number_of_decoding_cycle_iterations=5
# create log header
printf "compressed_directory,iiif_urls_filename,number_of_decoding_threads," > $log_filename
for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations); do
  printf "%d," $decoding_cycle_iteration >> $log_filename
done
printf "total_decoding_time_in_seconds
" >> $log_filename
# add compressed directory to log file
printf "\"../../compressed/htj2k_lossless_plt_codeblock_64,64/\"," >> $log_filename
# add iiif_urls_filename to log file
printf "\"../resources/iiif_urls/500.txt\"," >> $log_filename
# add number_of_decoding_threads to log file
printf "\"2\"," >> $log_filename
# start job timer
job_start_time=`date +%s%N`
let duration_all_iterations_nanoseconds=0
# setup decoding iteration loop
for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations)
  do
    # start iteration timer
    start_iteration_time=`date +%s%N`
# do decompression of compressed files according to iiif urls
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00002701.jph -int_region "{0,0}","{514,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00010701.jph -int_region "{0,0}","{468,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00045001.jph -int_region "{0,0}","{617,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00091001.jph -int_region "{0,0}","{286,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00094501.jph -int_region "{0,0}","{592,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00096001.jph -int_region "{0,0}","{686,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00104401.jph -int_region "{0,0}","{452,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00106901.jph -int_region "{0,0}","{473,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00609701.jph -int_region "{0,0}","{785,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00678301.jph -int_region "{0,0}","{566,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00766201.jph -int_region "{0,0}","{631,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00814101.jph -int_region "{0,0}","{646,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00838501.jph -int_region "{0,0}","{646,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_00960601.jph -int_region "{0,0}","{253,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_01109801.jph -int_region "{0,0}","{650,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_01491701.jph -int_region "{0,0}","{485,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_11180401.jph -int_region "{0,0}","{506,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_11257701.jph -int_region "{0,0}","{641,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_13139301.jph -int_region "{0,0}","{500,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_13547101.jph -int_region "{0,0}","{193,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_25326801.jph -int_region "{0,0}","{255,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_31363101.jph -int_region "{0,0}","{702,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_34942401.jph -int_region "{0,0}","{662,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_34954501.jph -int_region "{0,0}","{678,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35448401.jph -int_region "{0,0}","{453,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35533201.jph -int_region "{0,0}","{590,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35594601.jph -int_region "{0,0}","{640,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35817701.jph -int_region "{0,0}","{469,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35822301.jph -int_region "{0,0}","{610,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_35846501.jph -int_region "{0,0}","{698,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36091601.jph -int_region "{0,0}","{652,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36481101.jph -int_region "{0,0}","{701,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36716601.jph -int_region "{0,0}","{609,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36717601.jph -int_region "{0,0}","{477,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36717701.jph -int_region "{0,0}","{680,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_36717901.jph -int_region "{0,0}","{578,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_37049301.jph -int_region "{0,0}","{576,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gm_37199501.jph -int_region "{0,0}","{671,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2001_pr_2_001_mm.jph -int_region "{0,0}","{212,500}" -reduce 6 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2003_r_22_b008_007_mm.jph -int_region "{0,0}","{610,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2011_m_34_001_pm.jph -int_region "{0,0}","{938,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2012_pr_71_pm.jph -int_region "{0,0}","{292,500}" -reduce 6 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2014_pr_24_001_mm.jph -int_region "{0,0}","{225,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2015_r_15_pano_095_098_mm.jph -int_region "{0,0}","{89,500}" -reduce 6 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_2017_pr_14_001_mm.jph -int_region "{0,0}","{608,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_91_m0_025_pm.jph -int_region "{0,0}","{397,500}" -reduce 5 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_950053_b33_ms205_pm.jph -int_region "{0,0}","{7330,500}" -reduce 2 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_96_r_14_b125_002_mm.jph -int_region "{0,0}","{478,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_p840001_ff07_001_mm.jph -int_region "{0,0}","{473,500}" -reduce 4 -num_threads 2
kdu_buffered_expand -i ../../compressed/htj2k_lossless_plt_codeblock_64,64/gri_p850002_b02_f27_001_mm.jph -int_region "{0,0}","{483,500}" -reduce 4 -num_threads 2
    # end iteration timer
    end_iteration_time=`date +%s%N`
# compute timing stats for the decoding iteration
let duration_nanoseconds=$end_iteration_time-$start_iteration_time
number_of_nanoseconds_in_one_second=1000000000
duration_iteration_total_seconds=$(echo "scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)
# print timing of decoding iteration to screen
printf "duration_iteration_total_seconds=%s\n" $duration_iteration_total_seconds
# print timing of decoding iteration to file
printf "%s," $duration_iteration_total_seconds >> $log_filename
  done
# stop job timer
job_end_time=`date +%s%N`
# compute timing stats for the decoding job
let duration_nanoseconds=$job_end_time-$job_start_time
number_of_nanoseconds_in_one_second=1000000000
duration_job_total_seconds=$(echo "scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)
# print timing of decoding to screen
printf "duration_job_total_seconds=%s\n" $duration_job_total_seconds
# print timing of decoding to file
printf "%s\n" $duration_job_total_seconds >> $log_filename
