FROM ruby:2.6.5-alpine3.11

ARG RAILS_ENV

RUN apk add --update \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    tzdata \
    bash \
    git \
    nodejs

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/book-api
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}
ENV RAILS_ENV $RAILS_ENV

RUN addgroup -g 61000 -S $APP_USER && \
    adduser -u 61000 -S $APP_USER -G $APP_USER -h $APP_USER_HOME

RUN mkdir /var/www && \
 chown -R $APP_USER:$APP_USER /var/www && \
 chown -R $APP_USER $APP_USER_HOME

WORKDIR $APP_HOME

COPY .ruby-version Gemfile Gemfile.lock $APP_HOME/

RUN bundle install --jobs 4 --retry 5

USER $APP_USER

COPY . .

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
