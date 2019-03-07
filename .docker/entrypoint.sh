#!/bin/bash

# Exit on fail
set -e

echo ""
echo "⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡"
echo "          Rails - Docker Environment"
echo "⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡"

echo ""
echo "Author: Mike Rogers (@MikeRogers0)"

# Run migrations
bundle exec rake db:migrate

# Removing any old pids from a previous run
rm -f tmp/pids/server.pid

# Finally call the CMD
exec "$@"
