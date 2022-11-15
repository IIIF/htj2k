#!/bin/sh

export EP=http://iipimage_kdu:8000
scr=`realpath $0`
cwd=`dirname $scr`
export LOCUSTFILE=$cwd/locustfile.py

LOCUST_IMG_DATASET=htj2k_lossless LOCUST_IMG_FORMAT=htj2k.jp2 locust --headless -t 10m -u 1 --csv ${cwd}/kdu_htj2k_lossless -f $LOCUSTFILE -H $EP

LOCUST_IMG_DATASET=htj2k_lossy LOCUST_IMG_FORMAT=htj2k.jp2 locust --headless -t 10m -u 1 --csv ${cwd}/kdu_htj2k_lossy -f $LOCUSTFILE/locustfile.py -H $EP

LOCUST_IMG_DATASET=ptiff_lossless LOCUST_IMG_FORMAT=tif locust --headless -t 10m -u 1 --csv ${cwd}/ptiff_lossless -f $LOCUSTFILE -H $EP

LOCUST_IMG_DATASET=ptiff_lossy LOCUST_IMG_FORMAT=tif locust --headless -t 10m -u 1 --csv ${cwd}/ptiff_lossy -f $LOCUSTFILE -H $EP

LOCUST_IMG_DATASET=j2k1_lossless LOCUST_IMG_FORMAT=jp2 locust --headless -t 10m -u 1 --csv ${cwd}/j2k1_lossless -f $LOCUSTFILE -H $EP

LOCUST_IMG_DATASET=j2k1_lossy LOCUST_IMG_FORMAT=jp2 locust --headless -t 10m -u 1 --csv ${cwd}/j2k1_lossy -f $LOCUSTFILE -H $EP
