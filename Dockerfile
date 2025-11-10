# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.7
FROM ruby:${RUBY_VERSION}

WORKDIR /app

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  curl \
  git \
  netcat-openbsd \
  && rm -rf /var/lib/apt/lists/*

# Install bundler
RUN gem install bundler

# Copy Gemfiles first for caching
COPY Gemfile Gemfile.lock ./

# Configure Bundler to skip development/test for production
RUN bundle config set without 'development test' \
 && bundle install --jobs 4

# Copy the rest of the app
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose Rails port
EXPOSE 3000

# Set environment variables
ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    REDIS_URL=redis://redis:6379/0 \
    RAILS_LOG_TO_STDOUT=true

# Use entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
