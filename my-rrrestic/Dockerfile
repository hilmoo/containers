FROM ghcr.io/hilmoo/rrrestic:v0.1.1

RUN apk add --no-cache sqlite rsync

COPY backup.sh /scripts/backup.sh
RUN chmod +x /scripts/backup.sh