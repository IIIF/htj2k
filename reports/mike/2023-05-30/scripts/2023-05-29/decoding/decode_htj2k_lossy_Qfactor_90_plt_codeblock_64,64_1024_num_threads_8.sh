#!/bin/bash
set -u
# setup log files
date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
log_filename="../../logs/__compressed_htj2k_lossy_Qfactor_90_plt_codeblock_64,64_.${date_for_filename}.log.csv"
number_of_decoding_cycle_iterations=5
# create log header
printf "compressed_directory,iiif_urls_filename,number_of_decoding_threads," > $log_filename
for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations); do
  printf "%d," $decoding_cycle_iteration >> $log_filename
done
printf "total_decoding_time_in_seconds
" >> $log_filename
# add compressed directory to log file
printf "\"../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/\"," >> $log_filename
# add iiif_urls_filename to log file
printf "\"../resources/iiif_urls/1024.txt\"," >> $log_filename
# add number_of_decoding_threads to log file
printf "\"8\"," >> $log_filename
# start job timer
job_start_time=`date +%s%N`
let duration_all_iterations_nanoseconds=0
# setup decoding iteration loop
for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations)
  do
    # start iteration timer
    start_iteration_time=`date +%s%N`
# do decompression of compressed files according to iiif urls
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00002701.jph -int_region "{0,0}","{1028,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00010701.jph -int_region "{0,0}","{936,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00045001.jph -int_region "{0,0}","{1233,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00091001.jph -int_region "{0,0}","{572,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00094501.jph -int_region "{0,0}","{1185,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00096001.jph -int_region "{0,0}","{1372,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00104401.jph -int_region "{0,0}","{904,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00106901.jph -int_region "{0,0}","{946,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00609701.jph -int_region "{0,0}","{1570,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00678301.jph -int_region "{0,0}","{1132,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00766201.jph -int_region "{0,0}","{1262,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00814101.jph -int_region "{0,0}","{1291,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00838501.jph -int_region "{0,0}","{1291,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_00960601.jph -int_region "{0,0}","{1014,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_01109801.jph -int_region "{0,0}","{1299,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_01491701.jph -int_region "{0,0}","{970,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_11180401.jph -int_region "{0,0}","{1013,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_11257701.jph -int_region "{0,0}","{1282,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_13139301.jph -int_region "{0,0}","{1000,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_13547101.jph -int_region "{0,0}","{387,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_25326801.jph -int_region "{0,0}","{511,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_31363101.jph -int_region "{0,0}","{1403,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_34942401.jph -int_region "{0,0}","{1324,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_34954501.jph -int_region "{0,0}","{1356,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35448401.jph -int_region "{0,0}","{906,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35533201.jph -int_region "{0,0}","{1179,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35594601.jph -int_region "{0,0}","{1280,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35817701.jph -int_region "{0,0}","{938,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35822301.jph -int_region "{0,0}","{1221,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_35846501.jph -int_region "{0,0}","{1396,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36091601.jph -int_region "{0,0}","{1303,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36481101.jph -int_region "{0,0}","{1402,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36716601.jph -int_region "{0,0}","{1218,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36717601.jph -int_region "{0,0}","{953,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36717701.jph -int_region "{0,0}","{1360,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_36717901.jph -int_region "{0,0}","{1156,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_37049301.jph -int_region "{0,0}","{1153,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gm_37199501.jph -int_region "{0,0}","{1342,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2001_pr_2_001_mm.jph -int_region "{0,0}","{424,1024}" -reduce 5 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2003_r_22_b008_007_mm.jph -int_region "{0,0}","{1220,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2011_m_34_001_pm.jph -int_region "{0,0}","{1876,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2012_pr_71_pm.jph -int_region "{0,0}","{585,1024}" -reduce 5 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2014_pr_24_001_mm.jph -int_region "{0,0}","{450,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2015_r_15_pano_095_098_mm.jph -int_region "{0,0}","{178,1024}" -reduce 5 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_2017_pr_14_001_mm.jph -int_region "{0,0}","{1215,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_91_m0_025_pm.jph -int_region "{0,0}","{794,1024}" -reduce 4 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_950053_b33_ms205_pm.jph -int_region "{0,0}","{14660,1024}" -reduce 1 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_96_r_14_b125_002_mm.jph -int_region "{0,0}","{956,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_p840001_ff07_001_mm.jph -int_region "{0,0}","{947,1024}" -reduce 3 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_lossy_Qfactor_90_plt_codeblock_64,64/gri_p850002_b02_f27_001_mm.jph -int_region "{0,0}","{966,1024}" -reduce 3 -num_threads 8
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
