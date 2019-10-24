FROM ruby:2.6.5-stretch
ENV APP_ROOT /usr/src/example_rails
WORKDIR $APP_ROOT
COPY . $APP_ROOT

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \
                       nodejs

RUN gem install bundler && \
    bundle install

EXPOSE  3000