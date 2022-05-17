FROM alpine:latest

# Working source root.
ENV _workroot /usr/local/src
# iipsrv version to use (for release build).
ENV _iipsrv_version 1.1
# iipsrv commit to use (for trunk build).
ENV _iipsrv_commit efcf57fbd1b31509e2f4a3393aa8c35887eef9f3

RUN apk add --no-cache -t devtools autoconf automake libtool git
RUN apk add --no-cache build-base glib-dev bash openjpeg libjpeg-turbo-dev \
    tiff-dev libpng-dev fcgi-dev libevent libevent-dev ca-certificates nginx

# Copy and compile Kakadu codec.
WORKDIR ${_workroot}
COPY kakadu ./kakadu
WORKDIR ${_workroot}/kakadu/coresys/make
RUN make -f Makefile-Linux-x86-64-gcc
WORKDIR ${_workroot}/kakadu/apps/make
RUN make -f Makefile-Linux-x86-64-gcc
WORKDIR ${_workroot}/kakadu/lib
RUN cp * /usr/local/lib
WORKDIR ${_workroot}/kakadu/bin
RUN cp * /usr/local/bin

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
RUN git clone --depth 1 https://github.com/ruven/iipsrv.git
WORKDIR iipsrv
#RUN git checkout -b build ${_iipsrv_commit}
# END trunk build

RUN ./autogen.sh
# Compile for OpenJPEG support. According to configure doc, OpenJPEG and Kakadu
# exclude each other.
RUN ./configure --prefix=/usr/local/iipsrv_openjpeg --with-openjpeg=/usr/lib
RUN make
RUN make install

# Compile again for Kakadu support.
RUN make clean
RUN ./configure --prefix=/usr/local/iipsrv_kakadu --with-kakadu=/usr/local/lib
RUN make
RUN make install

WORKDIR /var/www/iipsrv/cgi-bin
RUN cp /usr/local/iipsrv_openjpeg/src/iipsrv/src/iipsrv.fcgi ./iipsrv_openjpeg.fcgi
RUN cp /usr/local/iipsrv_kakadu/src/iipsrv/src/iipsrv.fcgi ./iipsrv_kakadu.fcgi

# Create image directory, to be mapped as an external volume.
WORKDIR /data/images

COPY nginx.conf /etc/nginx/nginx.conf

# Clean up build packages
WORKDIR /
RUN apk del devtools

# Clean up source files
RUN rm -rf ${_workroot}

RUN addgroup --system --gid 1000 apprun
RUN adduser --system --uid 600 iipsrv --ingroup apprun
RUN chown -R root:apprun /var/www/iipsrv/cgi-bin/* && chmod 774 /var/www/iipsrv/cgi-bin/*

# ---- For split packages, cut here ----

ENV ALLOW_UPSCALING 0
ENV CORS "*"
ENV LOGFILE "/dev/stdout"
ENV URI_MAP "iiif=>IIIF"
ENV MAX_IMAGE_CACHE_SIZE "0"
ENV CACHE_CONTROL "no-store"
ENV FILESYSTEM_PREFIX "/data/images/"
ENV INTERPOLATION 1
ENV JPEG_QUALITY 90
ENV MAX_CVT 30000
ENV VERBOSITY 1

COPY iipsrv_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/iipsrv_entrypoint.sh

WORKDIR /var/www
#USER iipsrv
ENTRYPOINT ["iipsrv_entrypoint.sh"]
