#!/usr/bin/env bash
# Notification wrapper. Posts to a Discord channel via webhook.
# Usage: bash scripts/discord.sh "<message>"
# If DISCORD_WEBHOOK_URL is unset, appends to a local fallback file.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
FALLBACK="$ROOT/DAILY-SUMMARY.md"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

if [[ $# -gt 0 ]]; then
  msg="$*"
else
  msg="$(cat)"
fi

if [[ -z "${msg// /}" ]]; then
  echo "usage: bash scripts/discord.sh \"<message>\"" >&2
  exit 1
fi

stamp="$(date '+%Y-%m-%d %H:%M %Z')"

if [[ -z "${DISCORD_WEBHOOK_URL:-}" ]]; then
  printf "\n---\n## %s (fallback — Discord not configured)\n%s\n" "$stamp" "$msg" >> "$FALLBACK"
  echo "[discord fallback] appended to DAILY-SUMMARY.md"
  echo "$msg"
  exit 0
fi

payload="$(python3 -c "
import json, sys
print(json.dumps({'content': sys.argv[1]}))
" "$msg")"

curl -fsS -X POST "$DISCORD_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "$payload"
echo
