# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.7

# renovate-git: depName=https://github.com/mholt/caddy-l4 branch=master
ARG CADDY_L4_COMMIT=f607ccea1b7dbe61cfcec089f2005621c61f7e6c

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
