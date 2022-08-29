#!/bin/bash

cur_dir=`pwd`
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../../image_server/kakadu/v8_2_1-02075E/
KDU_HOME=`pwd`

export PATH="$KDU_HOME/bin/Mac-x86-64-gcc:$PATH"
export DYLD_LIBRARY_PATH="$KDU_HOME/lib/Mac-x86-64-gcc"

cd $cur_dir
