# jp2 and Pyramid tiff conversion scrips


## convert.sh

```
Usage: 

convert.sh <source> <base output path> <output format>
```
Where: 

* `<source>` is the full path to the source file(s) (glob patterns and directories are allowed, enclosed in quotes), 
* `<base output path>` is the path under which per-format output folders will be created and 
* `<output format>` is one of 'ptiff', 'jp2' or 'jp2_legacy'.
```        

This convert script calls the other scripts depending in the output format parameter.

## tiff_pyramid.sh

Convert tiff to pyramid tiff
```
Usage:

tiff_to_pyramid.sh <tmpdir> <full path to image source> <full path to output target> <save all working files - any value will do>
```

## tiff_to_jp2.sh

Convert a tiff to jp2. 

```
Usage:

tiff_to_jp2.sh <input_file> <ouput_file>
```

## tiff_to_jp2_legacy.sh

Convert a tiff to jp2. JP2 compression historically used for the Getty Museum images. Use for comparison purposes. The '-jp2_space sRGB' parameter has been added recently to deal with a color aberration issue, but it is omitted here to replicate exactly the legacy Getty behavior.

```
Usage:

tiff_to_jp2_legacy.sh <input_file> <ouput_file>
```

