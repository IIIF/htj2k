#!/bin/bash
for i in $(seq 1 10); do
    python scripts/create_kdu_compress_encode_scripts.py --source_directory imgs/50/original --compressed_directory imgs/50/params --logs_directory logs --path_to_kdu_compress ./image_server/kakadu/v8_2_1-02075E/bin/Mac-x86-64-gcc/kdu_compress --output_script_filename_prefix scripts/params/encode --exclude-timing --encoding_parameter_set "$i";
done