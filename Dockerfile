FROM mcr.microsoft.com/mssql-tools:latest
LABEL MAINTAINER="Mascarita82 <lmmarinop@proton.me>"

ENV DB_SERVER="mssql" \
    DB_USER="SA" \
    DB_PASSWORD="" \
    DB_NAMES="" \
    CRON_SCHEDULE="0 1 * * sun" \
    BACKUP_CLEANUP=false \
    BACKUP_AGE=7 \
    SKIP_BACKUP_LOG=false \
    PACK="" \
    ZIP_PASSWORD="" \
    PUSH_REMOTE_MODE=""


RUN apt-get update && \
    apt-get install -y cron zip msmtp msmtp-mta mailutils && \
    rm -rf /var/cache/apk/*

COPY backup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/backup.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
