#!/bin/sh

export BASE_URL="${PUBLIC_EP}/iiif/image/"
export CACHE_CONTROL="${IIPSRV_CACHE_CONTROL}"
export FILESYSTEM_PREFIX="${IIPSRV_FILESYSTEM_PREFIX}"
export HTTP_PORT="${IIPSRV_HTTP_PORT}"
export INTERPOLATION="${IIPSRV_INTERPOLATION}"
export JPEG_QUALITY="${IIPSRV_JPEG_QUALITY}"
export MAX_CVT="${IIPSRV_MAX_CVT}"
export MAX_IMAGE_CACHE_SIZE="${IIPSRV_MAX_IMAGE_CACHE_SIZE}"
export VERBOSITY="${IIPSRV_VERBOSITY}"

if [ "${APP_MODE}" = "development" ]; then
    exec /var/www/iipsrv/cgi-bin/iipsrv.fcgi --bind 0.0.0.0:${IIPSRV_CGI_PORT}
else
    exec /usr/bin/supervisord -c /etc/supervisord.conf
fi
