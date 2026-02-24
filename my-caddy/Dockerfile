FROM caddy:2.11.1-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/hilmoo/caddy-dynamic-remoteip

FROM caddy:2.11.1-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy