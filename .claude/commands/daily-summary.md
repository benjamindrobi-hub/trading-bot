---
description: Daily EOD summary — compute day P&L, append snapshot, send Discord recap
---

Local daily summary workflow. Credentials come from .env.

Resolve DATE=$(date +%Y-%m-%d). Confirm mode via `bash scripts/alpaca.sh mode`.

STEP 1 — Read:
- tail of memory/TRADE-LOG.md (most recent EOD snapshot = yesterday's equity)
- Count trades today; count trades Mon-today for weekly cap.

STEP 2 — Pull:
  bash scripts/alpaca.sh account
  bash scripts/alpaca.sh positions
  bash scripts/alpaca.sh orders

STEP 3 — Compute:
- Day P&L ($ / %) = today_equity - yesterday_equity
- Phase cumulative P&L
- Trades today (list or "none")
- Trades this week

STEP 4 — Append EOD snapshot to memory/TRADE-LOG.md:
### MMM DD — EOD Snapshot (Day N, Weekday) [mode]
**Portfolio:** $X | **Cash:** $X (X%) | **Day P&L:** ±$X (±X%) | **Phase P&L:** ±$X (±X%)
| Ticker | Shares | Entry | Close | Day Chg | Unrealized P&L | Stop |
**Notes:** one-paragraph summary.

STEP 5 — Send ONE Discord message, always, <=15 lines:
  bash scripts/discord.sh "[<MODE>] EOD MMM DD
  Portfolio: \$X (±X% day, ±X% phase)
  Cash: \$X
  Trades today: <list or none>
  Open positions: SYM ±X.X% (stop \$X.XX) ...
  Tomorrow: <one-line plan>"

No commit — local mode.
