#!/usr/bin/env bash
set -e

echo "Running Redash DB migrations..."
/app/bin/docker-entrypoint create_db || true

echo "Starting all Redash processes..."
# pip installs supervisord at /usr/local/bin
exec /usr/local/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
