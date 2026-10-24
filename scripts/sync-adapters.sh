#!/usr/bin/env bash
# sync-adapters.sh — Generate IDE-specific adapter files from canonical SKILL.md files
# Usage: ./sync-adapters.sh [skills-dir] [adapters-dir]
#
# Reads all skills/*/SKILL.md files, extracts name and description from YAML frontmatter,
# and generates:
#   - adapters/cursor/<name>.mdc
#   - adapters/claude-code/<name>.md
#   - adapters/codex/<name>.toml
# Antigravity uses SKILL.md natively — no generation needed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="${1:-$PLUGIN_ROOT/skills}"
ADAPTERS_DIR="${2:-$PLUGIN_ROOT/adapters}"

echo "[sync-adapters] Scanning skills in: $SKILLS_DIR" >&2

# Ensure output dirs exist
mkdir -p "$ADAPTERS_DIR/cursor"
mkdir -p "$ADAPTERS_DIR/claude-code"
mkdir -p "$ADAPTERS_DIR/codex"

generated=0

# Helper: extract frontmatter field from a SKILL.md
extract_field() {
  local file="$1" field="$2"
  python3 - <<PYEOF
import re, sys
content = open('$file').read()
# Match YAML frontmatter block
fm_match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
if not fm_match:
    print('')
    sys.exit(0)
fm = fm_match.group(1)
# Match field: value (handles multi-line | blocks by just grabbing first line of value)
m = re.search(r'^$field:\s*["|]?(.*?)["|]?\s*$', fm, re.MULTILINE)
print(m.group(1).strip() if m else '')
PYEOF
}

# Process each skill directory
while IFS= read -r -d '' skill_dir; do
  skill_md="$skill_dir/SKILL.md"
  [[ -f "$skill_md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  description="$(extract_field "$skill_md" "description")"
  canonical_path="skills/$skill_name/SKILL.md"

  # ── Cursor .mdc ───────────────────────────────────────────────
  cat > "$ADAPTERS_DIR/cursor/$skill_name.mdc" <<MDC
---
description: $description
globs: []
alwaysApply: false
---

# $skill_name

This rule delegates to the canonical Jarvis-Matrix skill definition.

**Canonical source:** \`$canonical_path\`

To invoke, use: \`/$skill_name\` in your chat.

Follow all instructions in the canonical SKILL.md located at:
\`~/.gemini/config/plugins/jarvis-matrix/$canonical_path\`
MDC

  # ── Claude Code command .md ───────────────────────────────────
  cat > "$ADAPTERS_DIR/claude-code/$skill_name.md" <<CLAUDE
# $skill_name

$description

## Usage

\`\`\`
/$skill_name \$ARGUMENTS
\`\`\`

## Instructions

Read and follow the complete skill instructions from:
\`~/.gemini/config/plugins/jarvis-matrix/$canonical_path\`

Apply all steps defined in the SKILL.md, substituting \`\$ARGUMENTS\` as the user's input.
CLAUDE

  # ── Codex CLI .toml ───────────────────────────────────────────
  cat > "$ADAPTERS_DIR/codex/$skill_name.toml" <<TOML
[command]
name = "$skill_name"
description = "$description"
canonical_skill = "$canonical_path"

[invocation]
# Invoke by reading the canonical SKILL.md instructions
# Path: ~/.gemini/config/plugins/jarvis-matrix/$canonical_path
method = "skill-delegation"
TOML

  echo "[sync-adapters] ✓ $skill_name" >&2
  ((generated++))

done < <(find "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

echo "[sync-adapters] Generated adapters for $generated skills" >&2
exit 0
