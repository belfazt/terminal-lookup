FROM ruby:2.6.1-alpine

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies ruby-dev build-base && \
    gem install bundler --no-ri --no-rdoc && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD config.ru /app
ADD src/ /app/src
ADD public/ /app/public
RUN chown -R nobody:nobody /app
USER nobody
EXPOSE 8080
WORKDIR /app
