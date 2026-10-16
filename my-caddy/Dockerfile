# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/hilmoo/caddy-dynamic-remoteip

FROM caddy:${CADDY_VERSION}-alpine

ARG CADDY_VERSION
LABEL caddy.version=${CADDY_VERSION} \
    org.opencontainers.image.description="Caddy ${CADDY_VERSION} with caddy-ip-list and caddy-dynamic-remoteip"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
