#!/usr/bin/env sh

set -x

# wait for postgresql
until nc -vz $POSTGRES_HOST $POSTGRES_PORT 2>/dev/null; do
  sleep 1
done

bundle exec rake db:create db:migrate
bundle exec rake db:seed

rm /api/tmp/pids/server.pid
rails s -e $RAILS_ENV -p $RAILS_PORT -b '0.0.0.0'
