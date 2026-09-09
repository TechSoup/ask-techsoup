# Takeaway document template

Read this file only when actually building a takeaway document (SKILL.md §5).
Don't design a new layout from scratch — reuse this one, filling in the
offers that were actually discussed. That's what keeps every takeaway
document produced by this skill looking like the same product instead of a
one-off, and it's faster because the layout decision is already made.

This mirrors the visual identity of the live Offer Center
(`offercenter.techsoup.org`, source in the `Verbose-Knowledge-Base` project's
`Offer-Center/style.css`) — same color tokens, same card/pill shapes — but
it's a static "here's what we found" handout, not the interactive app: no
sidebar, no filters, no search. Just the header, the matched offers as
cards, and a footer.

Font is **Atkinson Hyperlegible Next** (the live Offer Center currently uses
the older "Atkinson Hyperlegible" — intentionally using the newer one here).

## Two delivery modes

Check which one applies before writing the file:

- **Artifact tool available** (e.g. Claude Code, claude.ai): use the HTML
  block below exactly as written — `<title>` and `<style>` at the top,
  followed by the body content. Do **not** add `<!DOCTYPE>`, `<html>`,
  `<head>`, or `<body>` tags — the Artifact tool supplies those. Load the
  `artifact-design` skill before publishing, per its own rules, and pass a
  one/two-emoji `favicon` (suggest 🧾) and a short `title` on first publish.
- **Local file only** (no Artifact tool): wrap the same block in a minimal
  standalone shell before saving:

  ```html
  <!doctype html>
  <html lang="en">
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- the <title> and <style> from the block below go here -->
  </head>
  <body>
  <!-- the body content from the block below goes here -->
  </body>
  </html>
  ```

## What to fill in

- Page `<title>`: just `{{topic}}` (e.g. "Security Tools Comparison") — the
  `<title>` tag is what names the page in the Artifact gallery/tab, and a
  name plus an appended explainer reads as filler there. "Ask TechSoup"
  branding goes in the visible header eyebrow instead, not the tab title.
- Header subtitle: one line of context on what was compared/looked up, plus
  the date generated.
- One `.category-section` per category present among the matched offers
  (omit categories with no matches — don't render empty sections).
- One `.product-card` per matched offer. Populate from the catalog fields
  documented in SKILL.md §2: `product_name`, `category`, `sub_category`,
  `cost`, `eligible_audience_labels`, `eligible_countries`, `last_audited`,
  `vendor_url`, `badges`.
- Footer: generation date, "Data via TechSoup Offer Center
  (offercenter.techsoup.org)," and the CC-BY-SA-4.0 / CC-BY-4.0 note **only**
  if the user is republishing/redistributing (per SKILL.md §3 — same
  condition as in normal answers).
- If nothing was eligible/matched for a comparison the user asked about, say
  so in place of a card rather than omitting it silently — same rule as a
  normal chat answer.

Don't add sections this template doesn't have (no search box, no filter UI,
no "load more") — it's a static handout, not a rebuild of the app.

## The template

```html
<title>{{topic}}</title>
<style>
  :root {
    --ts-red: #FF4A00;
    --ts-paleRed: #F5F4F0;
    --ts-text: #0D0D0D;
    --ts-lightG: #E4E4E4;
    --ts-darkG: #1A1A1A;
    --ts-gray: #b9b9b9;
    --ts-midGray: #484848;
    --bg: #ffffff;
    --card-bg: #ffffff;
    --muted: #484848;
    color-scheme: light;
  }
  @media (prefers-color-scheme: dark) {
    :root:not([data-theme="light"]) {
      --bg: var(--ts-text);
      --card-bg: var(--ts-text);
      --ts-text: var(--ts-lightG);
      --ts-lightG: var(--ts-midGray);
      --muted: var(--ts-gray);
      color-scheme: dark;
    }
  }
  :root[data-theme="dark"] {
    --bg: #0D0D0D;
    --card-bg: #0D0D0D;
    --ts-text: #E4E4E4;
    --ts-lightG: #484848;
    --muted: #b9b9b9;
    color-scheme: dark;
  }
  * { box-sizing: border-box; }
  body {
    font-family: 'Atkinson Hyperlegible Next', system-ui, sans-serif;
    background: var(--bg);
    color: var(--ts-text);
    margin: 0;
    padding: 1.75rem clamp(16px, 4vw, 1.75rem);
  }
  header {
    border-bottom: 2px solid var(--ts-red);
    padding-bottom: 1rem;
    margin-bottom: 2rem;
  }
  .eyebrow {
    display: block;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--ts-red);
    margin-bottom: 0.5rem;
  }
  header h1 {
    font-size: clamp(1.5rem, 4vw, 2.25rem);
    letter-spacing: -0.01em;
    margin: 0 0 0.35rem;
  }
  header p {
    margin: 0;
    color: var(--muted);
    font-size: 0.95rem;
  }
  .category-section { margin-bottom: 2rem; }
  .category-title {
    font-size: 1.4rem;
    letter-spacing: -0.02em;
    margin-bottom: 1rem;
  }
  .category-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 1rem;
  }
  .product-card {
    border: 1px solid var(--ts-lightG);
    border-radius: 10px;
    padding: 1.25rem;
    background: var(--card-bg);
    display: flex;
    flex-direction: column;
  }
  .product-card .category {
    font-size: 0.75rem;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: 0.05em;
    font-weight: 600;
  }
  .product-card h3 {
    font-size: 1.25rem;
    margin: 0.5rem 0;
  }
  .badge-row {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem;
    margin-bottom: 0.75rem;
  }
  .badge {
    background: var(--ts-paleRed);
    color: var(--ts-text);
    border-radius: 50px;
    padding: 0.25rem 0.7rem;
    font-size: 0.7rem;
    font-weight: 600;
  }
  @media (prefers-color-scheme: dark) {
    :root:not([data-theme="light"]) .badge { background: var(--ts-midGray); }
  }
  :root[data-theme="dark"] .badge { background: var(--ts-midGray); }
  .product-card .cost { font-size: 0.95rem; font-weight: 600; margin: 0.25rem 0; }
  .product-card .details {
    font-size: 0.85rem;
    color: var(--muted);
    display: flex;
    flex-direction: column;
    gap: 0.15rem;
    margin-bottom: 1rem;
  }
  .vendor-link {
    margin-top: auto;
    display: block;
    text-align: center;
    text-decoration: none;
    border: 1px solid var(--ts-darkG);
    color: var(--ts-text);
    border-radius: 50px;
    padding: 0.6rem;
    font-size: 0.9rem;
    font-weight: 600;
  }
  @media (prefers-color-scheme: dark) {
    :root:not([data-theme="light"]) .vendor-link { border-color: var(--ts-lightG); }
  }
  :root[data-theme="dark"] .vendor-link { border-color: var(--ts-lightG); }
  .no-match { color: var(--muted); font-style: italic; }
  footer {
    margin-top: 2.5rem;
    padding-top: 1.25rem;
    border-top: 1px solid var(--ts-lightG);
    font-size: 0.8rem;
    color: var(--muted);
  }
  footer a { color: inherit; }
</style>

<header>
  <span class="eyebrow">Ask TechSoup</span>
  <h1>{{topic}}</h1>
  <p>{{one-line context}} · Generated {{date}}</p>
</header>

<section class="category-section">
  <h2 class="category-title">{{Category name}}</h2>
  <div class="category-grid">
    <div class="product-card">
      <span class="category">{{category}} · {{sub_category}}</span>
      <h3>{{product_name}}</h3>
      <div class="badge-row">
        <!-- one .badge per entry in badges[], plus eligible_audience_labels if useful -->
        <span class="badge">{{badge}}</span>
      </div>
      <p class="cost">{{cost}}</p>
      <div class="details">
        <span>Eligible: {{eligible_audience_labels joined}}</span>
        <span>Countries: {{eligible_countries joined, or "Worldwide" if ["ALL"]}}</span>
        <span>Last audited: {{last_audited}}</span>
      </div>
      <a class="vendor-link" href="{{vendor_url}}">Visit vendor site</a>
    </div>
    <!-- repeat .product-card per matched offer in this category -->
  </div>
</section>
<!-- repeat .category-section per category present -->

<footer>
  <p>Generated {{date}} · Data via TechSoup Offer Center (offercenter.techsoup.org)</p>
  <!-- add license line here only if the user is republishing/redistributing:
       "Catalog data © TechSoup Global Network, CC-BY-SA-4.0. Org-type/subject
       codes © Candid, CC-BY-4.0, modified." -->
</footer>
```
