FROM alpine:latest

# Working source root.
ENV _workroot /usr/local/src
# iipsrv version to use (for release build).
ENV _iipsrv_version 1.1
# iipsrv commit to use (for trunk build).
ENV _iipsrv_commit efcf57fbd1b31509e2f4a3393aa8c35887eef9f3

RUN apk add --no-cache -t devtools autoconf automake libtool git
RUN apk add --no-cache build-base glib-dev bash libjpeg-turbo-dev tiff-dev \
    libpng-dev fcgi-dev supervisor libev-dev ca-certificates

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
RUN ./configure --prefix=/usr/local --enable-png=yes
RUN make
RUN make install

RUN mkdir -p /var/www/iipsrv/cgi-bin/
RUN cp src/iipsrv.fcgi /var/www/iipsrv/cgi-bin/
COPY supervisord.conf /etc/

# Clean up build packages
RUN apk del devtools

# Clean up source files
WORKDIR /
RUN rm -rf ${_workroot}

RUN addgroup --system --gid 1000 apprun
RUN adduser --system --uid 600 iipsrv --ingroup apprun
RUN chown -R root:apprun /var/www/iipsrv/cgi-bin/* && chmod 774 /var/www/iipsrv/cgi-bin/*

# ---- For split packages, cut here ----

# Common env variables. Environment-specific ones are in Vault.
ENV ALLOW_UPSCALING 0
ENV CORS "*"
ENV FILESYSTEM_SUFFIX ".tif"
ENV LOGFILE "/dev/stdout"
ENV URI_MAP "iiif=>IIIF"

COPY iipsrv_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/iipsrv_entrypoint.sh

WORKDIR /var/www
#USER iipsrv
ENTRYPOINT ["iipsrv_entrypoint.sh"]
