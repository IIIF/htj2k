#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../../../
# Now in the project directory

TIME=10m

# HTJ2k
echo "Running htj2k Lossless"
LOCUST_IMG_DATASET=htj2k/lossless LOCUST_IMG_FORMAT=htj2k.jp2 locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/htj2k-lossless

echo "Running htj2k Lossy"
LOCUST_IMG_DATASET=htj2k/lossy LOCUST_IMG_FORMAT=htj2k.jp2 locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/htj2k-lossy

# JP2

echo "Running j2k Lossless"
LOCUST_IMG_DATASET=jp2/lossy LOCUST_IMG_FORMAT=jp2 locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/jp2-lossless

echo "Running j2k Lossy"
LOCUST_IMG_DATASET=jp2/lossless LOCUST_IMG_FORMAT=jp2 locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/jp2-lossy

# pTIFF

echo "Running pTiff Lossless"
LOCUST_IMG_DATASET=ptiff/lossless LOCUST_IMG_FORMAT=tif locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/ptiff-lossless

echo "Running pTiff Lossy"
LOCUST_IMG_DATASET=ptiff/lossy LOCUST_IMG_FORMAT=tif locust --headless -f load_test/locustfile.py -H http://localhost:8000 -t $TIME -u 1 --only-summary --csv $SCRIPT_DIR/data/ptiff-lossy
