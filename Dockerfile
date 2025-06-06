# This first and main rule that we follow in our Dockerfile is to keep it
# without hardcoded dependencies and versions as much as possible.
# This file is an ideal – it has zero.

# It accepts selected Ruby version as an argument.
ARG RUBY_VERSION

# Create new stage from ruby-slim image with selected Ruby version.
FROM ruby:$RUBY_VERSION-slim AS base

# We are Rails developers, so we want to keep our app under /rails directory
WORKDIR /rails

# Here is some Ruby magic and configuration options
ENV RAILS_ENV="production" \
  BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development:test" \
  HOME=/rails

# Throw-away build stage to reduce size of final image
FROM base as build

# Install dependencies that are needed only during build stage
RUN apt-get update -qq && \
  apt-get install -y build-essential curl libpq-dev nodejs git

# Install JavaScript dependencies
ARG NODE_VERSION
ARG YARN_VERSION
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    npm install -g mjml && \
    rm -rf /tmp/node-build-master

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Install node modules
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

RUN --mount=type=secret,id=RAILS_MASTER_KEY \
  SECRET_KEY_BASE_DUMMY=1 \
  RAILS_MASTER_KEY=$(cat /run/secrets/RAILS_MASTER_KEY) \
  RAILS_ENV=production \
  bundle exec rails assets:precompile && \
  rm -rf /usr/local/bundle/cache

# Start again from base image to throw away anything that is not needed
# from build stage.
FROM base

# Install dependencies that we needed during application run.
# We use PostgresSQL for almost all our projects,
# this is why we install `postgresql-client`.
# Also almost all web applications have image upload and convert functionality,
# so you need to install `imagemagick`.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libvips postgresql-client imagemagick tzdata curl vim && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Run and own the application files as a non-root user for security
RUN useradd www --create-home --shell /bin/bash

USER www

# Copy built artifacts: node, gems, application
COPY --from=build --chown=www /usr/local/node /usr/local/node
COPY --from=build --chown=www /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=www /rails /rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
