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
| Microsoft 365 Copilot (Word, Excel, SharePoint, OneDrive) | regular chat app, built into Office | [Microsoft 365 Copilot](#microsoft-365-copilot-untested) — **untested** |

Not sure which is yours? If you type commands in a terminal, use the CLI/IDE
row for your tool. If you just open a website or app and type in a chat box,
use Claude Desktop/claude.ai, ChatGPT, or Microsoft 365 Copilot.

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

Skip the marketplace entirely and add it as a plain skill folder instead — no
git, no GitHub clone, no plugin system involved:

1. Download two files from this repo on GitHub, each via the **download
   icon** at the top right of the file view (next to "Raw") — save both to
   your Downloads folder:
   - [`SKILL.md`](SKILL.md)
   - [`references/takeaway-template.md`](references/takeaway-template.md)
2. In the same terminal where Claude Code is running, just ask Claude
   directly to place them for you:
   > Move SKILL.md from my Downloads folder to
   > `~/.claude/skills/ask-techsoup/SKILL.md`, and move
   > takeaway-template.md to
   > `~/.claude/skills/ask-techsoup/references/takeaway-template.md`,
   > creating any folders that don't exist.

   Claude Code has file access and will create the folders and move the
   files for you — no manual navigation, no git required.
3. Close and reopen Claude Code so it picks up the new skill.
4. Use it the same way — ask a question, or `/ask-techsoup <question>`.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## Claude Desktop / claude.ai

Skills are added per-person — there's no org-wide install yet, so each person
repeats these steps. This skill is two files (`SKILL.md` plus a
`references/` folder), so it's installed as a zip regardless of which upload
path you use below.

### 1. Build the zip

1. Download both files from GitHub, each via the **download icon** at the
   top right of the file view (next to "Raw") — don't use "Download ZIP"
   from the repo's main page, that downloads the whole repo, which you don't
   need:
   - [`SKILL.md`](SKILL.md)
   - [`references/takeaway-template.md`](references/takeaway-template.md)
2. Create a folder named exactly `ask-techsoup`, put `SKILL.md` directly
   inside it, then create a `references` subfolder inside that and put
   `takeaway-template.md` there — so you end up with:
   ```
   ask-techsoup/
     SKILL.md
     references/
       takeaway-template.md
   ```
3. Compress the `ask-techsoup` folder:
   - **Mac:** right-click `ask-techsoup` → **Compress "ask-techsoup"** →
     this creates `ask-techsoup.zip` next to it.
   - **Windows:** right-click `ask-techsoup` → **Send to** → **Compressed
     (zipped) folder** → this creates `ask-techsoup.zip` next to it.

### 2. Upload it

- **Claude Desktop app, if you have "Customize" in the left sidebar:**
  **Customize** → add a skill → upload `ask-techsoup.zip`.
- **claude.ai in a browser, or no "Customize" yet:** **Settings → Features →
  Skills → + → Create skill** → upload `ask-techsoup.zip`.

### 3. Turn on network access

The skill needs this to reach `offercenter.techsoup.org` for live
pricing/eligibility: **Settings → Capabilities** → turn on **"Code execution
and file creation"** → also turn on **network access** for code execution.
If this is greyed out, your workspace admin controls it — ask them to
enable network access for code execution.

### Using it

Just ask Claude a question about TechSoup offers — no slash command, it
triggers automatically when relevant.

**If it doesn't work:** if Claude replies that it can't reach the TechSoup
catalog, network access for code execution is almost certainly off — see
step 3 above, or ask your workspace admin to enable it org-wide.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## Gemini CLI

Uses the same Agent Skills folder convention as Claude Code.

1. Download both [`SKILL.md`](SKILL.md) and
   [`references/takeaway-template.md`](references/takeaway-template.md) from
   this repo (open each on GitHub, click the **download icon** at the top
   right of the file view, next to "Raw").
2. Create a folder named `ask-techsoup`, put `SKILL.md` inside it, and put
   `takeaway-template.md` inside a `references` subfolder within it (so
   `ask-techsoup/references/takeaway-template.md`). Place that folder at
   `~/.gemini/skills/ask-techsoup/` (available in every project) or
   `.gemini/skills/ask-techsoup/` inside one project (that project only).
3. Restart Gemini CLI if it doesn't pick the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## Google Antigravity

Also uses the Agent Skills folder convention.

1. Download both [`SKILL.md`](SKILL.md) and
   [`references/takeaway-template.md`](references/takeaway-template.md) from
   this repo (open each on GitHub, click the **download icon** at the top
   right of the file view, next to "Raw").
2. Create a folder named `ask-techsoup`, put `SKILL.md` inside it, and put
   `takeaway-template.md` inside a `references` subfolder within it (so
   `ask-techsoup/references/takeaway-template.md`). Place that folder at
   `.agent/skills/ask-techsoup/` inside your project (shareable with your
   team via git) or `~/.gemini/antigravity/skills/ask-techsoup/` for every
   project on your machine.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## Codex CLI (OpenAI)

Codex CLI also supports the same SKILL.md convention.

1. Download both [`SKILL.md`](SKILL.md) and
   [`references/takeaway-template.md`](references/takeaway-template.md) from
   this repo (open each on GitHub, click the **download icon** at the top
   right of the file view, next to "Raw").
2. Create a folder named `ask-techsoup`, put `SKILL.md` inside it, and put
   `takeaway-template.md` inside a `references` subfolder within it (so
   `ask-techsoup/references/takeaway-template.md`). Place that folder at
   `~/.codex/skills/ask-techsoup/` (every project) or
   `.agents/skills/ask-techsoup/` inside one project.
3. Restart Codex CLI if it doesn't pick the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## GitHub Copilot

Copilot added support for the same `SKILL.md` convention in April 2026.
Works the same way in both GitHub Copilot CLI and GitHub Copilot in VS Code.

1. Download both [`SKILL.md`](SKILL.md) and
   [`references/takeaway-template.md`](references/takeaway-template.md) from
   this repo (open each on GitHub, click the **download icon** at the top
   right of the file view, next to "Raw").
2. Create a folder named `ask-techsoup`, put `SKILL.md` inside it, and put
   `takeaway-template.md` inside a `references` subfolder within it (so
   `ask-techsoup/references/takeaway-template.md`). Place that folder at
   `~/.copilot/skills/ask-techsoup/` (every project) or
   `.github/skills/ask-techsoup/` inside one project (shareable with your
   team via git; also recognized: `.claude/skills/` or `.agents/skills/`).
3. Restart Copilot (CLI) or reload the window (VS Code) if it doesn't pick
   the skill up immediately.

Use it by asking a question about TechSoup offers — it triggers
automatically when relevant.

Source: [`SKILL.md`](SKILL.md), [`references/takeaway-template.md`](references/takeaway-template.md)

## ChatGPT (Custom GPT)

The most different of the bunch — ChatGPT doesn't run a terminal, so instead
of fetching the data itself it calls a pre-defined Action (basically a single
API call) that's already set up for you. No coding required, just copy/paste
into ChatGPT's builder.

Full click-by-click steps: [`chatgpt/README.md`](chatgpt/README.md)

Source: [`chatgpt/instructions.md`](chatgpt/instructions.md) and
[`chatgpt/action-schema.yaml`](chatgpt/action-schema.yaml)

## Microsoft 365 Copilot (untested)

⚠️ **These steps haven't been run end-to-end against a real tenant yet.**
They're written from Microsoft's documentation, not from a confirmed working
setup — expect to troubleshoot. Update this section (and remove this
warning) once someone's verified it works.

A different product from GitHub Copilot, and from every other row in this
table — it's the Copilot built into Word, Excel, SharePoint, and OneDrive.
It doesn't read `SKILL.md`; it needs an agent built in **Microsoft Copilot
Studio**, with instructions plus a tool that calls the live TechSoup feed —
architecturally closer to the ChatGPT Custom GPT above than to the
`SKILL.md` surfaces. Unlike the ChatGPT version, this isn't self-serve per
employee: it requires a Copilot Studio maker license to build and a
Microsoft 365 admin's sign-off to publish org-wide.

Full click-by-click steps: [`m365-copilot/README.md`](m365-copilot/README.md)

Source: [`m365-copilot/instructions.md`](m365-copilot/instructions.md) and
[`m365-copilot/api-spec.yaml`](m365-copilot/api-spec.yaml)

---

## Repo layout

```
SKILL.md                                                            # single source of truth for the skill's logic — every
                                                                     # surface except ChatGPT points straight at this file
references/takeaway-template.md                                     # loaded on demand (progressive disclosure) — only read when
                                                                     # actually building a takeaway document, see SKILL.md §5

scripts/sync-skills.sh                                              # regenerates the Claude Code plugin copy from SKILL.md + references/

.claude-plugin/marketplace.json                                     # Claude Code marketplace manifest
plugins/ask-techsoup/.claude-plugin/plugin.json                     # Claude Code plugin manifest
plugins/ask-techsoup/skills/ask-techsoup/SKILL.md                   # generated — required by the Claude Code plugin system,
                                                                     # which needs the file at this exact path
plugins/ask-techsoup/skills/ask-techsoup/references/                # generated — mirrored verbatim from references/

chatgpt/instructions.md                            # hand-maintained — ChatGPT Custom GPT (no shell, calls an Action instead)
chatgpt/action-schema.yaml                          # the Action's OpenAPI schema
chatgpt/README.md                                  # click-by-click GPT setup

m365-copilot/instructions.md                       # hand-maintained — Microsoft 365 Copilot (untested), calls a Tool instead
m365-copilot/api-spec.yaml                          # the Tool's OpenAPI v2 (Swagger) schema
m365-copilot/README.md                             # click-by-click Copilot Studio setup
```

**To change what the skill does or how it answers:** edit `SKILL.md` and/or
`references/takeaway-template.md`, then run `./scripts/sync-skills.sh` and
commit the regenerated `plugins/ask-techsoup/skills/ask-techsoup/` contents —
don't hand-edit anything under that path, it'll be overwritten next sync.
Every other tool's instructions in this README link straight to the root
`SKILL.md` and `references/`, so there's nothing else to regenerate.
`chatgpt/instructions.md` and `m365-copilot/instructions.md` can't be
auto-generated (neither ChatGPT nor Microsoft 365 Copilot has filesystem/bash
access, so their "fetch the data" step calls an Action/Tool instead of
running `curl`, and neither produces standalone takeaway pages) — update
both by hand to match whenever `SKILL.md`'s schema or answering logic
changes.

## Updating

- **Claude Code** users: run `/plugin install ask-techsoup@ask-techsoup`
  after a push (`/plugin marketplace update` alone won't update an
  already-installed plugin). If you used the no-git fallback method instead,
  re-download both `SKILL.md` and `references/takeaway-template.md` and ask
  Claude to replace them at `~/.claude/skills/ask-techsoup/SKILL.md` and
  `~/.claude/skills/ask-techsoup/references/takeaway-template.md`.
- **Claude Desktop / claude.ai** users: rebuild the zip with fresh copies of
  both files, then remove the old version of the skill before adding the new
  one.
- **Gemini CLI, Antigravity, Codex CLI, GitHub Copilot** users: re-download
  both `SKILL.md` and `references/takeaway-template.md` and replace your
  local copies (there's no auto-update for these surfaces).
- **ChatGPT** users: re-copy `chatgpt/instructions.md` into the GPT's
  Instructions box and save.
- **Microsoft 365 Copilot** users: whoever maintains the agent in Copilot
  Studio re-copies `m365-copilot/instructions.md` into its instructions box
  and republishes.
