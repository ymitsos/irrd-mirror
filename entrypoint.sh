#!/bin/bash
set -e

# Load environment
. /env/configuration.env

# Render IRRd config from template
envsubst < /etc/irrd/irr.yaml.template > /etc/irrd/irr.yaml

# Wait for PostgreSQL
until pg_isready -h db -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

# Initialize IRRd DB if needed
 if [ ! -f "/var/lib/irrd4/.db_init_done" ]; then
   echo "Initializing IRRd DB..."
   irrd_database_upgrade --config /etc/irrd/irr.yaml
   touch /var/lib/irrd4/.db_init_done
 fi
 
# Start IRRd and cron
irrd --config /etc/irrd/irr.yaml &
cron -f
