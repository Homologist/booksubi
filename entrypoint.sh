#!/bin/bash
set -e

cd app

# Remove a potentially pre-existing server.pid for Rails.
rm -f /tmp/pids/server.pid

cd ..
echo "Done!"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
