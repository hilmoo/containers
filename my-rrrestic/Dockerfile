FROM ghcr.io/hilmoo/rrrestic:v0.3.1

RUN apk add --no-cache sqlite rsync

COPY scripts /scripts/
RUN chmod +x /scripts/*.sh