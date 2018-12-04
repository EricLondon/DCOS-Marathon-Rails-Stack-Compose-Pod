#!/usr/bin/env bash

set -x

envsubst '$API_HOST:$API_PORT' < /default.conf.template > /etc/nginx/conf.d/default.conf

# wait for api
until nc -vz $API_HOST $API_PORT 2>/dev/null; do
  sleep 1
done

nginx -g 'daemon off;'
