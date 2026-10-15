# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.4

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/hilmoo/caddy-dynamic-remoteip

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
