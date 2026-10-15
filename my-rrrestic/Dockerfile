# renovate: datasource=docker depName=ghcr.io/hilmoo/rrrestic
ARG RRRESTIC_VERSION=v0.3.1

FROM ghcr.io/hilmoo/rrrestic:${RRRESTIC_VERSION}

RUN apk add --no-cache sqlite rsync

COPY scripts /scripts/
RUN chmod +x /scripts/*.sh
