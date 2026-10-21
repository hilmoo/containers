#!/usr/bin/env bash
# Prints a JSON array of image folders to build, based on the triggering event.
# Env: EVENT, BASE, HEAD, INPUT_IMAGE
set -euo pipefail

CONFIG=.github/images.json
all=$(jq -r 'keys[]' "$CONFIG")

case "$EVENT" in
  schedule)
    images=$(jq -r 'to_entries[] | select(.value.schedule == true) | .key' "$CONFIG")
    ;;
  workflow_dispatch)
    if [ "${INPUT_IMAGE:-all}" = "all" ]; then
      images=$all
    else
      grep -Fxq "$INPUT_IMAGE" <<< "$all" || { echo "Unknown image: $INPUT_IMAGE" >&2; exit 1; }
      images=$INPUT_IMAGE
    fi
    ;;
  *)
    if [ -z "${BASE:-}" ] || [[ "$BASE" =~ ^0+$ ]] || ! git cat-file -e "$BASE^{commit}" 2>/dev/null; then
      images=$all
    else
      changed=$(git diff --name-only "$BASE" "$HEAD" | cut -d/ -f1 | sort -u)
      # images built from another folder ("needs") are rebuilt when that folder changes
      dependents=$(jq -r --argjson c "$(jq -R -s -c 'split("
") | map(select(length > 0))' <<< "$changed")"         'to_entries[] | select(any(.value.needs[]?; . as $n | $c | index($n))) | .key' "$CONFIG")
      images=$(printf '%s
%s
' "$changed" "$dependents" | sort -u | grep -Fx -f <(echo "$all") || true)
    fi
    ;;
esac

echo "$images" | jq -R -s -c 'split("\n") | map(select(length > 0))'
