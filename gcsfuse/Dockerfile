FROM python:3.9-buster

# Install system dependencies:

# FUSE
RUN set -e; \
    apt-get update -y && apt-get install --no-install-recommends -y tini lsb-release; \
    gcsFuseRepo=gcsfuse-$(lsb_release -c -s); \
    echo "deb http://packages.cloud.google.com/apt $gcsFuseRepo main" | \
    tee /etc/apt/sources.list.d/gcsfuse.list; \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key add -; \
    apt-get update; \
    apt-get install -y gcsfuse --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR /app

# Creates a group and "appuser" to run as non-root user
RUN groupadd -g 999 appuser && \
  useradd -d /app -r -u 999 -g appuser appuser && \
  chown appuser:appuser -R /app /mnt /dev
USER appuser

# Startup command, ensure the startup script is executable
COPY --chown=appuser:appuser startup.sh .
RUN chmod +x /app/startup.sh
# FUSE: Use tini to manage zombie processes and signal forwarding
# https://github.com/krallin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/app/startup.sh"]
