# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.7
FROM ruby:${RUBY_VERSION} AS base

WORKDIR /app

# Install system dependencies including PostgreSQL client
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

# Copy and install ALL gems (including test for CI)
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 3000

# Add CMD for development - this is what was missing!
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

# Production stage (excludes dev/test gems)
FROM base AS production

RUN bundle config set without 'development test' && \
    bundle install --jobs 4

ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    RAILS_LOG_TO_STDOUT=true

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]