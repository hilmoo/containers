#!/bin/sh
set -e

if [ -z "$PGHOST" ] || [ -z "$PGPORT" ] || [ -z "$PGUSER" ] || [ -z "$PGDATABASE" ]; then
  echo "Error: One or more required environment variables are not set."
  echo "Please set PGHOST, PGPORT, PGUSER, and PGDATABASE."
  exit 1
fi

until pg_isready -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE"; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "PostgreSQL is ready to accept connections."