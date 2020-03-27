FROM ruby:2.5-alpine3.9
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-production}

RUN echo $RAILS_ENV
# Install alpine packages
# Split in to phases building to reduce image size
RUN apk add --no-cache \
  build-base \
  busybox \
  ca-certificates \
  cmake \
  curl \
  git \
  tzdata \
  gnupg1 \
  graphicsmagick \
  libc6-compat \
  libffi-dev \
  libsodium-dev \
  nodejs \
  yarn \
  openssh-client \
  postgresql-dev \
  libxslt-dev \
  tzdata

# Add a script to be executed every time the container starts.
# --deployment; \
ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir /app
ADD Gemfile* /app/
WORKDIR /app

# Use bunlder to avoid exit with code 1 bugs while doing integration test
RUN gem install bundler -v 2 --no-doc
RUN echo bundle start with $(nproc) processes env: $RAILS_ENV
RUN bundle install -j $(nproc) --deployment

# Set up node_modules files
ADD package.json yarn.lock  /app/
RUN yarn install --check-files
RUN yarn add bootstrap@4.3.1 jquery popper.js
