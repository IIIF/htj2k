# jp2 and Pyramid tiff conversion scrips


## convert.sh

```
Usage: convert.sh <source> <base output path> <output format> <logs_directory> <iterations>
 Where:
  * <source> is the full path to the source file(s) (glob patterns and directories are allowed), 
  * <base output path> is the path under which per-format output folders will be created  
  * <output format> is one of 'ptiff_lossy', 'ptiff_lossless' 'j2k1_lossy', 'j2k1_lossless', 'htj2k_lossy' or 'htj2k_lossless'
  * <logs_directory> is a directory where the timing logs will be stored 
  * <iterations> is the number of iterations to run. Defaults to 1.
```

This convert script calls the other scripts depending in the output format parameter.

## Running in a container

To run this script for one dataset within a container, use `docker compose`.

E.g. to convert an image set in `data/images/getty50/original` into
`htj2_lossless` format, run:

```
docker compose run convert /usr/local/src/htj2k/convert/convert.sh /data/images/getty50/original /data/images/getty50/htj2k_lossless htj2k_lossless /data/images/getty50/logs
```

Or, to convert all formats:

```
docker compose run convert /usr/local/src/htj2k/convert/convert_all.sh getty50
```

