# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

# renovate-git: depName=https://github.com/mholt/caddy-l4 branch=master
ARG CADDY_L4_COMMIT=4ad6aec1ccc6711df47ca444d9b5364b79ea3170

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

ARG CADDY_L4_COMMIT

RUN xcaddy build \
    --with github.com/mholt/caddy-l4@${CADDY_L4_COMMIT}

FROM caddy:${CADDY_VERSION}-alpine

ARG CADDY_VERSION
ARG CADDY_L4_COMMIT
LABEL caddy.version=${CADDY_VERSION} \
    caddy-l4.commit=${CADDY_L4_COMMIT} \
    org.opencontainers.image.description="Caddy ${CADDY_VERSION} with caddy-l4 (${CADDY_L4_COMMIT})"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
