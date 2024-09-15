#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build process"

# Install dependencies
bundle install
echo "Bundle install completed"

# Clean assets before precompiling
bundle exec rake assets:clean
echo "Assets cleaned"

# Precompile assets
bundle exec rake assets:precompile
echo "Assets precompiled"

# Setup database (create if not exists and run migrations)
if bundle exec rake db:migrate; then
  echo "Database migrations completed"
else
  echo "Database doesn't exist, creating..."
  bundle exec rake db:create
  echo "Database created, running migrations..."
  bundle exec rake db:migrate
  echo "Database migrations completed"
fi

# Clear cache
bundle exec rake tmp:clear
echo "Cache cleared"

# Add any additional commands here

echo "Build process completed"