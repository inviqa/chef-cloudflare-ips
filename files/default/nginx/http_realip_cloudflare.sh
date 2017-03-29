#!/bin/bash
# Copyright Inviqa UK Ltd 2017
# Author: Marco Massari Calderone <mmassari@inviqa.com>
set -eu
# Check that the conf file path is provided.
if [ $# -ne 1 ]; then
    printf "$0 needs 1 parameter that defines the http_realip.conf path.\n"
    exit 1
fi
CURL=$(which curl);
WEBSERVICE="nginx"
HTTP_REALIP_CONF="$1"
IP_LISTS=(
          "https://www.cloudflare.com/ips-v4"
          "https://www.cloudflare.com/ips-v6"
          )
HTTP_REALIP_TEMP="/tmp/http_realip.tmp"
REAL_IP_HEADER="real_ip_header X-Forwarded-For;"
INFO="# THIS FILE IS UPDATED BY $(dirname $0)/$0 RUN BY CRON"
# use any of the following two
# real_ip_header CF-Connecting-IP;
# real_ip_header X-Forwarded-For;

# reset the current http_realip conf file
echo $INFO > $HTTP_REALIP_TEMP

# add the list of ips
for LIST in "${IP_LISTS[@]}"
do
  eval "$CURL -s $LIST |sed -e 's/^/set_real_ip_from /;s/$/;/' >> $HTTP_REALIP_TEMP"
done

echo $REAL_IP_HEADER >> $HTTP_REALIP_TEMP

# compares the newly generated file with the existing one.
set +e
cmp -s $HTTP_REALIP_TEMP $HTTP_REALIP_CONF
RESULT="$?"
set -e
# if they don't match the existing one is replaced
# and the webservice reloaded
if [ "$RESULT" -ne 0 ]; then
   cp $HTTP_REALIP_TEMP $HTTP_REALIP_CONF
   service $WEBSERVICE reload
fi

rm $HTTP_REALIP_TEMP
