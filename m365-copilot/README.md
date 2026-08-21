# Ask TechSoup — Microsoft 365 Copilot setup

This is for **Word / Excel / SharePoint / OneDrive Copilot** — a different
product from GitHub Copilot, and from the coding-agent skills the rest of
this repo targets. Microsoft 365 Copilot doesn't read `SKILL.md` or a skills
folder; it needs an **agent built in Microsoft Copilot Studio**, with
instructions plus a tool that calls the live TechSoup feed.

This is not a self-serve, per-employee setup like the ChatGPT Custom GPT.
Building it requires a **Copilot Studio maker license** (or the appropriate
role in your tenant), and making it available to everyone requires your
**Microsoft 365 admin's** sign-off. A regular employee doesn't do any of the
steps below — they just pick "Ask TechSoup" from the agent list in Word,
Excel, SharePoint, or Copilot chat once it's published.

## Prerequisites

- Access to [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com)
  with permission to create agents in an environment.
- A Microsoft 365 Copilot license (for you and for anyone who'll use the
  agent).
- To publish org-wide: a tenant admin who can approve the agent in the
  Microsoft 365 admin center's Integrated Apps / agent catalog. Ask them
  before you build this if you're not sure whether agent publishing is
  allowed in your tenant — some tenants block side-loading or publishing
  entirely.

## Steps

1. Go to [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) →
   **Agents** in the left nav → **Microsoft 365 Copilot** → **Add**.
2. Fill in the configuration form:
   - **Name:** `Ask TechSoup`
   - **Description:** `Technology discounts and donations available to nonprofits worldwide, vetted and maintained by TechSoup.`
   - **Instructions:** open [`instructions.md`](instructions.md) in this
     folder, copy the whole thing, and paste it into the instructions box.
3. Select **Create**. The agent's overview page appears.
4. On the **Tools** card, select **Add tool** → **New tool** → **REST API**.
5. Upload [`api-spec.yaml`](api-spec.yaml) from this folder (drag-and-drop or
   browse). This is an OpenAPI **v2** spec — Copilot Studio's REST API tool
   currently requires v2 (it auto-converts v3, but v2 avoids relying on that
   conversion).
6. On **API plugin details**, improve the auto-filled description if you
   want — this is what the agent's orchestrator uses to decide when to call
   the tool. Something like: *"Fetches the live TechSoup catalog of
   technology discounts and donations for nonprofits — use for any question
   about specific offers, vendors, pricing, or eligibility."* Pick a
   **Solution** or leave it blank, then **Next**.
7. On **Authentication**, select **None** — this is a public, read-only
   feed, no key required. **Next**.
8. On **Select tools from the API**, select `getTechSoupProductCatalog`,
   confirm its name/description, and step through to **Review your tool** →
   **Next** → **Create connection** → **Add and configure**.
9. Test it: in the agent's test pane, start a **new test session** and ask
   something like "what security discounts are available for nonprofits?"
   or "is Bitwarden available in Kenya?" (Copilot caches answers within a
   session even across tool calls — always start a new session when
   re-testing after a change.)
10. When it's working, select **Publish** (top right) and fill in the
    catalog entry fields.
11. On **Availability options**, choose how far this should go:
    - **Share Link** — just you, for a quick test.
    - **Show to my teammates and shared users** — a specific group.
    - **Show to everyone in my org** — submits it to your tenant admin to
      add to the organization's agent catalog. This is what makes it appear
      for regular employees in Word/Excel/SharePoint/Copilot chat without
      them doing anything.

## Updating later

If `SKILL.md` in the repo root changes, re-copy the updated
[`instructions.md`](instructions.md) into the agent's instructions box in
Copilot Studio and republish. `api-spec.yaml` only needs updating if the
data feed's URL or shape changes — re-upload it as the tool's specification
and republish.

## What's different from the ChatGPT version

The [`chatgpt/`](../chatgpt/) instructions include a section offering to
turn a conversation into a shareable/printable takeaway page. That's left
out here deliberately — it depends on the environment being able to
generate and hand over a standalone document, and that isn't a verified
capability of a Copilot Studio tool-based agent. Add it back only once
that's actually been confirmed to work in this setup.
