# Simple Redash one-container image
FROM redash/redash:10.1.0

# Install supervisor to run web + worker + scheduler together
USER root
RUN apt-get update && apt-get install -y --no-install-recommends supervisor && rm -rf /var/lib/apt/lists/*

# Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Tiny bootstrap that ensures DB is migrated, then starts all processes
COPY docker-entry.sh /entry.sh
RUN chmod +x /entry.sh

# Railway sets PORT; Redash will bind to it via `server` command
ENV PYTHONUNBUFFERED=1

# Drop back to the redash user (already exists in base image)
USER redash

CMD ["/entry.sh"]
