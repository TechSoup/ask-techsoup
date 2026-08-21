# Ask TechSoup — ChatGPT Custom GPT setup

No coding involved — this is copy-and-paste into ChatGPT's web builder.
Requires a ChatGPT **Plus, Team, or Enterprise** account (free accounts can
use a GPT someone else already built and shared, but can't build one).

## Steps

1. Go to [chatgpt.com/gpts/editor](https://chatgpt.com/gpts/editor) (or in
   the ChatGPT sidebar: **Explore GPTs → + Create**).
2. Click the **Configure** tab (skip the conversational "Create" tab).
3. Fill in:
   - **Name:** `Ask TechSoup`
   - **Description:** `Technology discounts and donations available to nonprofits worldwide, vetted and maintained by TechSoup.`
   - **Instructions:** open [`instructions.md`](instructions.md) in this
     folder, copy the whole thing, and paste it into the Instructions box.
4. Scroll to **Actions** → click **Create new action**.
5. Open [`action-schema.yaml`](action-schema.yaml) in this folder, copy the
   whole thing, and paste it into the schema box (there's a "paste your own
   schema" text area — no import step needed).
6. Leave Authentication as **None** — this is a public, read-only feed, no
   API key required.
7. (Optional) Add a few **Conversation starters**, e.g.:
   - "What security discounts are available for nonprofits?"
   - "Is Bitwarden available to a nonprofit in Kenya?"
   - "Compare the password manager offers."
8. Click **Save/Update** (top right) → choose who can access it (e.g. "Only
   people with a link" to keep it within your organization for now).

## Updating later

If `SKILL.md` changes in the main repo, re-copy the updated
[`instructions.md`](instructions.md) into the GPT's Instructions box and
click Save again. The Action schema only needs updating if the data feed's
URL or shape changes.
