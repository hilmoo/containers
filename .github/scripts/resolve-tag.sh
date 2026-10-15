#!/usr/bin/env bash
# Prints docker/metadata-action "tags" lines for an image, based on its mode in .github/images.json:
#   latest  -> latest
#   date    -> YYYY.MM.DD, latest
#   version -> first "ARG *_VERSION" of the Dockerfile (+ -N on rebuilds), X.Y, X, latest
# Env: GH_TOKEN, OWNER, REPO (only for "version")
set -euo pipefail

image=$1
mode=$(jq -r --arg i "$image" '.[$i].tag // "latest"' .github/images.json)
tags=()

case "$mode" in
  latest) ;;
  date) tags+=("$(date -u +%Y.%m.%d)") ;;
  version)
    v=$(sed -nE 's/^ARG [A-Za-z0-9_]+_VERSION="?([^"[:space:]]+)"?.*/\1/p' "$image/Dockerfile" | head -n1)
    v=${v#v}
    [ -n "$v" ] || { echo "No ARG *_VERSION found in $image/Dockerfile" >&2; exit 1; }

    existing=$(gh api --paginate "/users/$OWNER/packages/container/$REPO%2F$image/versions?per_page=100" \
      --jq '.[].metadata.container.tags[]?' 2>/dev/null || true)

    if grep -Fxq "$v" <<< "$existing"; then
      last=$(sed -nE "s/^${v//./\.}-([0-9]+)$/\1/p" <<< "$existing" | sort -n | tail -n1)
      tags+=("$v-$(( ${last:-0} + 1 ))")
    else
      tags+=("$v")
    fi

    if [[ "$v" =~ ^([0-9]+)\.([0-9]+)\.[0-9]+$ ]]; then
      tags+=("${BASH_REMATCH[1]}.${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}")
    fi
    ;;
  *) echo "Unknown tag mode: $mode" >&2; exit 1 ;;
esac

tags+=(latest)
for t in "${tags[@]}"; do
  echo "type=raw,value=$t"
done
