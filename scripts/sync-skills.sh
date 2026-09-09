#!/usr/bin/env bash
# Regenerates the Claude Code plugin's SKILL.md from the repo-root SKILL.md,
# the single source of truth, and mirrors the references/ directory alongside
# it (referenced files are read on demand, not inlined — keep them in sync
# verbatim, no marker needed since they aren't hand-edited at the target).
# Run this after editing SKILL.md or references/; commit the result. Every
# other surface (Claude Desktop, Gemini CLI, Antigravity, Codex CLI, Copilot)
# points users at the root SKILL.md and references/ directly — no copy needed.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$repo_root/SKILL.md"
plugin_skill_dir="$repo_root/plugins/ask-techsoup/skills/ask-techsoup"

marker='<!-- GENERATED FILE — do not edit directly. Source: SKILL.md. Regenerate with scripts/sync-skills.sh -->'

target="$plugin_skill_dir/SKILL.md"
mkdir -p "$(dirname "$target")"
{
  # frontmatter (everything up to and including the second '---' line)
  awk '/^---$/{c++} {print} c==2{exit}' "$source_file"
  echo
  echo "$marker"
  # body (everything after the second '---' line)
  awk '/^---$/{c++; next} c>=2{print}' "$source_file"
} > "$target"
echo "synced -> $target"

rsync -a --delete "$repo_root/references/" "$plugin_skill_dir/references/"
echo "synced -> $plugin_skill_dir/references/"
