# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

# renovate-git: depName=https://github.com/mholt/caddy-l4 branch=master
ARG CADDY_L4_COMMIT=4e5ab72a8f9af6b6fc02de4067b04ce7bc05198a

RUN xcaddy build \
    --with github.com/mholt/caddy-l4@${CADDY_L4_COMMIT}

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
