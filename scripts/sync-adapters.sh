#!/usr/bin/env bash
# sync-adapters.sh — Generate IDE adapter files from skills, design sub-agents, and registry
# Usage: ./sync-adapters.sh [skills-dir] [adapters-dir]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="${1:-$PLUGIN_ROOT/skills}"
ADAPTERS_DIR="${2:-$PLUGIN_ROOT/adapters}"
AGENTS_DIR="$PLUGIN_ROOT/agents"
REGISTRY_FILE="$PLUGIN_ROOT/config/registry.json"

echo "[sync-adapters] Syncing adapters to: $ADAPTERS_DIR" >&2

# Ensure output dirs exist
mkdir -p "$ADAPTERS_DIR/cursor"
mkdir -p "$ADAPTERS_DIR/claude-code"
mkdir -p "$ADAPTERS_DIR/codex"

# 1. Purge obsolete setup adapters & any apex references
rm -f "$ADAPTERS_DIR/cursor/jarvis-setup.mdc"
rm -f "$ADAPTERS_DIR/claude-code/jarvis-setup.md"
rm -f "$ADAPTERS_DIR/codex/jarvis-setup.toml"
rm -f "$ADAPTERS_DIR"/*/apex*

generated=0

# Helper: extract frontmatter field from markdown
extract_field() {
  local file="$1" field="$2"
  python3 - <<PYEOF
import re, sys
try:
    content = open('$file').read()
    fm_match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not fm_match:
        print('')
        sys.exit(0)
    fm = fm_match.group(1)
    # Search for field
    m = re.search(r'^$field:\s*["|>|-]?(.*?)["|]?\s*$', fm, re.MULTILINE)
    print(m.group(1).strip() if m else '')
except Exception:
    print('')
PYEOF
}

# ── 2. Process Core Skills (skills/*/SKILL.md) ────────────────────────
while IFS= read -r -d '' skill_dir; do
  skill_md="$skill_dir/SKILL.md"
  [[ -f "$skill_md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  description="$(extract_field "$skill_md" "description")"
  [[ -z "$description" ]] && description="Jarvis-Matrix skill: $skill_name"
  canonical_path="skills/$skill_name/SKILL.md"

  # Cursor .mdc
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

  # Claude Code .md
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

  # Codex .toml
  cat > "$ADAPTERS_DIR/codex/$skill_name.toml" <<TOML
[command]
name = "$skill_name"
description = "$description"
canonical_skill = "$canonical_path"

[invocation]
method = "skill-delegation"
TOML

  echo "[sync-adapters] ✓ skill: $skill_name" >&2
  ((generated++))

done < <(find "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

# ── 3. Process Design Sub-Agents (agents/jarvis-design-*.md + jarvis-designer.md) ──
if [[ -d "$AGENTS_DIR" ]]; then
  while IFS= read -r -d '' agent_file; do
    agent_base="$(basename "$agent_file" .md)"
    # Process only design sub-agents containing 'design'
    if [[ "$agent_base" == jarvis-design* ]]; then
      description="$(extract_field "$agent_file" "description")"
      [[ -z "$description" ]] && description="Jarvis-Matrix design sub-agent: $agent_base"
      rel_agent_path="agents/$agent_base.md"

      # Cursor .mdc
      cat > "$ADAPTERS_DIR/cursor/$agent_base.mdc" <<MDC
---
description: $description
globs: []
alwaysApply: false
---

# $agent_base

Direct sub-agent adapter for Jarvis design engineering.

**Canonical agent definition:** \`$rel_agent_path\`

To invoke directly, use: \`/$agent_base\` in your chat.

Follow instructions in:
\`~/.gemini/config/plugins/jarvis-matrix/$rel_agent_path\`
MDC

      # Claude Code .md
      cat > "$ADAPTERS_DIR/claude-code/$agent_base.md" <<CLAUDE
# $agent_base

$description

## Usage

\`\`\`
/$agent_base \$ARGUMENTS
\`\`\`

## Instructions

Directly dispatch sub-agent instructions from:
\`~/.gemini/config/plugins/jarvis-matrix/$rel_agent_path\`
CLAUDE

      # Codex .toml
      cat > "$ADAPTERS_DIR/codex/$agent_base.toml" <<TOML
[command]
name = "$agent_base"
description = "$description"
canonical_agent = "$rel_agent_path"

[invocation]
method = "agent-dispatch"
TOML

      echo "[sync-adapters] ✓ sub-agent: $agent_base" >&2
      ((generated++))
    fi
  done < <(find "$AGENTS_DIR" -mindepth 1 -maxdepth 1 -name "*.md" -print0 | sort -z)
fi

echo "[sync-adapters] Total adapter entries generated: $generated" >&2
exit 0
