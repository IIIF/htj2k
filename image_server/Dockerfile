FROM ubuntu:jammy

# Working source root.
ENV _workroot /usr/local/src
# iipsrv version to use (for release build).
ENV _iipsrv_version 1.1
# iipsrv commit to use (for trunk build).
ENV _iipsrv_commit 337aa85f46866255c27b835d69e30e562662cc72
# f57b41b06ee536b6ff3aba095884107d3ffea139

RUN apt update
RUN apt install -y git autoconf automake libtool pkg-config
RUN apt install -y build-essential libopenjp2-7-dev libopenjp2-tools \
    libjpeg-turbo8-dev libtiff-dev libwebp-dev libfcgi-dev nginx

# Copy and compile Kakadu codec.
WORKDIR ${_workroot}
COPY kakadu/v8_2_1-02075E ./kakadu
WORKDIR ${_workroot}/kakadu/make
RUN make -f Makefile-Linux-x86-64-gcc clean
RUN make -f Makefile-Linux-x86-64-gcc all_but_jni
WORKDIR ${_workroot}/kakadu
RUN cp -r apps coresys managed /usr/local/lib
RUN cp lib/Linux-x86-64-gcc/* /usr/local/lib
RUN cp bin/Linux-x86-64-gcc/* /usr/local/bin

# Build iipsrv.
WORKDIR ${_workroot}


# BEGIN release build
#ADD https://github.com/ruven/iipsrv/archive/iipsrv-${_iipsrv_version}.tar.gz ./
#RUN tar xf iipsrv-${_iipsrv_version}.tar.gz
#WORKDIR ${_workroot}/iipsrv-iipsrv-${_iipsrv_version}
# END release build

# TODO When iipsrv v1.2 is released, uncomment the 3 lines above between
# BEGIN / END release build and comment out the lines below between BEGIN / END
# trunk build (after updating _iipsrv_version above, of course).

# BEGIN trunk build
RUN git clone https://github.com/ruven/iipsrv.git
WORKDIR iipsrv
RUN git checkout ${_iipsrv_commit}
# END trunk build

RUN ./autogen.sh
# Compile for OpenJPEG support. According to configure doc, OpenJPEG and Kakadu
# exclude each other.
RUN ./configure --prefix=/usr/local/iipsrv_openjpeg
RUN make
RUN make install
RUN ls -l *
RUN mkdir -p /var/www/iipsrv/cgi-bin/
RUN cp src/iipsrv.fcgi /var/www/iipsrv/cgi-bin/iipsrv_openjpeg.fcgi

# Compile again for Kakadu support.
ENV PATH $PATH:/usr/local/lib:/usr/local/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
RUN make clean
RUN ./configure --prefix=/usr/local/iipsrv_kakadu --with-kakadu=/usr/local/lib
RUN make
RUN make install
RUN cp src/iipsrv.fcgi /var/www/iipsrv/cgi-bin/iipsrv_kakadu.fcgi

# Create image directory, to be mapped as an external volume.
WORKDIR /data/images

COPY nginx.conf /etc/nginx/nginx.conf

# Clean up build packages
WORKDIR /
RUN apt remove -y gcc g++ make autoconf automake libtool pkg-config git

# Clean up source files
RUN rm -rf ${_workroot}

RUN addgroup --system --gid 1000 apprun
RUN adduser --system --uid 600 iipsrv --ingroup apprun
RUN chown -R root:apprun /var/www/iipsrv/cgi-bin/* && chmod 774 /var/www/iipsrv/cgi-bin/*

# ---- For split packages, cut here ----

ENV ALLOW_UPSCALING 0
ENV LOGFILE "/dev/stdout"
ENV URI_MAP "iiif=>IIIF"
ENV MAX_IMAGE_CACHE_SIZE "0"
ENV CACHE_CONTROL "no-store"
ENV FILESYSTEM_PREFIX "/data/images/"
ENV INTERPOLATION 1
ENV JPEG_QUALITY 90
ENV MAX_CVT 30000
ENV VERBOSITY 6

COPY iipsrv_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/iipsrv_entrypoint.sh

WORKDIR /var/www
#USER iipsrv
ENTRYPOINT ["iipsrv_entrypoint.sh"]
