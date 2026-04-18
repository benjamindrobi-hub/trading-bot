---
description: Manual trade helper with strategy-rule validation. Usage — /trade SYMBOL SHARES buy|sell
---

Execute a manual trade with full rule validation. Refuse if any rule fails.

Args: SYMBOL SHARES SIDE (buy or sell). If missing, ask.

1. bash scripts/alpaca.sh mode  # confirm paper vs live; print clearly
2. Pull state: account, positions, quote SYMBOL (capture ask price P).
3. For BUY, validate:
   - Total positions after fill <= 6
   - Trades this week + 1 <= 3
   - SHARES * P <= 20% of equity
   - SHARES * P <= available cash
   - daytrade_count < 3
   - Catalyst documented (ask for thesis if not in today's RESEARCH-LOG)
   If any fail, STOP and print the failed checks.
4. For SELL, confirm position exists with right qty. No other checks.
5. Print order JSON + validation results + mode, ask "execute? (y/n)".
6. On confirm:
   bash scripts/alpaca.sh order '{"symbol":"SYM","qty":"N","side":"buy|sell","type":"market","time_in_force":"day"}'
7. For BUYs, immediately place 10% trailing stop GTC (same flow as market-open).
8. Log to memory/TRADE-LOG.md with full thesis, entry, stop, target, R:R, mode.
9. bash scripts/discord.sh with trade details (include mode).
