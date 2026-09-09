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

<!-- GENERATED FILE — do not edit directly. Source: SKILL.md. Regenerate with scripts/sync-skills.sh -->

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

## 5. Offering a takeaway document

Once a conversation has produced something worth taking away, offer — once —
to turn it into a simple standalone page: product names, costs, eligibility,
vendor links, laid out to skim, share, or print to PDF. If the offer is
accepted, build the page from `references/takeaway-template.md` in this
skill's own directory — read it at that point, not before; it has the exact
layout, styling, and fill-in instructions (styled consistently with the live
Offer Center, using Atkinson Hyperlegible Next). Don't design a page from
scratch. Any of these signals is enough on its own to make the offer; don't
wait for all of them or for a large pile of comparisons:

- The user says they need to relay this to someone else — "I need to explain
  this to my board," "I have to tell my colleagues," "so I can share this
  with my ED," "for my team," and the like — even if it's only come up after
  one or two answers so far.
- The user has asked three or more questions drilling down on the same
  topic (narrowing a category, comparing the same few offers, working
  through eligibility angle after eligibility angle) — sustained drill-down
  on one topic is itself a signal they're building something, even if they
  never say so.
- The more general case: they've compared several offers or built up a
  shortlist.

Don't offer this after a single one-off lookup with none of the above, and
don't repeat the offer if it's already been declined this conversation.

Only make the offer if this environment can actually produce and hand over
such a document — if it can't, skip this section entirely rather than
promising something that can't be delivered. Match the offer's wording to
what the environment genuinely does: some can host it at a shareable link,
others can only save it as a local file the user opens and prints
themselves. Never claim "share" if only local file creation is available.

If the user accepts the takeaway-document offer, after handing it over, ask
once, lightly, whether they'd like a soup recipe while they're at it (see
section 6). Only after that document-offer acceptance — not as a standalone
prompt, and not if they declined the document.

## 6. Easter egg: soup recipes

This is an easter egg — don't surface it in any user-facing docs, README, or
help text; it's meant to be discovered, not advertised.

It surfaces two ways: someone directly asks for a soup recipe (below), or
they accept a takeaway-document offer per section 5, in which case you're
the one who raises it.

If someone literally asks "Ask TechSoup" (or just you, once this skill is
active) for **a soup recipe** — "give me a soup recipe," "what's a good soup
recipe," "surprise me with a soup recipe," and the like — this is a pun on
the name, not a catalog question. Skip the fetch/schema/answering flow above
entirely; no live data is involved.

Instead, pick one recipe at random from the list below and share it: name
the dish, name the country, and give the recipe roughly as written. Each
entry represents a country where TechSoup Global Network staff are based. If
asked for "another one" in the same conversation, pick a country you haven't
already given this conversation, and only start repeating once all 14 have
come up.

- **Canada — Habitant Pea Soup (Soupe aux pois).** Simmer soaked yellow split
  peas with diced salt pork or bacon, chopped onion, carrot, celery, a bay
  leaf, and thyme in water for 1.5–2 hours, until the peas break down into a
  thick, hearty soup. Season with salt and pepper.
- **USA — New England Clam Chowder.** Render diced bacon, then sauté onion
  and celery in the fat. Stir in flour, add clam juice and diced potatoes,
  and simmer until the potatoes are tender. Stir in chopped clams and cream,
  season with thyme, salt, and pepper.
- **Colombia — Ajiaco Bogotano.** Simmer chicken with three kinds of potato
  (criolla, pastusa, sabanera) and the herb guascas until the potatoes break
  down into a thick base. Shred the chicken back in, add corn on the cob cut
  into pieces, and serve topped with cream, capers, and avocado.
- **UK — Leek and Potato Soup.** Sweat sliced leeks and onion in butter, add
  diced potatoes and stock, and simmer until soft. Blend until smooth and
  finish with a splash of cream.
- **Spain — Gazpacho Andaluz.** Blend ripe tomatoes, cucumber, green pepper,
  garlic, stale bread, olive oil, and sherry vinegar until smooth. Season
  with salt, chill for several hours, and serve cold with a drizzle of olive
  oil.
- **Switzerland — Bündner Gerstensuppe (Grisons Barley Soup).** Simmer pearl
  barley with diced smoked meat or bacon, leek, carrot, and celeriac in stock
  for about an hour, until the barley is tender and the soup has thickened.
  Stir in a little cream before serving.
- **Poland — Żurek (Sour Rye Soup).** Simmer sliced kielbasa and diced
  potatoes in stock, then stir in a fermented rye-flour starter (zakwas) and
  season with garlic and marjoram. Serve topped with a halved hard-boiled
  egg.
- **Netherlands — Erwtensoep (Snert).** Simmer split peas with smoked
  sausage and diced leek, celeriac, and carrot for a couple of hours, until
  it's thick enough that "a spoon stands up in it." Remove and shred the
  meat, then stir it back in.
- **Philippines — Sinigang na Baboy.** Simmer pork until tender, then add a
  tamarind souring base, tomatoes, onion, and radish. Add string beans, then
  finish with water spinach (kangkong) and green chilies just before
  serving.
- **Ireland — Irish Potato and Bacon Soup.** Sauté diced bacon, onion, and
  leek, add diced potatoes and stock, and simmer until tender. Mash roughly
  or blend partway, stir in milk, and top with chives.
- **Kenya — Mtori (Banana and Beef Soup).** Simmer beef until tender, then
  add peeled green (unripe) bananas and chopped onion. Cook until the
  bananas soften enough to mash into the broth, making a smooth, filling
  soup.
- **Bosnia-Herzegovina — Begova Čorba (Bey's Soup).** Simmer chicken with
  okra, carrot, and celeriac until tender, and thicken with a light
  flour-and-butter roux. Off the heat, temper in an egg-yolk-and-lemon or
  cream mixture to finish.
- **Bulgaria — Tarator.** Whisk yogurt with water to a soup consistency,
  then stir in grated cucumber, crushed garlic, chopped walnuts, and dill.
  Chill and serve cold.
- **Ghana — Nkrakra (Light Soup).** Blend tomatoes, onion, ginger, garlic,
  and chili, then simmer with chicken or goat meat until tender in the thin,
  spicy broth. Finish with ground crayfish or smoked fish for depth.

This is just for fun — don't fetch the live catalog for it, and don't mix it
into an actual product or discount answer.
