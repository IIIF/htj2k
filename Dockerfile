FROM ubuntu:focal

RUN apt-get update

# disable interactive install 
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y install unzip
RUN apt-get -y install cmake
RUN apt-get -y install g++

# set Kakadu distribution version and unique serial number 
ARG KDU_SOURCE_NAME=v8_2_1-00462N
# set path to location of source zip, in this case its here ./v8_2_1-00462N.zip
ARG KDU_SOURCE_ZIP_DIRECTORY=.

# transfer Kakadu SDK source code distribution to docker
WORKDIR /usr/src
COPY $KDU_SOURCE_ZIP_DIRECTORY/$KDU_SOURCE_NAME.zip $KDU_SOURCE_NAME.zip
RUN unzip $KDU_SOURCE_NAME.zip -d kakadu-sdk
RUN rm -f $KDU_SOURCE_NAME.zip

# enable HTJ2K
WORKDIR /usr/src/kakadu-sdk/$KDU_SOURCE_NAME/
RUN mv srclib_ht srclib_ht_noopt; cp -r altlib_ht_opt srclib_ht

# compile Kakadu SDK and demo apps with HTJ2K enabled (#define FBC_ENABLED)
WORKDIR /usr/src/kakadu-sdk/$KDU_SOURCE_NAME/make
RUN make CXXFLAGS=-DFBC_ENABLED -f Makefile-Linux-x86-64-gcc all_but_jni

# set environment variables
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/src/kakadu-sdk/$KDU_SOURCE_NAME/lib/Linux-x86-64-gcc
ENV PATH=$PATH:/usr/src/kakadu-sdk/$KDU_SOURCE_NAME/bin/Linux-x86-64-gcc

# Create Python virtual environment:
RUN apt-get -y install python3
RUN apt-get -y install python3.8-venv
RUN python3 -m venv venv
#RUN source venv/bin/activate

# install VIPS
RUN apt-get install -y libvips
RUN apt-get install -y libvips-tools

# install bc
RUN apt-get -y install bc

# Install dependencies:
WORKDIR /usr/src/iiif-htj2k/src
RUN apt-get -y install python3-pip
COPY ./src/requirements.txt ./
RUN pip install -r ./requirements.txt

# Copy the repo
WORKDIR /usr/src/iiif-htj2k
COPY --chmod=755 ./src ./src

# set launch directory
WORKDIR /usr/src/iiif-htj2k/
