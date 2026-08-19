# ask-techsoup

> An AI skill that answers questions about technology discounts and donations available to nonprofits worldwide — a catalog vetted and maintained by TechSoup — by querying the live product catalog, never from memory.

![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-blue.svg)
![Status](https://img.shields.io/badge/status-private%20preview-orange)
![Maintained by TechSoup](https://img.shields.io/badge/maintained%20by-TechSoup%20Global%20Network-blueviolet)

Answers questions about technology discounts and donations available to
nonprofits — no matter where they are — by querying the live product catalog
at `https://offercenter.techsoup.org/resources/data/products.json`. This
catalog is third-party vendor offers that TechSoup vets and maintains (not
TechSoup's own technology offerings). Eligibility is per-offer: most are open
worldwide, some are restricted to specific countries — the skill always
checks each offer's own `eligible_countries` rather than assuming one. It
never answers from memory: pricing, discount tiers, and eligibility change,
so it always fetches fresh.

Currently private to TechSoup and invited partners; the plan is to open this
up more broadly (other orgs, or a public release) once it's proven out here.
This repo is licensed CC BY-SA 4.0 — see [LICENSE](LICENSE) — so anyone it's
shared with is free to reuse and adapt it as long as derivatives carry the
same license and give attribution.

## Get started

Pick the AI tool you use — each is a separate install, and none of them sync
with each other:

| I use... | It's a... | Go to |
|---|---|---|
| Claude Code | developer terminal tool | [Claude Code](#claude-code) |
| Claude Desktop / claude.ai | regular chat app | [Claude Desktop / claude.ai](#claude-desktop--claudeai) |
| Gemini CLI | developer terminal tool | [Gemini CLI](#gemini-cli) |
| Google Antigravity | developer/agentic IDE | [Google Antigravity](#google-antigravity) |
| Codex CLI | developer terminal tool | [Codex CLI (OpenAI)](#codex-cli-openai) |
| ChatGPT | regular chat app | [ChatGPT (Custom GPT)](#chatgpt-custom-gpt) |

Not sure which is yours? If you type commands in a terminal, use the CLI/IDE
row for your tool. If you just open a website or app and type in a chat box,
use Claude Desktop/claude.ai or ChatGPT.

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

## Gemini CLI

Uses the same Agent Skills folder convention as Claude Code.

1. Copy the [`gemini-cli/ask-techsoup/`](gemini-cli/ask-techsoup/) folder
   from this repo.
2. Place it at `~/.gemini/skills/ask-techsoup/` (available in every project)
   or `.gemini/skills/ask-techsoup/` inside one project (that project only).
3. Restart Gemini CLI if it doesn't pick the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`gemini-cli/ask-techsoup/SKILL.md`](gemini-cli/ask-techsoup/SKILL.md)

## Google Antigravity

Also uses the Agent Skills folder convention.

1. Copy the [`antigravity/ask-techsoup/`](antigravity/ask-techsoup/) folder
   from this repo.
2. Place it at `.agent/skills/ask-techsoup/` inside your project (shareable
   with your team via git) or `~/.gemini/antigravity/skills/ask-techsoup/`
   for every project on your machine.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`antigravity/ask-techsoup/SKILL.md`](antigravity/ask-techsoup/SKILL.md)

## Codex CLI (OpenAI)

Codex CLI also supports the same SKILL.md convention.

1. Copy the [`codex-cli/ask-techsoup/`](codex-cli/ask-techsoup/) folder from
   this repo.
2. Place it at `~/.codex/skills/ask-techsoup/` (every project) or
   `.agents/skills/ask-techsoup/` inside one project.
3. Restart Codex CLI if it doesn't pick the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`codex-cli/ask-techsoup/SKILL.md`](codex-cli/ask-techsoup/SKILL.md)

## ChatGPT (Custom GPT)

The most different of the bunch — ChatGPT doesn't run a terminal, so instead
of fetching the data itself it calls a pre-defined Action (basically a single
API call) that's already set up for you. No coding required, just copy/paste
into ChatGPT's builder.

Full click-by-click steps: [`chatgpt/README.md`](chatgpt/README.md)

Source: [`chatgpt/instructions.md`](chatgpt/instructions.md) and
[`chatgpt/action-schema.yaml`](chatgpt/action-schema.yaml)

---

## Repo layout

```
skill/SKILL.md                                     # single source of truth for the skill's logic
scripts/sync-skills.sh                             # regenerates every SKILL.md below from skill/SKILL.md

.claude-plugin/marketplace.json                    # Claude Code marketplace manifest
plugins/ask-techsoup/.claude-plugin/plugin.json    # Claude Code plugin manifest
plugins/ask-techsoup/skills/ask-techsoup/SKILL.md  # generated — Claude Code
claude-ai/ask-techsoup/SKILL.md                    # generated — Claude Desktop / claude.ai
gemini-cli/ask-techsoup/SKILL.md                   # generated — Gemini CLI
antigravity/ask-techsoup/SKILL.md                  # generated — Google Antigravity
codex-cli/ask-techsoup/SKILL.md                    # generated — Codex CLI

chatgpt/instructions.md                            # hand-maintained — ChatGPT Custom GPT (no shell, calls an Action instead)
chatgpt/action-schema.yaml                          # the Action's OpenAPI schema
chatgpt/README.md                                  # click-by-click GPT setup
```

**To change what the skill does or how it answers:** edit `skill/SKILL.md`
only, then run `./scripts/sync-skills.sh` and commit the regenerated files —
don't hand-edit any file marked `# generated` above, your edit will be
overwritten next sync. `chatgpt/instructions.md` can't be auto-generated
(ChatGPT has no filesystem/bash access, so its "fetch the data" step calls an
Action instead of running `curl`) — update it by hand to match whenever
`skill/SKILL.md`'s schema or answering logic changes.

## Updating

- **Claude Code** users: run `/plugin marketplace update` after a push.
- **Claude Desktop / claude.ai, Gemini CLI, Antigravity, Codex CLI** users:
  re-download the relevant folder and replace your local copy (there's no
  auto-update for these surfaces).
- **ChatGPT** users: re-copy `chatgpt/instructions.md` into the GPT's
  Instructions box and save.
