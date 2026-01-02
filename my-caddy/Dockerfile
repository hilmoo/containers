FROM caddy:2.10.2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/hilmoo/caddy-dynamic-remoteip

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy