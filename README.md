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
| GitHub Copilot | developer terminal tool / IDE | [GitHub Copilot](#github-copilot) |
| ChatGPT | regular chat app | [ChatGPT (Custom GPT)](#chatgpt-custom-gpt) |

Not sure which is yours? If you type commands in a terminal, use the CLI/IDE
row for your tool. If you just open a website or app and type in a chat box,
use Claude Desktop/claude.ai or ChatGPT.

---

## Claude Code

Distributed as a Claude Code plugin via this repo's marketplace manifest.

**Requires:**
- Read access to this repo on GitHub.
- **Git installed and on PATH.** If `/plugin marketplace add` fails with
  `Command 'git' not found`, git is either not installed or wasn't added to
  PATH. On Windows, this happens if the Git for Windows installer's PATH
  option was set to something other than the recommended one — re-run the
  [Git for Windows installer](https://git-scm.com/download/win) and choose
  **"Git from the command line and also from 3rd-party software"**, or add
  `C:\Program Files\Git\cmd` to PATH yourself via Environment Variables —
  then fully close and reopen your terminal (and Claude Code) before
  retrying. (No git, or don't want to deal with it? See the fallback below.)

Enter these **one command at a time** — type or paste only the first line,
press Enter, wait for it to confirm, then do the second. Pasting both lines
together can make some terminals merge them into a single invalid command:

1. `/plugin marketplace add TechSoup/ask-techsoup`
2. `/plugin install ask-techsoup@ask-techsoup`

After a new push, run `/plugin install ask-techsoup@ask-techsoup` again to
pull the latest version — `/plugin marketplace update` alone only refreshes
the marketplace listing, it doesn't update a plugin you've already installed.

Use it with:

```
/ask-techsoup what security tools are discounted for nonprofits?
```

### No git, or the plugin install is giving you trouble?

Skip the marketplace entirely and add it as a plain skill file instead — no
git, no GitHub clone, no plugin system involved:

1. Download the skill file: open
   [`claude-ai/ask-techsoup/SKILL.md`](claude-ai/ask-techsoup/SKILL.md) on
   GitHub and click the **download icon** at the top right of the file view
   (next to "Raw") to save `SKILL.md` — e.g. to your Downloads folder.
2. In the same terminal where Claude Code is running, just ask Claude
   directly to place it for you:
   > Move the SKILL.md file from my Downloads folder to
   > `~/.claude/skills/ask-techsoup/SKILL.md`, creating any folders that
   > don't exist.

   Claude Code has file access and will create the folder and move the file
   for you — no manual navigation, no git required.
3. Close and reopen Claude Code so it picks up the new skill.
4. Use it the same way — ask a question, or `/ask-techsoup <question>`.

Source: [`plugins/ask-techsoup/skills/ask-techsoup/SKILL.md`](plugins/ask-techsoup/skills/ask-techsoup/SKILL.md)

## Claude Desktop / claude.ai

Skills are added per-person — there's no org-wide install yet, so each person
repeats these steps. This skill is a single file (`SKILL.md`), so on the
Claude Desktop app you don't need to zip anything.

### Recommended: Claude Desktop app

1. **Turn on network access** — the skill needs this to reach
   `offercenter.techsoup.org` for live pricing/eligibility: **Settings →
   Capabilities** → turn on **"Code execution and file creation"** → also
   turn on **network access** for code execution. If this is greyed out,
   your workspace admin controls it — ask them to enable network access for
   code execution. (If Claude ever replies that it can't reach the catalog,
   this is almost always the cause — see "If it doesn't work" below.)
2. **Download the skill file:** open
   [`claude-ai/ask-techsoup/SKILL.md`](claude-ai/ask-techsoup/SKILL.md) on
   GitHub, then click the **download icon** at the top right of the file
   view (next to "Raw") to save `SKILL.md` to your computer. Don't use
   "Download ZIP" from the repo's main page — that downloads the whole repo,
   which you don't need.
3. In Claude Desktop, open the left sidebar → **Customize** → add a skill by
   uploading the `SKILL.md` file you just downloaded.
4. Don't see "Customize" in your sidebar? Claude is still rolling this
   feature out — use the fallback method below instead.

### Fallback: upload a zip file (claude.ai in a browser, or no "Customize" yet)

1. Go to the [repo's main page](https://github.com/TechSoup/ask-techsoup),
   click the green **`<> Code`** button → **Download ZIP**. This saves
   `ask-techsoup-main.zip` to your Downloads folder.
2. Unzip it:
   - **Mac:** double-click `ask-techsoup-main.zip`.
   - **Windows:** right-click it → **Extract All** → **Extract**.
3. Open the extracted `ask-techsoup-main` folder → open `claude-ai` → find
   the `ask-techsoup` folder. Select it, but don't open it.
4. Compress just that folder:
   - **Mac:** right-click `ask-techsoup` → **Compress "ask-techsoup"** →
     this creates `ask-techsoup.zip` next to it.
   - **Windows:** right-click `ask-techsoup` → **Send to** → **Compressed
     (zipped) folder** → this creates `ask-techsoup.zip` next to it.
5. In Claude: **Settings → Features → Skills → + → Create skill** → upload
   `ask-techsoup.zip`.
6. Turn on network access as described in step 1 above.

### Using it

Just ask Claude a question about TechSoup offers — no slash command, it
triggers automatically when relevant.

**If it doesn't work:** if Claude replies that it can't reach the TechSoup
catalog, network access for code execution is almost certainly off — see
step 1 above, or ask your workspace admin to enable it org-wide.

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

## GitHub Copilot

Copilot added support for the same `SKILL.md` convention in April 2026.
Works the same way in both GitHub Copilot CLI and GitHub Copilot in VS Code.

1. Copy the [`copilot/ask-techsoup/`](copilot/ask-techsoup/) folder from
   this repo.
2. Place it at `~/.copilot/skills/ask-techsoup/` (every project) or
   `.github/skills/ask-techsoup/` inside one project (shareable with your
   team via git; also recognized: `.claude/skills/` or `.agents/skills/`).
3. Restart Copilot (CLI) or reload the window (VS Code) if it doesn't pick
   the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`copilot/ask-techsoup/SKILL.md`](copilot/ask-techsoup/SKILL.md)

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
copilot/ask-techsoup/SKILL.md                      # generated — GitHub Copilot

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

- **Claude Code** users: run `/plugin install ask-techsoup@ask-techsoup`
  after a push (`/plugin marketplace update` alone won't update an
  already-installed plugin). If you used the no-git fallback method instead,
  re-download `SKILL.md` and ask Claude to replace the file at
  `~/.claude/skills/ask-techsoup/SKILL.md`.
- **Claude Desktop / claude.ai** users: re-download `SKILL.md` (Customize
  method) or re-zip and re-upload (fallback method), then remove the old
  version of the skill before adding the new one.
- **Gemini CLI, Antigravity, Codex CLI, GitHub Copilot** users: re-download
  the relevant folder and replace your local copy (there's no auto-update
  for these surfaces).
- **ChatGPT** users: re-copy `chatgpt/instructions.md` into the GPT's
  Instructions box and save.
