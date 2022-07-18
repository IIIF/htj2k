# Locust load testing

Assuming you have one or more sets of images encoded from the same sources in
subfolders, e.g. `/data/htj2k/images/htj2k_lossy/`,
`/data/htj2k/images/ptiff_lossy/`, etc., you may start the IIPImage docker
container as indicated in the `image_server/README.md` binding the parent
folder of all the derivative sets to the IIPImage image root folder:

    docker run -p 8000:8000 -v /data/htj2k:/data/htj2k/images iipsrv_htj2k:latest

Then, after installing the Python dependencies as indicated in the main
`README.md` file, run Locust on each individual set:

    LOCUST_IMG_DATASET=ptiff_lossless LOCUST_IMG_FORMAT=tif locust --headless -f load_test/locustfile.py -H http://localhost:8000

The `LOCUST_IMG_DATASET` environment variable is the path relative to the bound
image directory. `LOCUST_IMG_FORMAT` is the file suffix of the images contained
in the folder. Both are mandatory.

The test will run over all the individual images requesting full-frame
derivatives of 256, 1024 and 4096 pixels on the longer side, as well as random
areas (not tile aligned) of 512x512 pixels.
