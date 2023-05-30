set -u
set -e

number_of_parameter_sets=12

for parameter_set in $(seq 0 $number_of_parameter_sets)
  do
    #WSL
    #python ../source/create_kdu_compress_encode_scripts.py --path_to_kdu_compress_executable /mnt/c/data/consulting/tech/kakadu/kakadu_8.3/v8_3-00462N/bin/Linux-x86-64-gcc/kdu_compress --encoding_parameter_set $parameter_set
    
    #AWS Ubuntu
    python ../source/create_kdu_compress_encode_scripts.py --path_to_kdu_compress_executable kdu_compress --encoding_parameter_set $parameter_set
  done

printf "#!/bin/bash\n" > run_all_encodes.sh
printf "set -u\n" >> run_all_encodes.sh
printf "set -e\n" >> run_all_encodes.sh
for i in encode*.sh; do # Whitespace-safe but not recursive.
    printf "bash $i\n" >> run_all_encodes.sh
done
