# trading-bot

Autonomous Claude Code trading agent on Alpaca. Five cloud routines per trading day; Git is the memory.

See `trading_bot_setup_guide.md` for the complete blueprint.

## Quick start (local)

```bash
cp env.template .env
# fill in ALPACA_API_KEY, ALPACA_SECRET_KEY, PERPLEXITY_API_KEY, DISCORD_WEBHOOK_URL
chmod +x scripts/*.sh
bash scripts/alpaca.sh mode      # confirms paper|live
bash scripts/alpaca.sh account   # smoke test
```

Then open the repo in Claude Code and run `/portfolio`.

## Paper vs live

Controlled by `ALPACA_MODE` (`paper` default, or `live`). Paper and live accounts have **separate API key pairs** — generate keys for the mode you set. Override the endpoint directly with `ALPACA_ENDPOINT` if needed.

## Cloud mode

See `routines/README.md` and Part 7 of the setup guide. Five cron schedules in `America/Boise`:

- Pre-market: `0 5 * * 1-5`
- Market-open: `30 7 * * 1-5`
- Midday: `0 11 * * 1-5`
- Daily-summary: `0 14 * * 1-5`
- Weekly-review: `0 15 * * 5`

Market hours are 07:30–14:00 MT.
