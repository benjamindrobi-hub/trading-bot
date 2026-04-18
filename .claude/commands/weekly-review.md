---
description: Friday weekly review — stats, grade, strategy adjustments
---

Local weekly review workflow. Credentials come from .env.

Resolve DATE=$(date +%Y-%m-%d). Confirm mode via `bash scripts/alpaca.sh mode`.

STEP 1 — Read:
- memory/WEEKLY-REVIEW.md (match template exactly)
- ALL this week's TRADE-LOG and RESEARCH-LOG entries
- memory/TRADING-STRATEGY.md

STEP 2 — Pull:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions

STEP 3 — Compute weekly metrics:
- Start portfolio (Mon AM), end portfolio, week return ($ / %)
- S&P 500 week return via: bash scripts/perplexity.sh "S&P 500 weekly performance week ending $DATE"
- Trades (W/L/open), win rate, best, worst, profit factor

STEP 4 — Append full review section to memory/WEEKLY-REVIEW.md:
- Stats table, closed trades, open positions, what worked / didn't, lessons, adjustments, letter grade.

STEP 5 — If a rule proved out 2+ weeks or failed badly, update memory/TRADING-STRATEGY.md; call out change in review.

STEP 6 — Send ONE Discord message (<=15 lines):
  bash scripts/discord.sh "[<MODE>] Week ending MMM DD
  Portfolio: \$X (±X% week, ±X% phase)
  vs S&P 500: ±X%
  Trades: N (W:X / L:Y / open:Z)
  Best: SYM +X%   Worst: SYM -X%
  Takeaway: <...>
  Grade: <letter>"

No commit — local mode.
