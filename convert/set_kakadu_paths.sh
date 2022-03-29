#!/bin/bash
# to use this script to set Kakadu paths temporally, type
# source ./set_kakadu_paths.sh

KAKADU_SDK_DIRECTORY="/mnt/c/data/consulting/tech/kakadu/kakadu_8.2.1/v8_2_1-00462N"

# LD_LIBRARY_PATH may be empty
if [ -z "$LD_LIBRARY_PATH" ]
then
      export LD_LIBRARY_PATH=$KAKADU_SDK_DIRECTORY/lib/Linux-x86-64-gcc
else
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$KAKADU_SDK_DIRECTORY/lib/Linux-x86-64-gcc
fi

export PATH=$PATH:$KAKADU_SDK_DIRECTORY/bin/Linux-x86-64-gcc
