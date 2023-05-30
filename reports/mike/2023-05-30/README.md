
# Encoding results
![Compresseed Size](plots/2023-05-28-encoding.compressed_size_in_gigabytes.png)

![Encoding Time](plots/2023-05-28-encoding.encoding_time_in_seconds.png)

# Decoding results

## decode the whole image at different scales 
![50.txt](plots/2023-05-29-decoding.50.txt.decoding_time_in_seconds.png)
![500.txt](plots/2023-05-29-decoding.500.txt.decoding_time_in_seconds.png)
![1000.txt](plots/2023-05-29-decoding.1000.txt.decoding_time_in_seconds.png)
![1024.txt](plots/2023-05-29-decoding.1024.txt.decoding_time_in_seconds.png)
![3000.txt](plots/2023-05-29-decoding.3000.txt.decoding_time_in_seconds.png)
![full.txt](plots/2023-05-29-decoding.full.txt.decoding_time_in_seconds.png)

## decoding specific randomly generated small areas at different scales
![custom_region-100-100-200-200.txt](plots/2023-05-29-decoding.custom_region-100-100-200-200.txt.decoding_time_in_seconds.png)
![custom_region-100-100-2000-2000.txt](plots/2023-05-29-decoding.custom_region-100-100-2000-2000.txt.decoding_time_in_seconds.png)

## a mix of decoding small areas and decoding the whole image at different scales
![iiif_urls.txt](plots/2023-05-29-decoding.iiif_urls.txt.decoding_time_in_seconds.png)
![iiif_urls_unique.txt](plots/2023-05-29-decoding.iiif_urls_unique.txt.decoding_time_in_seconds.png)

## requests generated during an actual browsing session by a normal real human being
![mirador_urls.txt](plots/2023-05-29-decoding.mirador_urls.txt.decoding_time_in_seconds.png)
![uv_urls.txt](plots/2023-05-29-decoding.uv_urls.txt.decoding_time_in_seconds.png)
