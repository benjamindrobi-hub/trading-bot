#!/usr/bin/env bash
# Alpaca API wrapper. All trading API calls go through here.
# Usage: bash scripts/alpaca.sh <subcommand> [args...]
#
# Paper vs live is controlled by ALPACA_MODE (paper|live). Default: paper.
# ALPACA_ENDPOINT, if set, overrides the mode-derived endpoint.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

MODE="${ALPACA_MODE:-paper}"
case "$MODE" in
  paper) DEFAULT_API="https://paper-api.alpaca.markets/v2" ;;
  live)  DEFAULT_API="https://api.alpaca.markets/v2" ;;
  *) echo "ALPACA_MODE must be 'paper' or 'live' (got '$MODE')" >&2; exit 2 ;;
esac

API="${ALPACA_ENDPOINT:-$DEFAULT_API}"
DATA="${ALPACA_DATA_ENDPOINT:-https://data.alpaca.markets/v2}"

cmd="${1:-}"
shift || true

# `mode` subcommand prints config without needing API keys (useful for preflight).
if [[ "$cmd" == "mode" ]]; then
  echo "mode=$MODE"
  echo "api=$API"
  echo "data=$DATA"
  exit 0
fi

: "${ALPACA_API_KEY:?ALPACA_API_KEY not set in environment}"
: "${ALPACA_SECRET_KEY:?ALPACA_SECRET_KEY not set in environment}"

H_KEY="APCA-API-KEY-ID: $ALPACA_API_KEY"
H_SEC="APCA-API-SECRET-KEY: $ALPACA_SECRET_KEY"

case "$cmd" in
  account)
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/account"
    ;;
  positions)
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions"
    ;;
  position)
    sym="${1:?usage: position SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions/$sym"
    ;;
  quote)
    sym="${1:?usage: quote SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$DATA/stocks/$sym/quotes/latest"
    ;;
  orders)
    status="${1:-open}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/orders?status=$status"
    ;;
  order)
    body="${1:?usage: order '<json>'}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;
  cancel)
    oid="${1:?usage: cancel ORDER_ID}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders/$oid"
    ;;
  cancel-all)
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders"
    ;;
  close)
    sym="${1:?usage: close SYM}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions/$sym"
    ;;
  close-all)
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions"
    ;;
  *)
    echo "Usage: bash scripts/alpaca.sh <mode|account|positions|position|quote|orders|order|cancel|cancel-all|close|close-all> [args]" >&2
    exit 1
    ;;
esac
echo
