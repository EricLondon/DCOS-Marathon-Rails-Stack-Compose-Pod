FROM nginx:stable

RUN apt-get update -qq && apt-get install -y --allow-unauthenticated \
  curl \
  netcat

COPY ./start-nginx.sh /
COPY ./nginx.conf /etc/nginx/
COPY ./default.conf.template /
