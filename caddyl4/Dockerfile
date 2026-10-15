# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

# renovate-git: depName=https://github.com/mholt/caddy-l4 branch=master
ARG CADDY_L4_COMMIT=42db5690dea199f930a6f08005fe2e4aab10dcc9

RUN xcaddy build \
    --with github.com/mholt/caddy-l4@${CADDY_L4_COMMIT}

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
