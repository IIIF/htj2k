#!/bin/bash

set -u
set -e
set -x

bash ./src/convert/convert.sh ./build/test/ ./build/compressed/ptiff_lossy/ ptiff_lossy ./build/logs
bash ./src/convert/convert.sh ./build/test/ ./build/compressed/ptiff_lossless/ ptiff_lossless ./build/logs
bash ./src/convert/convert.sh ./build/test/ ./build/compressed/j2k1_lossy/ j2k1_lossy ./build/logs
bash ./src/convert/convert.sh ./build/test/ ./build/compressed/j2k1_lossless/ j2k1_lossless ./build/logs
bash ./src/convert/convert.sh ./build/test/ ./build/compressed/htj2k_lossy/ htj2k_lossy ./build/logs
bash ./src/convert/convert.sh ./build/test/ ./build/compressed/htj2k_lossless/ htj2k_lossless ./build/logs