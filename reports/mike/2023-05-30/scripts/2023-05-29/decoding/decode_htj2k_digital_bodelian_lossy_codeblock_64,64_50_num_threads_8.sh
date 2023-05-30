#!/bin/bash
set -u
# setup log files
date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
log_filename="../../logs/__compressed_htj2k_digital_bodelian_lossy_codeblock_64,64_.${date_for_filename}.log.csv"
number_of_decoding_cycle_iterations=5
# create log header
printf "compressed_directory,iiif_urls_filename,number_of_decoding_threads," > $log_filename
for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations); do
  printf "%d," $decoding_cycle_iteration >> $log_filename
done
printf "total_decoding_time_in_seconds
" >> $log_filename
# add compressed directory to log file
printf "\"../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/\"," >> $log_filename
# add iiif_urls_filename to log file
printf "\"../resources/iiif_urls/50.txt\"," >> $log_filename
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
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00002701.jph -int_region "{0,0}","{129,169.1875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00010701.jph -int_region "{0,0}","{117,173.546875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00045001.jph -int_region "{0,0}","{154,123.3125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00091001.jph -int_region "{0,0}","{143,213.640625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00094501.jph -int_region "{0,0}","{148,112.046875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00096001.jph -int_region "{0,0}","{171,123.234375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00104401.jph -int_region "{0,0}","{226,209.875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00106901.jph -int_region "{0,0}","{118,152.34375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00609701.jph -int_region "{0,0}","{196,130.609375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00678301.jph -int_region "{0,0}","{283,189.109375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00766201.jph -int_region "{0,0}","{158,155.0}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00814101.jph -int_region "{0,0}","{161,121.25}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00838501.jph -int_region "{0,0}","{161,121.25}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_00960601.jph -int_region "{0,0}","{127,180.8125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_01109801.jph -int_region "{0,0}","{162,114.375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_01491701.jph -int_region "{0,0}","{121,161.375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_11180401.jph -int_region "{0,0}","{127,158.90625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_11257701.jph -int_region "{0,0}","{160,105.46875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_13139301.jph -int_region "{0,0}","{125,160.171875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_13547101.jph -int_region "{0,0}","{97,182.109375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_25326801.jph -int_region "{0,0}","{128,249.109375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_31363101.jph -int_region "{0,0}","{175,117.265625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_34942401.jph -int_region "{0,0}","{165,104.484375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_34954501.jph -int_region "{0,0}","{169,135.671875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35448401.jph -int_region "{0,0}","{113,173.453125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35533201.jph -int_region "{0,0}","{147,120.296875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35594601.jph -int_region "{0,0}","{160,116.25}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35817701.jph -int_region "{0,0}","{117,176.578125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35822301.jph -int_region "{0,0}","{153,118.53125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_35846501.jph -int_region "{0,0}","{174,124.0625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36091601.jph -int_region "{0,0}","{163,125.09375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36481101.jph -int_region "{0,0}","{175,108.921875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36716601.jph -int_region "{0,0}","{152,124.921875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36717601.jph -int_region "{0,0}","{119,173.328125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36717701.jph -int_region "{0,0}","{170,114.3125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_36717901.jph -int_region "{0,0}","{144,126.4375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_37049301.jph -int_region "{0,0}","{144,134.046875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gm_37199501.jph -int_region "{0,0}","{168,126.921875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2001_pr_2_001_mm.jph -int_region "{0,0}","{212,523.140625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2003_r_22_b008_007_mm.jph -int_region "{0,0}","{152,110.484375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2011_m_34_001_pm.jph -int_region "{0,0}","{235,96.015625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2012_pr_71_pm.jph -int_region "{0,0}","{292,533.390625}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2014_pr_24_001_mm.jph -int_region "{0,0}","{112,246.75}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2015_r_15_pano_095_098_mm.jph -int_region "{0,0}","{89,424.21875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_2017_pr_14_001_mm.jph -int_region "{0,0}","{152,117.078125}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_91_m0_025_pm.jph -int_region "{0,0}","{199,234.375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_950053_b33_ms205_pm.jph -int_region "{0,0}","{458,50}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_96_r_14_b125_002_mm.jph -int_region "{0,0}","{120,142.609375}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_p840001_ff07_001_mm.jph -int_region "{0,0}","{118,155.421875}" -reduce 6 -num_threads 8
kdu_buffered_expand -i ../../compressed/htj2k_digital_bodelian_lossy_codeblock_64,64/gri_p850002_b02_f27_001_mm.jph -int_region "{0,0}","{121,150.21875}" -reduce 6 -num_threads 8
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
