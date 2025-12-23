FROM caddy:2.10.2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-l4 \
    --with github.com/monobilisim/caddy-ip-list \
    --with github.com/tuzzmaniandevil/caddy-dynamic-clientip

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy