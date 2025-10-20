# Redash all-in-one (web + worker + scheduler) for Railway
FROM redash/redash:10.1.0.b50633

# Install Supervisor via pip (avoid EOL Debian repos)
USER root
RUN pip install --no-cache-dir "supervisor==4.2.5"

# Add process config + entrypoint
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker-entry.sh /entry.sh
RUN chmod +x /entry.sh

# Run as redash user
USER redash
CMD ["/entry.sh"]
