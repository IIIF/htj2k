# Testing jp2 parameters 

## Generating the jp2s and jph files

#!/bin/bash
for i in $(seq 1 10); do
    python scripts/create_kdu_compress_encode_scripts.py --source_directory imgs/50/original --compressed_directory imgs/50/params --logs_directory logs --path_to_kdu_compress ./image_server/kakadu/v8_2_1-02075E/bin/Mac-x86-64-gcc/kdu_compress --output_script_filename_prefix scripts/params/ --exclude-timing --encoding_parameter_set $i;
done

Found in [generateAll.sh](generateAll.sh). This will generate the following scripts:

```
$ ls scripts/params/
encode_htj2k_digital_bodelian_lossless_codeblock_64,64.sh	encode_htj2k_lossy_3bpp_plt_codeblock_64,64.sh			encode_j2k1_lossless_plt_codeblock_64,64.sh
encode_htj2k_digital_bodelian_lossy_codeblock_64,64.sh		encode_htj2k_lossy_Qfactor_90_plt_codeblock_64,64.sh		encode_j2k1_lossy_3bpp_plt_codeblock_64,64.sh
encode_htj2k_lossless_codeblock_64,64.sh			encode_j2k1_digital_bodelian_lossless_codeblock_64,64.sh
encode_htj2k_lossless_plt_codeblock_64,64.sh			encode_j2k1_digital_bodelian_lossy_codeblock_64,64.sh
```

Run all these scripts by running:

```
for f in scripts/params/*.sh; do bash "$f" || break; done
```