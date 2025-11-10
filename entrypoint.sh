#!/bin/bash
set -e

# Wait for Postgres
until nc -z $POSTGRES_HOST 5432; do
  echo "Waiting for Postgres at $POSTGRES_HOST:5432..."
  sleep 1
done
echo "Postgres is up!"

# Wait for Redis
until nc -z redis 6379; do
  echo "Waiting for Redis at redis:6379..."
  sleep 1
done
echo "Redis is up!"

# Ensure gems are installed (safe for dev/prod)
bundle check || bundle install --jobs 4

# Prepare database
bundle exec rails db:create db:migrate || echo "Database already exists"

# Start Rails server
exec bundle exec rails s -b 0.0.0.0 -p 3000
