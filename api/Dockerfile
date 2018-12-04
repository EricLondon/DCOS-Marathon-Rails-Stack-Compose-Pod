FROM ruby:2.5.3-alpine3.8

RUN apk add --no-cache --update build-base \
  postgresql-dev \
  tzdata

RUN echo 'gem: --no-document' > ~/.gemrc
RUN gem install bundler
COPY Gemfile Gemfile.lock /
RUN cd / && bundle install

ENV APP_HOME /api
WORKDIR $APP_HOME
COPY . $APP_HOME
