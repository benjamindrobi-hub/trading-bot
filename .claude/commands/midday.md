---
description: Midday scan — cut losers at -7%, tighten stops on winners, thesis check
---

Local midday workflow. Credentials come from .env.

Resolve DATE=$(date +%Y-%m-%d). Confirm mode via `bash scripts/alpaca.sh mode`.

STEP 1 — Read:
- memory/TRADING-STRATEGY.md (exit rules)
- tail of memory/TRADE-LOG.md (entries, thesis, stops)
- today's memory/RESEARCH-LOG.md entry

STEP 2 — Pull:
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh orders

STEP 3 — Cut losers. For every position with unrealized_plpc <= -0.07:
  bash scripts/alpaca.sh close SYM
  bash scripts/alpaca.sh cancel ORDER_ID  # its trailing stop
Log exit to TRADE-LOG: exit price, realized P&L, "cut at -7% per rule".

STEP 4 — Tighten trailing stops on winners. Cancel old, place new:
- Up >= +20% -> trail_percent: "5"
- Up >= +15% -> trail_percent: "7"
Never tighten within 3% of current price. Never move a stop down.

STEP 5 — Thesis check. If a thesis broke intraday, cut even before -7%. Document in TRADE-LOG.

STEP 6 — Optional intraday Perplexity research if something is moving sharply; addendum to RESEARCH-LOG.

STEP 7 — If action taken: bash scripts/discord.sh "[<MODE>] <action summary>"

No commit — local mode.
