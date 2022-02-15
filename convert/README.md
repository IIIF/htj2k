# jp2 and Pyramid tiff conversion scrips


## convert.sh

Usage:

```
convert.sh <source> <base output path> <output format>
```

Where:

* `<source>` is the full path to the source file(s) (glob patterns and directories are allowed),
* `<base output path>` is the path under which per-format output folders will be created and 
* `<output format>` is either 'ptiff', or 'jp2', or 'htj2k'.

This convert script calls the other scripts depending in the output format parameter.
