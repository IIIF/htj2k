#!/bin/sh

set -e

echo "Starting iipsrv with OpenJPEG support."
nohup /var/www/iipsrv/cgi-bin/iipsrv_openjpeg.fcgi --bind 0.0.0.0:9000 &
echo "Starting iipsrv with Kakadu support."
nohup /var/www/iipsrv/cgi-bin/iipsrv_kakadu.fcgi --bind 0.0.0.0:9001 &
echo "Starting Nginx."
exec /usr/sbin/nginx -g 'daemon off;'
