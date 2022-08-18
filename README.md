# htj2k

This is a IIIF community project to evaluate the new htj2k standard and its applicability to IIIF. We intend to test a number of different jp2 libraries and Pyramid tiffs to compare htj2k to this existing formats. 

This repository will be a place to publish our data and scripts so others can scrutinise our results. 

## Presentations & reports

    * [IIIF Community call - introduction htj2k](https://www.youtube.com/watch?v=nzkn0W2esOQ)
      * [Mike's presentation](https://docs.google.com/presentation/d/1Y4npwMKaZLDWATG8FeXS03BkfdmEfiIl/edit#slide=id.p1)
      * [Ruven's presentation](https://merovingio.c2rmf.cnrs.fr/HTJ2K/)
    * [Glen's local docker image server tests](reports/glen/2022-08-16.md)

## Creating jp2s, htj2k images and ptiffs

We have created various scripts in the [convert](convert/) directory to convert a source TIFF file to the various formats we are using for the testing. You can run each of the scripts to convert a single file or use the convert.sh command to convert a directory of images. See the [convert readme](convert/README.md)

For our testing we have been using source tiff files from the Getty but the scripts should work with tiffs from other organisations. 

You will need to install the following programs to generate some of the derivatives:

 * [LibVIPS](https://www.libvips.org/install.html) for Pyramid Tiffs.
 * [Kakadu](https://kakadusoftware.com/documentation-downloads/downloads/) for generating htj2k files and jp2s
 * [OpenJPEG](https://github.com/uclouvain/openjpeg) a jp2 library
 * [Grok](https://github.com/GrokImageCompression/grok) a jp2 library

## Running the image server

We have a docker setup to test OpenJpeg and Kakadu and details can be found in the image_server [README.md](image_server/README.md).

## Test scripts

We are using [locust](https://locust.io/) for our testing and you can find the testing scripts in the load_test directory. 

The [fromList locustfile](load_test/fromlist/locustfile.py) will test a set of IIIF urls against lossy and lossless versions of jp2, htj2k and ptiff files. It can be run as follows:

```
cd load_test/fromlist
locust -u  1 --autostart --url-list ../../data/50_images/mirador_urls.txt --host http://0.0.0.0:8000
```

Note you must have the image server running on port 8000 as configured in the supplied Docker.


## Setup Instructions (*nix)


Create a project folder:

```
mkdir htj2k
```

Create Python virtual environment:

```
cd htj2k
python3 -m venv venv
source venv/bin/activate
```

Clone this repo:

```
git clone git@github.com:IIIF/htj2k.git src
```

Install dependencies:

```
cd src
pip install -r requirements.txt
```

# docker
## build docker
`docker build --rm -f ./src/Dockerfile -t iiif-htj2k:latest .`
## run docker
`docker run -it --rm  iiif-htj2k:latest`
`docker run -it --rm -v /home/miksmith/2022_04_18/:/usr/src/iiif-htj2k/build/ iiif-htj2k:latest`

## run compression script on TIF files within the original/GRI directory
`bash ./src/convert/convert.sh ./build/original/GRI/ ./build/compressed/ ptiff ./build/logs/`
`bash ./src/convert/convert.sh ./build/test/ ./build/compressed/ ptiff ./build/logs`
`bash ./src/scripts/run_all_encodes.sh`
