ARG S3_BUCKET_ASSETS
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_ACCESS_KEY_ID
ARG RAYGUN_API_KEY
ARG AIRBRAKE_PROJECT_ID
ARG AIRBRAKE_PROJECT_KEY
ARG BUILDER_IMAGE_WEB
ARG DEVISE_SECRET_KEY
FROM $BUILDER_IMAGE_WEB as builder
ENV S3_BUCKET_ASSETS="$S3_BUCKET_ASSETS" AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
ENV RAYGUN_API_KEY="$RAYGUN_API_KEY" AIRBRAKE_PROJECT_ID="$AIRBRAKE_PROJECT_ID" AIRBRAKE_PROJECT_KEY="$AIRBRAKE_PROJECT_KEY"
ENV DEVISE_SECRET_KEY="$DEVISE_SECRET_KEY"
# Define basic environment variables
ENV RAILS_ENV ${RAILS_ENV:-production}
ENV NODE_ENV "$RAILS_ENV"
ENV RAILS_LOG_TO_STDOUT true
# Copy source code
RUN echo $RAILS_ENV
RUN echo $NODE_ENV
COPY . /app/

# Build front-end assets
RUN bundle exec rails webpacker:verify_install
RUN SECRET_KEY_BASE=nein bundle exec rails assets:precompile

#RUN rm -rf node_modules

FROM ruby:2.5-alpine3.9 as deploy

RUN apk add --no-cache \
  ca-certificates \
  curl \
  tzdata \
  gnupg1 \
  graphicsmagick \
  libsodium-dev \
  libc6-compat \
  nodejs \
  yarn \
  postgresql-dev \
  bash

# Define basic environment variables
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-production}
ENV NODE_ENV "$RAILS_ENV"
ENV RAILS_LOG_TO_STDOUT true

# Defined for future testing
ENV RAILS_SERVE_STATIC_FILES true

COPY --from=builder /app/ /app/
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

# Add a script to be executed every time the container starts.
ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Modify /etc/host for Guard Gem to be move to its on container

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
EXPOSE 4000
EXPOSE 35729
EXPOSE 5000
RUN ls /app
# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
