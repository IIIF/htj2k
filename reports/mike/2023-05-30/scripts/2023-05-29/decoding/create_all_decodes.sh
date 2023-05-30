set -u
set -e

compressed_directory='../../compressed'
iiif_urls_directory='../resources/iiif_urls'

num_threads_list=(1 2 4 8 16)

for compressed_subdir in $compressed_directory/*; # Whitespace-safe but not recursive.
  do
    printf "compressed_subdir = %s\n" $compressed_subdir
    compressed_subdir_base=$(basename "$compressed_subdir")
    printf "compressed_subdir_base = %s\n" $compressed_subdir_base
    
    # if the compressed directory starts with h, that means it is htj2k not j2k1, set file extension accordingly
    if [[ $compressed_subdir_base = h* ]]
    then
	    compressed_file_extension=".jph"
    else
	    compressed_file_extension=".jp2"
    fi


    for iiif_urls in $iiif_urls_directory/*.txt; # Whitespace-safe but not recursive.
      do
        printf "iiif_urls = %s\n" $iiif_urls
        iiif_urls_base=$(basename "$iiif_urls" .txt)
        printf "iiif_urls_base = %s\n" $iiif_urls_base

        for num_threads in ${num_threads_list[@]}
          do

            output_script_filename=decode_${compressed_subdir_base}_${iiif_urls_base}_num_threads_${num_threads}.sh

            python ../source/convert_iiif_urls_to_kdu_buffered_expand.py --compressed_directory $compressed_subdir/ --compressed_file_extension $compressed_file_extension --iiif_urls_filename $iiif_urls --number_of_decoding_threads $num_threads --output_script_filename $output_script_filename

          done
      done  
      
  done

printf "#!/bin/bash\n" > run_all_decodes.sh
printf "set -u\n" >> run_all_decodes.sh
#printf "set -e\n" >> run_all_decodes.sh
for i in decode*.sh; do # Whitespace-safe but not recursive.
    NEWLINE='\\n'
    printf "printf \"running $i $NEWLINE\"\n" >> run_all_decodes.sh
    printf "source $i\n" >> run_all_decodes.sh
done

exit


