

# Decoding results
The fastest threading configuration is noted with text t=1, t=2, t=4, t=8, or t=16 next to each decoding result

## decode the whole image at different scales
### notes
- HTJ2K is much faster than J2K1 (JPEG2000 Part-1 aka "jp2") for large decoded regions
- PLT doesn't have impact when all encodings already have a resolution progressive progression order
- tiling (used by digital bodelian) slows down decoding of image at small scale (50, 500)  

![50.txt](plots/2023-05-29-decoding.50.txt.decoding_time_in_seconds.png)
![500.txt](plots/2023-05-29-decoding.500.txt.decoding_time_in_seconds.png)
![1000.txt](plots/2023-05-29-decoding.1000.txt.decoding_time_in_seconds.png)
![1024.txt](plots/2023-05-29-decoding.1024.txt.decoding_time_in_seconds.png)
![3000.txt](plots/2023-05-29-decoding.3000.txt.decoding_time_in_seconds.png)
![full.txt](plots/2023-05-29-decoding.full.txt.decoding_time_in_seconds.png)

## decoding specific small area
![custom_region-100-100-200-200.txt](plots/2023-05-29-decoding.custom_region-100-100-200-200.txt.decoding_time_in_seconds.png)

### notes
- HTJ2K is about 50% faster than J2K1
- PLT helps speed up spatial random access decoding

## decoding specific large area
![custom_region-100-100-2000-2000.txt](plots/2023-05-29-decoding.custom_region-100-100-2000-2000.txt.decoding_time_in_seconds.png)
### notes
- HTJ2K is about 6x faster than J2K1
- PLT helps speed up spatial random access decoding

## a mix of decoding small areas and decoding the whole image at different scales
![iiif_urls.txt](plots/2023-05-29-decoding.iiif_urls.txt.decoding_time_in_seconds.png)
![iiif_urls_unique.txt](plots/2023-05-29-decoding.iiif_urls_unique.txt.decoding_time_in_seconds.png)

### notes
- HTJ2K is about 2x faster than J2K1
- PLT helps speed up spatial random access decoding

## requests generated during an actual browsing session by a normal real human being
![mirador_urls.txt](plots/2023-05-29-decoding.mirador_urls.txt.decoding_time_in_seconds.png)
![uv_urls.txt](plots/2023-05-29-decoding.uv_urls.txt.decoding_time_in_seconds.png)

### notes
- HTJ2K is about 2x faster than J2K1
- PLT helps speed up spatial random access decoding

# Encoding results
![Compresseed Size](plots/2023-05-28-encoding.compressed_size_in_gigabytes.png)

![Encoding Time](plots/2023-05-28-encoding.encoding_time_in_seconds.png)
