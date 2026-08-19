# ask-techsoup

A Claude Code plugin marketplace containing one skill, `ask-techsoup`, which
answers questions about TechSoup's nonprofit-technology offers by querying
the live product catalog at `https://offercenter.techsoup.org/resources/data/products.json`.

This is a private, TechSoup-internal repo — not for public distribution.

## Install (Claude Code)

```
/plugin marketplace add TechSoup/ask-techsoup
/plugin install ask-techsoup@ask-techsoup
```

Requires read access to this private repo on GitHub.

## Use

```
/ask-techsoup what security tools are discounted for nonprofits?
```

See [`plugins/ask-techsoup/skills/ask-techsoup/SKILL.md`](plugins/ask-techsoup/skills/ask-techsoup/SKILL.md)
for what the skill does and how it parses the feed.

## Repo layout

```
.claude-plugin/marketplace.json          # marketplace manifest
plugins/ask-techsoup/.claude-plugin/plugin.json   # plugin manifest
plugins/ask-techsoup/skills/ask-techsoup/SKILL.md # the skill itself
```

## Updating

After pushing changes, installed users run `/plugin marketplace update` to
pick up the latest version.
