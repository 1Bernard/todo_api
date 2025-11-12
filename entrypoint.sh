#!/bin/bash
set -e

# If running the web service
if [ "$1" = "bundle" ] && [ "$2" = "exec" ]; then

  # Wait for PostgreSQL
  echo "Waiting for PostgreSQL at $POSTGRES_HOST:$POSTGRES_PORT..."
  until pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER; do
    sleep 2
  done

  # Wait for Redis
  echo "Waiting for Redis..."
  until redis-cli -u $REDIS_URL ping | grep -q "PONG"; do
    sleep 2
  done

  # Create/migrate database if in development
  if [ "$RAILS_ENV" = "development" ]; then
    echo "Creating/Updating database..."
    bundle exec rails db:prepare
  fi
fi

# Execute the main command
exec "$@"