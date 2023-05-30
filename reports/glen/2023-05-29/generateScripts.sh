#!/bin/bash
DATA_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=`cd $DATA_DIR/../../../; pwd`
output_img="$SCRIPT_DIR/imgs/50/params2"
if [ ! -d "$DATA_DIR/scripts" ]; then
    mkdir "$DATA_DIR/scripts"
fi
if [ ! -d $output_img ]; then
    mkdir "$output_img"
fi

for i in $(seq 0 11); do
    python $SCRIPT_DIR/scripts/create_kdu_compress_encode_scripts.py --source_directory $SCRIPT_DIR/imgs/50/original --compressed_directory $output_img --logs_directory logs --path_to_kdu_compress $SCRIPT_DIR/image_server/kakadu/v8_2_1-02075E/bin/Mac-x86-64-gcc/kdu_compress --output_script_filename_prefix $DATA_DIR/scripts/encode --exclude-timing --encoding_parameter_set $i;
done