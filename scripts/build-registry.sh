#!/usr/bin/env bash
# build-registry.sh — Scans a github-plugins/ directory and builds registry.json
# Usage: ./build-registry.sh <plugins-root-path> [output-path]
#
# Output: JSON written to <plugin-root>/config/registry.json (or output-path)
# Exit codes: 0=success, 1=no plugins found, 2=bad arguments

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- Args ---
PLUGINS_PATH="${1:-}"
OUTPUT_PATH="${2:-$PLUGIN_ROOT/config/registry.json}"

if [[ -z "$PLUGINS_PATH" ]]; then
  echo "[build-registry] ERROR: plugins root path required as first argument" >&2
  echo "  Usage: $0 <plugins-root-path>" >&2
  exit 2
fi

if [[ ! -d "$PLUGINS_PATH" ]]; then
  echo "[build-registry] ERROR: directory not found: $PLUGINS_PATH" >&2
  exit 2
fi

PLUGINS_PATH="$(cd "$PLUGINS_PATH" && pwd)"
NOW="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

echo "[build-registry] Scanning: $PLUGINS_PATH" >&2

# Helper: extract a string value from plugin.json
get_json_field() {
  local file="$1" field="$2"
  if [[ -f "$file" ]]; then
    python3 -c "import json,sys; d=json.load(open('$file')); print(d.get('$field',''))" 2>/dev/null || echo ""
  fi
}

# Helper: count subdirs
count_subdirs() {
  local dir="$1"
  [[ -d "$dir" ]] && find "$dir" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ' || echo "0"
}

# Helper: scan skills directory and output JSON array
scan_skills() {
  local skills_dir="$1" root_rel="$2"
  local result="[]"
  if [[ -d "$skills_dir" ]]; then
    result="["
    local first=true
    while IFS= read -r -d '' skill_dir; do
      local skill_name
      skill_name="$(basename "$skill_dir")"
      local skill_md="$skill_dir/SKILL.md"
      if [[ -f "$skill_md" ]]; then
        local rel_path="$root_rel/skills/$skill_name/SKILL.md"
        [[ "$first" == "true" ]] || result+=","
        result+="{\"name\":\"$skill_name\",\"path\":\"$rel_path\"}"
        first=false
      fi
    done < <(find "$skills_dir" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
    result+="]"
  fi
  echo "$result"
}

# Helper: scan agents directory and output JSON array
scan_agents() {
  local agents_dir="$1" root_rel="$2"
  local result="[]"
  if [[ -d "$agents_dir" ]]; then
    result="["
    local first=true
    while IFS= read -r -d '' agent_file; do
      local agent_name
      agent_name="$(basename "$agent_file")"
      local rel_path="$root_rel/agents/$agent_name"
      [[ "$first" == "true" ]] || result+=","
      result+="\"$rel_path\""
      first=false
    done < <(find "$agents_dir" -mindepth 1 -maxdepth 1 -name "*.md" -print0 | sort -z)
    result+="]"
  fi
  echo "$result"
}

plugins_json=""
found_count=0

# ── Understand-Anything ──────────────────────────────────────────────
UA_DIR="$PLUGINS_PATH/Understand-Anything"
UA_KEY="understand-anything"
UA_REL="Understand-Anything"
if [[ -d "$UA_DIR/understand-anything-plugin/skills" ]]; then
  version="$(get_json_field "$UA_DIR/understand-anything-plugin/plugin.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$UA_DIR/understand-anything-plugin/package.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$UA_DIR/.claude-plugin/plugin.json" "version")"
  skills="$(scan_skills "$UA_DIR/understand-anything-plugin/skills" "$UA_REL/understand-anything-plugin")"
  agents="$(scan_agents "$UA_DIR/understand-anything-plugin/agents" "$UA_REL/understand-anything-plugin")"
  plugins_json+="\"$UA_KEY\":{\"path\":\"$UA_REL\",\"type\":\"monorepo\",\"version\":\"$version\",\"skills\":$skills,\"agents\":$agents,\"output\":{\"dir\":\".ua/\",\"format\":\"knowledge-graph.json\"}},"
  echo "[build-registry] ✓ $UA_KEY" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $UA_KEY not found at $UA_DIR" >&2
fi

# ── graphify ────────────────────────────────────────────────────────
GR_DIR="$PLUGINS_PATH/graphify"
GR_KEY="graphify"
GR_REL="graphify"
if [[ -f "$GR_DIR/detect.py" || -f "$GR_DIR/graphify/detect.py" ]]; then
  version="$(get_json_field "$GR_DIR/pyproject.toml" "version" 2>/dev/null || echo "")"
  [[ -z "$version" ]] && version="$(grep -m1 'version' "$GR_DIR/pyproject.toml" 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "")"
  plugins_json+="\"$GR_KEY\":{\"path\":\"$GR_REL\",\"type\":\"python-library\",\"version\":\"$version\",\"entry_points\":[\"detect\",\"extract\",\"build\",\"cluster\",\"analyze\",\"report\",\"export\"],\"agents\":[],\"skills\":[],\"output\":{\"dir\":\"graphify-out/\",\"format\":\"graph.json\"}},"
  echo "[build-registry] ✓ $GR_KEY" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $GR_KEY not found at $GR_DIR" >&2
fi

# ── humanizer ───────────────────────────────────────────────────────
HU_DIR="$PLUGINS_PATH/humanizer"
HU_KEY="humanizer"
HU_REL="humanizer"
if [[ -f "$HU_DIR/SKILL.md" ]]; then
  version="$(get_json_field "$HU_DIR/plugin.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$HU_DIR/.claude-plugin/plugin.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$HU_DIR/package.json" "version")"
  plugins_json+="\"$HU_KEY\":{\"path\":\"$HU_REL\",\"type\":\"skill-only\",\"version\":\"$version\",\"skills\":[{\"name\":\"humanizer\",\"path\":\"$HU_REL/SKILL.md\"}],\"agents\":[],\"invocation\":\"embedded-mode\"},"
  echo "[build-registry] ✓ $HU_KEY" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $HU_KEY not found at $HU_DIR" >&2
fi

# ── ponytail ────────────────────────────────────────────────────────
PT_DIR="$PLUGINS_PATH/ponytail"
PT_KEY="ponytail"
PT_REL="ponytail"
if [[ -f "$PT_DIR/skills/ponytail/SKILL.md" ]]; then
  version="$(get_json_field "$PT_DIR/plugin.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$PT_DIR/package.json" "version")"
  skills="$(scan_skills "$PT_DIR/skills" "$PT_REL")"
  plugins_json+="\"$PT_KEY\":{\"path\":\"$PT_REL\",\"type\":\"plugin\",\"version\":\"$version\",\"levels\":[\"lite\",\"full\",\"ultra\"],\"skills\":$skills,\"agents\":[]},"
  echo "[build-registry] ✓ $PT_KEY" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $PT_KEY not found at $PT_DIR" >&2
fi

# ── caveman ─────────────────────────────────────────────────────────
CM_DIR="$PLUGINS_PATH/caveman"
CM_KEY="caveman"
CM_REL="caveman"
if [[ -f "$CM_DIR/skills/caveman/SKILL.md" ]]; then
  version="$(get_json_field "$CM_DIR/plugin.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$CM_DIR/package.json" "version")"
  [[ -z "$version" ]] && version="$(get_json_field "$CM_DIR/.claude-plugin/plugin.json" "version")"
  skills="$(scan_skills "$CM_DIR/skills" "$CM_REL")"
  agents="$(scan_agents "$CM_DIR/agents" "$CM_REL")"
  plugins_json+="\"$CM_KEY\":{\"path\":\"$CM_REL\",\"type\":\"plugin\",\"version\":\"$version\",\"modes\":[\"caveman\",\"ultracave\",\"megacave\"],\"skills\":$skills,\"agents\":$agents},"
  echo "[build-registry] ✓ $CM_KEY" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $CM_KEY not found at $CM_DIR" >&2
fi

# ── agent-skills ────────────────────────────────────────────────────
AS_DIR="$PLUGINS_PATH/agent-skills"
AS_KEY="agent-skills"
AS_REL="agent-skills"
AS_SKILLS_COUNT="$(count_subdirs "$AS_DIR/skills")"
if [[ -d "$AS_DIR/skills" && "$AS_SKILLS_COUNT" -ge 20 ]]; then
  version="$(get_json_field "$AS_DIR/plugin.json" "version")"
  skills="$(scan_skills "$AS_DIR/skills" "$AS_REL")"
  agents="$(scan_agents "$AS_DIR/agents" "$AS_REL")"
  plugins_json+="\"$AS_KEY\":{\"path\":\"$AS_REL\",\"type\":\"plugin\",\"version\":\"$version\",\"skills\":$skills,\"agents\":$agents},"
  echo "[build-registry] ✓ $AS_KEY ($AS_SKILLS_COUNT skills)" >&2
  ((found_count++))
else
  echo "[build-registry] ⚠ $AS_KEY not found or has < 20 skills at $AS_DIR (found: $AS_SKILLS_COUNT)" >&2
fi

# ── Assemble final JSON ──────────────────────────────────────────────
# Strip trailing comma if present
plugins_json="${plugins_json%,}"

OUTPUT="{\"version\":1,\"plugins_root\":\"$PLUGINS_PATH\",\"last_indexed\":\"$NOW\",\"plugins\":{$plugins_json}}"

# Validate and pretty-print via python3
if echo "$OUTPUT" | python3 -m json.tool > "$OUTPUT_PATH" 2>/dev/null; then
  echo "[build-registry] ✓ Registry written to $OUTPUT_PATH ($found_count plugins)" >&2
  exit 0
else
  echo "[build-registry] ERROR: Failed to produce valid JSON" >&2
  echo "$OUTPUT" >&2
  exit 1
fi
