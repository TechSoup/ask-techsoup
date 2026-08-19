# ask-techsoup

A Claude skill that answers questions about TechSoup's nonprofit-technology
offers — discounts, donations, eligibility — by querying the live product
catalog at `https://offercenter.techsoup.org/resources/data/products.json`.
It never answers from memory: pricing, discount tiers, and eligibility change,
so it always fetches fresh.

Currently private to TechSoup; the plan is to open this up more broadly
(other orgs, or a public release) once it's proven out here.

## Get started

Pick the surface you're using — the two are separate installs and are not synced:

- **Using Claude Code?** → [Install as a plugin](#claude-code)
- **Using Claude Desktop or claude.ai?** → [Install as a Skill](#claude-desktop--claudeai)

---

## Claude Code

Distributed as a Claude Code plugin via this repo's marketplace manifest.

```
/plugin marketplace add TechSoup/ask-techsoup
/plugin install ask-techsoup@ask-techsoup
```

Requires read access to this repo on GitHub. After a new push, run
`/plugin marketplace update` to pick up changes.

Use it with:

```
/ask-techsoup what security tools are discounted for nonprofits?
```

Source: [`plugins/ask-techsoup/skills/ask-techsoup/SKILL.md`](plugins/ask-techsoup/skills/ask-techsoup/SKILL.md)

## Claude Desktop / claude.ai

Custom Skills there are uploaded per-person as a zip — there's no org-wide
install yet, so each person repeats these steps:

1. Settings → Capabilities → turn on **"Code execution and file creation"**
   (on by default for Team/Enterprise; required on Free/Pro/Max). Also enable
   network access for code execution — the skill needs it to reach
   `offercenter.techsoup.org`.
2. Download the [`claude-ai/ask-techsoup/`](claude-ai/ask-techsoup/) folder
   from this repo.
3. Zip it so the `ask-techsoup/` folder is the **root of the zip** (not a
   loose `SKILL.md`, not double-wrapped):
   ```
   cd claude-ai && zip -r ask-techsoup.zip ask-techsoup
   ```
4. Settings → Features → **Skills** → **+** → **Create skill** → upload
   `ask-techsoup.zip`.

Use it by just asking Claude a question about TechSoup offers — no slash
command, it triggers automatically when relevant.

Source: [`claude-ai/ask-techsoup/SKILL.md`](claude-ai/ask-techsoup/SKILL.md)

---

## Repo layout

```
.claude-plugin/marketplace.json                    # Claude Code marketplace manifest
plugins/ask-techsoup/.claude-plugin/plugin.json    # Claude Code plugin manifest
plugins/ask-techsoup/skills/ask-techsoup/SKILL.md  # Claude Code skill
claude-ai/ask-techsoup/SKILL.md                    # Claude Desktop / claude.ai skill
```

The two `SKILL.md` files cover the same feed and answering logic; only the
installation instructions embedded in each differ per surface. Edit both when
changing how the skill queries or presents data.

## Updating

- **Claude Code** users: run `/plugin marketplace update` after a push.
- **Claude Desktop / claude.ai** users: re-download, re-zip, and re-upload
  the skill to replace the old version (there's no auto-update for this
  surface).
