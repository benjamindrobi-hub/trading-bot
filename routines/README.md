# Cloud Routines

Paste each `*.md` in this directory verbatim into the matching Claude Code cloud routine. See Part 7 of `trading_bot_setup_guide.md` for setup steps.

## Schedules (America/Boise)

Market hours: 07:30–14:00 MT.

| Routine | Cron | Local time |
|---|---|---|
| pre-market | `0 5 * * 1-5` | 05:00 Mon–Fri |
| market-open | `30 7 * * 1-5` | 07:30 Mon–Fri |
| midday | `0 11 * * 1-5` | 11:00 Mon–Fri |
| daily-summary | `0 14 * * 1-5` | 14:00 Mon–Fri |
| weekly-review | `0 15 * * 5` | 15:00 Fri |

## Required routine env vars

```
ALPACA_MODE              (paper|live; start with paper)
ALPACA_API_KEY
ALPACA_SECRET_KEY
ALPACA_DATA_ENDPOINT     (optional)
PERPLEXITY_API_KEY       (pre-market, market-open, midday, weekly-review)
PERPLEXITY_MODEL         (optional; default 'sonar')
DISCORD_WEBHOOK_URL
```

**Do NOT** create a `.env` file in the cloud workspace. See Part 7.

## Don't forget

- Install the Claude GitHub App on this repo.
- Enable "Allow unrestricted branch pushes" on each routine's environment.
- Hit "Run now" on each new routine to verify it pushes to main.
