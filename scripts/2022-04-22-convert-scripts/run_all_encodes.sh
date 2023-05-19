#!/bin/bash

set -u
#set -e
set -x

bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/ptiff_lossy/GRI/ ptiff_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/ptiff_lossless/GRI/ ptiff_lossless ./build/logs
bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/j2k1_lossy/GRI/ j2k1_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/j2k1_lossless/GRI/ j2k1_lossless ./build/logs
bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/htj2k_lossy/GRI/ htj2k_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/htj2k_lossless/GRI/ htj2k_lossless ./build/logs

bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/ptiff_lossy/Museum/ ptiff_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/ptiff_lossless/Museum/ ptiff_lossless ./build/logs
bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/j2k1_lossy/Museum/ j2k1_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/j2k1_lossless/Museum/ j2k1_lossless ./build/logs
bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/htj2k_lossy/Museum/ htj2k_lossy ./build/logs
bash ./src/convert/convert.sh ./build/original/Museum/ ./build/compressed/htj2k_lossless/Museum/ htj2k_lossless ./build/logs