#!/bin/sh

set -e

nohup /var/www/iipsrv/cgi-bin/iipsrv.fcgi --bind 0.0.0.0:9000 &
echo "Starting Nginx."
exec /usr/sbin/nginx -g 'daemon off;'
