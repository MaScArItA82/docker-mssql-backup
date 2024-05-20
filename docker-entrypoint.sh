#!/bin/bash


# Store environment variables to pass to cron job
printenv | sed 's/^\([a-zA-Z0-9_]*\)=\(.*\)$/export \1="\2"/g' > /container_env.sh

# Remove quotes from CRON_SCHEDULE
cronSchedule=${CRON_SCHEDULE}
cronSchedule=${cronSchedule%\"} 
cronSchedule=${cronSchedule#\"}

# Write log to stdout
cronLogConfig="> /proc/1/fd/1 2>&1 | tee -a $cronLogFile"

# Create crontab definition
echo "$cronSchedule . /container_env.sh; /usr/local/bin/backup.sh $cronLogConfig" > /etc/cron.d/crontab.conf


# Apply cron job
crontab /etc/cron.d/crontab.conf

echo "Starting cron task manager..."
echo "  - Crontab = $cronSchedule"
cron -f
