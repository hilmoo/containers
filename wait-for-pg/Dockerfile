FROM alpine:latest AS builder
RUN apk add --no-cache postgresql-client

FROM alpine:latest
COPY --from=builder /usr/bin/pg_isready /usr/bin/pg_isready
COPY --from=builder /usr/lib/libpq.so.5 /usr/lib/libpq.so.5

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]