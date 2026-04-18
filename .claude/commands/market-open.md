---
description: Market-open execution — validate planned trades, place buys + trailing stops
---

Local market-open workflow. Credentials come from .env.

Resolve DATE=$(date +%Y-%m-%d). Confirm mode via `bash scripts/alpaca.sh mode`.

STEP 1 — Read:
- memory/TRADING-STRATEGY.md
- TODAY's entry in memory/RESEARCH-LOG.md (if missing, run pre-market STEPS 1-3 first)
- tail of memory/TRADE-LOG.md (weekly trade count)

STEP 2 — Re-validate:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh quote <each planned ticker>

STEP 3 — Hard-check rules BEFORE every order:
- Total positions after trade <= 6
- Trades this week <= 3
- Position cost <= 20% of equity
- Catalyst documented in today's RESEARCH-LOG
- daytrade_count leaves room
Skip any that fail; log reason.

STEP 4 — Execute buys (market, day TIF):
  bash scripts/alpaca.sh order '{"symbol":"SYM","qty":"N","side":"buy","type":"market","time_in_force":"day"}'

STEP 5 — Immediately place 10% trailing_stop GTC per new position:
  bash scripts/alpaca.sh order '{"symbol":"SYM","qty":"N","side":"sell","type":"trailing_stop","trail_percent":"10","time_in_force":"gtc"}'
PDT fallback: fixed stop 10% below entry; if also blocked, queue in TRADE-LOG.

STEP 6 — Append each trade to memory/TRADE-LOG.md (date, mode, ticker, side, shares, entry, stop, thesis, target, R:R).

STEP 7 — If trades placed: bash scripts/discord.sh "[<MODE>] <tickers, shares, fills, one-line why>"

No commit — local mode.
