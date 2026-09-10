# CapStack

CapStack is a real-estate crowdfunding platform. Investors browse funding
campaigns (real-estate projects raising capital), invest capital (minimum
**500 MXN**), and watch a campaign fill toward its goal. When the goal is
reached, the campaign is marked `funded`.

## No login

There is no authentication. The app acts as a single seeded investor
(`Current.investor`) for every request, so you can explore the full flow
without signing in or creating an account.

## Running it

You need Docker Desktop running. No local Ruby installation is required —
everything runs inside containers.

```
docker compose up
```

This starts PostgreSQL and the Rails app, creates and migrates the database,
seeds it with sample campaigns/investors/investments, and serves the app at

```
http://localhost:3000
```

Ports `3000` (Rails) and `5432` (Postgres) must be free on your machine.

### Running the test suite

```
docker compose run web bin/rails test
```

## Money

All monetary amounts are stored as **integer cents** and computed with
integer/`BigDecimal` math — never floats. Amounts are displayed as
`$1,234.00 MXN`.

## Investment rules

- The minimum investment is **500 MXN**. An invalid investment (below the
  minimum) re-renders the form in place with the validation error shown.
- Investing is **idempotent**: submitting the same investment twice (a
  double-click, a dropped connection and retry) records it once.
- After you invest, the funding progress bar and the recent-investors list
  update immediately, without reloading the page.

## Data model

- **Investor** — `name`, `email` (unique).
- **Campaign** — `name`, `description`, `product` (`DEUDA` or
  `COPROPIEDAD`), `goal_cents`, `annual_rate_bps` (annual interest rate in
  basis points, e.g. `1400` = 14.00%), `term_months`, `status` (`open` |
  `funded` | `closed`), `closes_on`.
- **Investment** — belongs to a `Campaign` and an `Investor`, `amount_cents`,
  and a client-generated `idempotency_key` used to make submitting the invest
  form safe to retry.

## Stack

Ruby on Rails 7.1, PostgreSQL 16, Hotwire (Turbo + Stimulus) via import maps,
plain CSS, Minitest.

## Prerequisites

- Docker Desktop, running
- Ports `3000` and `5432` free
- No local Ruby installation needed
