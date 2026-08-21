#!/usr/bin/env bash
# Regenerates the Claude Code plugin's SKILL.md from the repo-root SKILL.md,
# the single source of truth. Run this after editing SKILL.md; commit the
# result. Every other surface (Claude Desktop, Gemini CLI, Antigravity, Codex
# CLI, Copilot) points users at the root SKILL.md directly — no copy needed.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$repo_root/SKILL.md"

targets=(
  "$repo_root/plugins/ask-techsoup/skills/ask-techsoup/SKILL.md"
)

marker='<!-- GENERATED FILE — do not edit directly. Source: SKILL.md. Regenerate with scripts/sync-skills.sh -->'

for target in "${targets[@]}"; do
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
done
