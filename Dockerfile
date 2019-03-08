FROM ruby:2.6.1-slim

# Ensure that our apt package list is updated and has basic build packages.
RUN apt-get update -qq && \
      apt-get install -y build-essential apt-transport-https ca-certificates gnupg2 libpq-dev nodejs netcat curl

# Install node from nodesource
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
      && apt-get install -y nodejs

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update -qq \
 && apt-get install -y yarn

ENV PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"

# Bundle installs with binstubs to our custom /bundle/bin volume path. 
# Let system use those stubs.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Add app files into docker image
RUN mkdir -p /app
WORKDIR /app

ENV RAILS_ENV production
ENV RACK_ENV production

COPY .ruby-version /app/.ruby-version
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle check || bundle install -j4 --deployment --jobs 2 --binstubs="$BUNDLE_BIN"

COPY . /app

RUN printenv
RUN yarn install

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE ${SECRET_KEY_BASE}

RUN bundle exec rake assets:precompile
