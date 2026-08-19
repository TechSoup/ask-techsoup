#!/usr/bin/env bash
# Regenerates every per-surface SKILL.md from skill/SKILL.md, the single
# source of truth. Run this after editing skill/SKILL.md; commit the results.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$repo_root/skill/SKILL.md"

targets=(
  "$repo_root/plugins/ask-techsoup/skills/ask-techsoup/SKILL.md"
  "$repo_root/claude-ai/ask-techsoup/SKILL.md"
  "$repo_root/gemini-cli/ask-techsoup/SKILL.md"
  "$repo_root/antigravity/ask-techsoup/SKILL.md"
  "$repo_root/codex-cli/ask-techsoup/SKILL.md"
)

marker='<!-- GENERATED FILE — do not edit directly. Source: skill/SKILL.md. Regenerate with scripts/sync-skills.sh -->'

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
