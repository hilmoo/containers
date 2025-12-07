#!/bin/bash
set -e

LATEST_COMMIT=$(curl -s https://api.github.com/repos/mholt/caddy-l4/commits/master | jq -r '.sha')

if [ -z "$LATEST_COMMIT" ] || [ "$LATEST_COMMIT" = "null" ]; then
  echo "Failed to fetch the latest commit SHA."
  exit 1
fi

CURENT_COMMIT=$(cat latest.txt)

if [ "$LATEST_COMMIT" == "$CURENT_COMMIT" ]; then
  echo "No new commit. Current commit is still: $CURENT_COMMIT"
  exit 1
fi

echo "$LATEST_COMMIT" > latest.txt

PACKAGE_VERSION=$(curl -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/users/hilmoo/packages/container/containers%2Fcaddyl4/versions | jq -r 'if type == "array" then [.[] | select(.metadata.container.tags | length > 0)] | .[0].metadata.container.tags[0] else empty end')

if [ -z "$PACKAGE_VERSION" ] || [ "$PACKAGE_VERSION" = "null" ]; then
  echo "Failed to fetch package version. Using 0.0.0 as starting version."
  PACKAGE_VERSION="0.0.0"
fi

echo "Current version: $PACKAGE_VERSION"

# Parse semver and bump patch version
IFS='.' read -r MAJOR MINOR PATCH <<< "$PACKAGE_VERSION"
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="${MAJOR}.${MINOR}.${NEW_PATCH}"

echo "New version: $NEW_VERSION"
echo "new_version=$NEW_VERSION" >> $GITHUB_OUTPUT