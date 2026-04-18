---
description: Pre-market research — pull account state, scan catalysts, write today's RESEARCH-LOG entry
---

Local pre-market workflow. Credentials come from .env.

Resolve DATE=$(date +%Y-%m-%d). Confirm mode via `bash scripts/alpaca.sh mode`.

STEP 1 — Read memory for context:
- memory/TRADING-STRATEGY.md
- tail of memory/TRADE-LOG.md
- tail of memory/RESEARCH-LOG.md

STEP 2 — Pull live account state:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh orders

STEP 3 — Research market context via Perplexity:
- "WTI and Brent oil price right now"
- "S&P 500 futures premarket today"
- "VIX level today"
- "Top stock market catalysts today $DATE"
- "Earnings reports today before market open"
- "Economic calendar today CPI PPI FOMC jobs data"
- "S&P 500 sector momentum YTD"
- News on any currently-held ticker
If Perplexity exits 3, fall back to native WebSearch and note fallback.

STEP 4 — Append dated entry to memory/RESEARCH-LOG.md:
- Account snapshot (mode, equity, cash, buying power, daytrade count)
- Market context
- 2-3 actionable trade ideas (catalyst, entry, stop, target)
- Risk factors
- Decision: trade or HOLD (default HOLD)

STEP 5 — Silent unless urgent. If urgent: bash scripts/discord.sh "[<MODE>] <one line>"

No commit — local mode. User commits manually.
