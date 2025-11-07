# syntax=docker/dockerfile:1

# Use the same Ruby version as in .ruby-version
ARG RUBY_VERSION=3.4.7
FROM ruby:${RUBY_VERSION}

# Set working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock first to leverage Docker caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the app code
COPY . .

# Expose port 3000 for Rails server
EXPOSE 3000

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle

# Default command (can be overridden in docker-compose)
CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0 -p 3000"]
