FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    git \
    cron \
    curl \
    procps \
    postgresql-client \
    bgpq4 \
    gettext \
    gnupg2 \
    logrotate \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install IRRd
RUN pip install irrd

# Create directories
RUN mkdir -p /var/lib/irrd4 /var/log/irrd /run/irrd /etc/irrd /export/filters

RUN mkdir -p /var/lib/irrd4/pgp_keys && \
    chmod 700 /var/lib/irrd4/pgp_keys && \
    chown -R nobody:nogroup /var/lib/irrd4/pgp_keys

# Initialize empty keyring. If we need to sign updates then we need
# to upload our key
RUN gpg --homedir /var/lib/irrd4/pgp_keys --batch --list-keys

# Copy irrd files
COPY config/irr.yaml.template /etc/irrd/irr.yaml.template
COPY configuration.env /env/configuration.env

RUN chown -R root:nogroup /var/log/irrd/ && chmod g+w /var/log/irrd/
RUN chown -R root:nogroup /run/irrd/ && chmod g+w /run/irrd/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY config/logrotate-irrd.conf /etc/logrotate.d/irrd
COPY config/cron-irrd.conf /etc/cron.d/irrd-logrotate
RUN chmod 0644 /etc/cron.d/irrd-logrotate && crontab /etc/cron.d/irrd-logrotate

EXPOSE 43 8080

VOLUME ["/var/lib/irrd4"]

CMD ["/entrypoint.sh"]
