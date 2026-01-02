FROM ghcr.io/hilmoo/rrrestic:v0.1.0

RUN apk add --no-cache sqlite rsync
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh