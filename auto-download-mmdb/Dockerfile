FROM alpine:latest

LABEL org.opencontainers.image.description="Alpine image that downloads MaxMind mmdb databases (curl, jq)"

RUN apk add --no-cache curl jq

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]