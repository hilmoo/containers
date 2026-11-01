# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

# renovate: datasource=github-releases depName=mholt/caddy-l4
ARG CADDY_L4_VERSION=v0.1.2

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

ARG CADDY_L4_VERSION

RUN xcaddy build \
    --with github.com/mholt/caddy-l4@${CADDY_L4_VERSION}

FROM caddy:${CADDY_VERSION}-alpine

ARG CADDY_VERSION
ARG CADDY_L4_VERSION

LABEL caddy.version=${CADDY_VERSION} \
      caddy-l4.version=${CADDY_L4_VERSION} \
      org.opencontainers.image.description="Caddy ${CADDY_VERSION} with caddy-l4 (${CADDY_L4_VERSION})"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy