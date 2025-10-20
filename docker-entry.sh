#!/usr/bin/env bash
set -e

# Wait for DB/Redis briefly (Railway plugins come up fast, keep this simple)
echo "Running Redash DB migrations..."
/app/bin/docker-entrypoint create_db || true

# Start all processes (web + worker + scheduler) in one container
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
