#!/bin/sh

set -e

if [ "${IIPSRV_ENGINE}" = "kakadu" ]; then
    echo "Starting iipsrv with Kakadu support."
    IIPSRV_FCGI="iipsrv_kakadu.fcgi"
else
    echo "Starting iipsrv with OpenJPEG support."
    IIPSRV_FCGI="iipsrv_openjpeg.fcgi"
fi
nohup /var/www/iipsrv/cgi-bin/${IIPSRV_FCGI} --bind 0.0.0.0:9000 &

echo "Starting Nginx."
/usr/sbin/nginx -g 'daemon off;'
