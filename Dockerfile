FROM ruby:2.6.5-stretch
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \
                       nodejs


ENV APP_ROOT /usr/src/example_rails
WORKDIR $APP_ROOT
COPY . $APP_ROOT

RUN gem install bundler:2.0.2
RUN bundle install

EXPOSE  3000