#!/usr/bin/env bash
# Fail if the demo would fetch anything over the network at runtime.
# Everything it needs must be inside this repo.
set -euo pipefail

cd "$(dirname "$0")/.."

status=0

# Absolute and protocol-relative external references in attributes or CSS.
# Matches src="http..., href="http..., src="//..., href="//..., and url(http... / url(//...
if grep -nE '(src|href)[[:space:]]*=[[:space:]]*["'"'"']?(https?:)?//|url\([[:space:]]*["'"'"']?(https?:)?//' index.html; then
  echo "FAIL: index.html references an external URL (see lines above)" >&2
  status=1
fi

# Every local <script src> / <link href> must resolve to a file in this repo.
while IFS= read -r ref; do
  [ -z "$ref" ] && continue
  case "$ref" in
    http://*|https://*|//*|data:*)
      echo "FAIL: non-local reference: $ref" >&2
      status=1
      ;;
    *)
      if [ ! -f "$ref" ]; then
        echo "FAIL: local reference does not exist: $ref" >&2
        status=1
      fi
      ;;
  esac
done < <(grep -oE '(src|href)[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']+["'"'"']' index.html \
           | sed -E 's/^[^=]*=[[:space:]]*["'"'"']//; s/["'"'"']$//')

if [ "$status" -ne 0 ]; then
  exit 1
fi

echo "OK: index.html has no external network dependencies"
