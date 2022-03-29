#!/bin/bash

# Copying params from: https://github.com/IIIF/htj2k/blob/6775ad830625f1e717317da6f87851b211fc59ec/convert/imgconv_ptiff.py#L119
# for param names run vips tiffsave

# you can pass in a glob parameter and a directory as a output filename to process multiple files

vips tiffsave $1 $2 --vips-progress --compression deflate --bigtiff --tile --pyramid --tile-width 256 --tile-height 256 
