---
name: ask-techsoup
description: >-
  Answer questions about technology discounts and donations available to
  nonprofits worldwide — a catalog of third-party vendor offers vetted and
  maintained by TechSoup (distinct from TechSoup's own technology offerings) —
  by querying the live product catalog at offercenter.techsoup.org. Use
  whenever the user asks what discounts/donations are available for a product
  or vendor, wants offers in a category (security, fundraising, AI, etc.),
  asks whether a specific org type, audience, or country is eligible for
  something, or wants to compare offers. Always queries the live feed rather
  than answering from memory, since prices, discount tiers, and eligibility
  change.
---

# Ask TechSoup

Answers questions about technology discounts and donations available to
nonprofits worldwide — a catalog of third-party vendor offers that TechSoup
vets and maintains (distinct from TechSoup's own technology offerings) — by
querying the **live, canonical data feed** — never answer from training data.
Offer pricing, discount tiers, and eligibility rules (including which
countries an offer is open to) change over time, and a stale or invented
answer about a discount is actively harmful to a nonprofit relying on it.

This feed is the production output of TechSoup's VKB pipeline (Markdown
"Intelligent Packages" → compiled `products.json` "headless API" → Offer
Center frontend) — it's the same shape documented in the `Verbose-Knowledge-Base`
project, just the live hosted copy instead of a local build.

## 1. Fetch the data

At the start of a session (or whenever asked about something the already-fetched
copy might not reflect), fetch fresh:

```bash
curl -s --max-time 8 https://offercenter.techsoup.org/resources/data/products.json
```

Save it to a scratch file and parse with `jq` or Python rather than re-fetching
for every follow-up question within the same exchange — the catalog doesn't
change mid-conversation.

**If the fetch fails, try once more** (a single fast retry, in case of a
one-off blip). If it fails a second time, stop — do not retry further, do
not fall back to web search, training data, or general knowledge of
TechSoup's public website. This matters specifically because Offer Center's
live catalog includes offers beyond what's listed on techsoup.org's public
pages, so a "here's what I generally know" substitute would understate what's
actually available — worse than saying nothing. Do not answer the original
question until a fetch succeeds.

Respond immediately (no extra tool calls, no hedged partial answer) with an
error message:

- **If the environment itself reports network access is disabled** (a
  distinct signal, not just a generic connection failure) — say so directly
  and specifically: network access for code execution is turned off, so you
  can't reach the live TechSoup catalog; enable it under **Settings →
  Capabilities → "Code execution and file creation"**, or ask your workspace
  admin if it's controlled org-wide.
- **Otherwise** (timeout, connection refused, DNS failure, error status, or
  an empty/invalid response — i.e. the cause can't be pinned down for
  certain) — give the three most likely reasons as a short checklist, each
  with how to check it:
  1. Network access may not be enabled for code execution — this could be a
     setting you or your workspace administrator control. Check
     **Settings → Capabilities → "Code execution and file creation."**
  2. Offer Center could be down right now. To check, paste
     `https://offercenter.techsoup.org/resources/data/products.json` into a
     browser — if it doesn't load there either, it's not your settings.
  3. There may be a temporary network or firewall issue on your end — try
     again in a few minutes.

## 2. Schema reference

Top level is `{ meta, products }`.

`meta` includes:
- `profile`: e.g. `"civic/0.5"` — this is TechSoup's `x-civic` OKF profile.
- `license`: data is TechSoup Global Network, **CC-BY-SA-4.0**; the PCS subject/org-type
  taxonomy embedded in eligibility fields is Candid's Philanthropy Classification
  System, **CC-BY-4.0**, modified.
- `audiences`: canonical definitions for each `eligible_audiences` value —
  `label`, `org_types` (PCS org-type codes, or `"ALL"`), `pcs_subject` (PCS subject
  codes, or `"ALL"`), and sometimes `ui`/`needs_review` flags. Known audiences:
  `everyone`, `nonprofit`, `public_library`, `social_enterprise`, `healthcare`,
  `k12`, `personal`, `team`. Cross-reference this block when a question is about
  eligibility for a specific org type rather than just an audience label.

Each entry in `products` (~140+ items, count varies as the catalog changes):

```jsonc
{
  "id": "techsoup:1password",
  "type": "offer",
  "product_name": "1Password for Nonprofits",
  "category": "Security",              // AI, Communications, Fundraising,
                                        // Infrastructure, Operations, Programs, Security
  "sub_category": "General",
  "cost": "50% Discount",              // free-text: "Donation", "$X/year", "Free", etc.
  "max_budget": null,
  "min_budget": 0,
  "eligible_countries": ["US"],        // most common value is ["ALL"] (open
                                        // worldwide); some are restricted to
                                        // specific ISO codes, e.g. ["CA","US"]
  "eligible_audiences": ["nonprofit"],
  "audience_tuples": [{ "org_types": [...], "pcs_subject": [...] }],
  "eligible_audience_labels": ["Nonprofit"],
  "eligibility_pcs_subject": ["ALL"],
  "last_audited": "2026-05-16",        // how current the eligibility info is
  "vendor_url": "https://...",
  "badges": ["Discount"],              // Discount, Donation, Open Source,
                                        // Built for Nonprofits, Discovery
  "standard_tier": null,
  "savings_estimate": null,
  "rules": null,
  "slug": "1password",
  "relations": []                      // rare; e.g. {"target":"openai","type":"alternative","note":"..."}
}
```

## 3. Answering

- Filter/search across `category`, `cost`, `eligible_audiences`,
  `eligible_audience_labels`, `badges`, `product_name`, `vendor_url`, and
  `eligible_countries` as the question requires.
- For each match, report: **product name, category, cost, who it's eligible
  for, which countries, vendor link, and `last_audited`** — the audit date
  tells the user how current the eligibility claim is.
- For an eligibility question tied to a specific org type or subject code
  (rather than a plain-language audience like "nonprofit" or "library"),
  cross-reference `meta.audiences[...].org_types` / `.pcs_subject`, and note
  `"ALL"` means no restriction on that axis.
- Check `eligible_countries` on every match before saying an offer is
  available — most entries are `["ALL"]` (open to nonprofits worldwide), but
  some are restricted to specific countries (e.g. `["US"]`, `["CA","US"]`).
  Never default to assuming US-only or any other country; state the actual
  restriction (or confirm it's worldwide) for that specific offer.
- If nothing matches, say so plainly — do not invent an offer, vendor, or
  discount percentage.
- Mention the CC-BY-SA-4.0 / CC-BY-4.0 licensing only if the user is
  republishing or redistributing results, not for a simple lookup.
- If `relations` links to an alternative product, mention it when comparing
  options in the same space.

## 4. Presentation

Default to a short table or bullet list (Product | Category | Cost | Eligible
for | Vendor link). Scope the answer to what was asked — don't dump the full
catalog unless the user explicitly wants to browse everything.
