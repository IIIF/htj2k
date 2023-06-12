#!/bin/bash
mkdir -p ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64
# setup log files
date_for_filename=`date +"%Y-%m-%d-%H-%M-%S_%N"`
log_filename="../../logs/htj2k_lossy_Qfactor_90_codeblock_64,64.${date_for_filename}.log.csv"
# create log header
printf "output_directory,encode_time_in_seconds,compressed_size_in_bytes
" > $log_filename
# add output directory to log file
printf "\"../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64\"," >> $log_filename
# start timer
job_start_time=`date +%s%N`
# do compression of input files
kdu_compress -i ../../source_images/gm_00106901.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00106901.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_34954501.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_34954501.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_11257701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_11257701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00814101.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00814101.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_91_m0_025_pm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_91_m0_025_pm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gm_01491701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_01491701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_35533201.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35533201.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_950053_b33_ms205_pm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_950053_b33_ms205_pm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=10 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=10"
kdu_compress -i ../../source_images/gm_00002701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00002701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00609701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00609701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00104401.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00104401.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gri_2014_pr_24_001_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2014_pr_24_001_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gm_25326801.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_25326801.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gri_2017_pr_14_001_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2017_pr_14_001_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_2011_m_34_001_pm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2011_m_34_001_pm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gm_35594601.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35594601.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_36717901.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36717901.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_35448401.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35448401.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_2012_pr_71_pm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2012_pr_71_pm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=10 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=10"
kdu_compress -i ../../source_images/gm_00678301.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00678301.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gm_36091601.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36091601.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_35817701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35817701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_13139301.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_13139301.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_2001_pr_2_001_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2001_pr_2_001_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=10 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=10"
kdu_compress -i ../../source_images/gm_13547101.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_13547101.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_11180401.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_11180401.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_37049301.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_37049301.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_31363101.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_31363101.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_2015_r_15_pano_095_098_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2015_r_15_pano_095_098_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=10 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=10"
kdu_compress -i ../../source_images/gm_00096001.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00096001.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_36717701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36717701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_36481101.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36481101.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_2003_r_22_b008_007_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_2003_r_22_b008_007_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00094501.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00094501.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_p850002_b02_f27_001_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_p850002_b02_f27_001_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_01109801.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_01109801.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00766201.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00766201.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_36717601.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36717601.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00045001.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00045001.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_37199501.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_37199501.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_34942401.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_34942401.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_p840001_ff07_001_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_p840001_ff07_001_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_36716601.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_36716601.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_35846501.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35846501.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00838501.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00838501.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00010701.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00010701.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_35822301.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_35822301.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gri_96_r_14_b125_002_mm.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gri_96_r_14_b125_002_mm.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
kdu_compress -i ../../source_images/gm_00091001.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00091001.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=9 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=9"
kdu_compress -i ../../source_images/gm_00960601.tif -o ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/gm_00960601.jph Cmodes=HT Creversible=no Qfactor=90 Cblk="{64,64}" Clevels=8 -com "kdu_compress Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{64,64}\" Clevels=8"
# stop timer
job_end_time=`date +%s%N`
# compute timing stats for the encoding
let duration_nanoseconds=$job_end_time-$job_start_time
number_of_nanoseconds_in_one_second=1000000000
duration_total_seconds=$(echo "scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second" | bc)
# print timing of encoding to screen
printf "duration_total_seconds=%s
" $duration_total_seconds
# print timing of encoding to file
printf "%s," $duration_total_seconds >> $log_filename
# get number of bytes for the folder of compressed files
bytes_in_compressed_folder_with_dot_dir=`du -sb ../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64 | awk '{print $1}'`
# subtract 4096 for the '.' dir
let bytes_in_compressed_folder=$bytes_in_compressed_folder_with_dot_dir-4096
# print results to screen
printf "bytes_in_compressed_folder=%s
" $bytes_in_compressed_folder
# add timing info to log
printf "%s
" $bytes_in_compressed_folder >> $log_filename
