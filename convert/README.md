# jp2 and Pyramid tiff conversion scrips


## convert.sh

```
Usage: convert.sh <source> <base output path> <output format> <logs_directory>
 Where:
  * <source> is the full path to the source file(s) (glob patterns and directories are allowed), 
  * <base output path> is the path under which per-format output folders will be created  
  * <output format> is one of 'ptiff_lossy', 'ptiff_lossless' 'j2k1_lossy', 'j2k1_lossless', 'htj2k_lossy' or 'htj2k_lossless'
  * <logs_directory> is a directory where the timing logs will be stored 
```

This convert script calls the other scripts depending in the output format parameter.

'''Note:''' to get the timings you will need to have GNU Date installed not the BSD version which comes with Mac OS X.
