#!/bin/sh
set -e

GEOIP_DIR="/var/geoip"
HASH_FILE="${GEOIP_DIR}/hash.txt"
MMDB_FILE="${GEOIP_DIR}/GeoLite2-City.mmdb"

mkdir -p "$GEOIP_DIR"

echo "Fetching latest digest..."
LATEST_DIGEST=$(curl -s https://api.github.com/repos/P3TERX/GeoLite.mmdb/releases/latest | jq -r '.assets[] | select(.name=="GeoLite2-City.mmdb") | .digest')

echo "Latest digest: $LATEST_DIGEST"

if [ -f "$HASH_FILE" ]; then
CURRENT_DIGEST=$(cat "$HASH_FILE")
echo "Current digest: $CURRENT_DIGEST"

if [ "$CURRENT_DIGEST" = "$LATEST_DIGEST" ]; then
    echo "Digest unchanged. Skipping download."
    exit 0
fi
fi

echo "Digest changed or no hash file. Downloading GeoLite2-City.mmdb..."
wget -q -O "$MMDB_FILE" "https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-City.mmdb"

chmod 644 "$MMDB_FILE"
echo "$LATEST_DIGEST" > "$HASH_FILE"

echo "Updated GeoLite2-City.mmdb and hash.txt."