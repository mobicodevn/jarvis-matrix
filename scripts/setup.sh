#!/usr/bin/env bash
# setup.sh — Automated bootstrap for Jarvis-Matrix
# Usage: ./scripts/setup.sh [plugins-base-dir]
#
# Clones/updates all 10 repositories across develop/ and design/ pillars,
# builds unified registry, initializes memory, and syncs IDE adapters.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

BASE_DIR="${1:-$HOME/.gemini/config/github-plugins}"
DEVELOP_DIR="$BASE_DIR/develop"
DESIGN_DIR="$BASE_DIR/design"

echo "=================================================="
echo "⚡ Jarvis-Matrix v0.2.0 Automated Setup"
echo "=================================================="
echo "Develop Pillar Target: $DEVELOP_DIR"
echo "Design Pillar Target:  $DESIGN_DIR"
echo ""

mkdir -p "$DEVELOP_DIR"
mkdir -p "$DESIGN_DIR"

# 1. DEVELOP REPOSITORIES (6 repos)
declare -A DEVELOP_REPOS=(
  ["Understand-Anything"]="https://github.com/Egonex-AI/Understand-Anything"
  ["graphify"]="https://github.com/Graphify-Labs/graphify"
  ["humanizer"]="https://github.com/blader/humanizer"
  ["ponytail"]="https://github.com/DietrichGebert/ponytail"
  ["caveman"]="https://github.com/JuliusBrussee/caveman"
  ["agent-skills"]="https://github.com/addyosmani/agent-skills"
)

# 2. DESIGN REPOSITORIES (4 repos)
declare -A DESIGN_REPOS=(
  ["impeccable"]="https://github.com/pbakaus/impeccable"
  ["skills"]="https://github.com/emilkowalski/skills"
  ["taste-skill"]="https://github.com/leonxlnx/taste-skill"
  ["ui-ux-pro-max-skill"]="https://github.com/nextlevelbuilder/ui-ux-pro-max-skill"
)

clone_or_update() {
  local target_dir="$1"
  local name="$2"
  local url="$3"
  local dest="$target_dir/$name"

  echo -n "  · Checking $name... "
  if [[ -d "$dest/.git" ]]; then
    echo -n "exists, pulling latest... "
    if (cd "$dest" && git pull --ff-only &>/dev/null); then
      echo "✓ updated"
    else
      echo "⚠ pull skipped (local modifications or offline)"
    fi
  elif [[ -d "$dest" ]]; then
    echo "✓ found (non-git)"
  else
    echo -n "cloning... "
    if git clone --depth 1 "$url" "$dest" &>/dev/null; then
      echo "✓ cloned"
    else
      echo "⚠ failed to clone (will continue without it)"
    fi
  fi
}

echo "── 1. Syncing Engineering Plugins (develop/) ──"
for name in "Understand-Anything" "graphify" "humanizer" "ponytail" "caveman" "agent-skills"; do
  clone_or_update "$DEVELOP_DIR" "$name" "${DEVELOP_REPOS[$name]}"
done

echo ""
echo "── 2. Syncing UI/UX & Animation Plugins (design/) ──"
for name in "impeccable" "skills" "taste-skill" "ui-ux-pro-max-skill"; do
  clone_or_update "$DESIGN_DIR" "$name" "${DESIGN_REPOS[$name]}"
done

echo ""
echo "── 3. Updating Config & Building Registry ──"

# Update jarvis.config.json
CONFIG_FILE="$PLUGIN_ROOT/config/jarvis.config.json"
mkdir -p "$PLUGIN_ROOT/config"

python3 - <<PYEOF
import json, os, datetime

config_path = "$CONFIG_FILE"
data = {
    "plugins_root": "$DEVELOP_DIR",
    "design_plugins_root": "$DESIGN_DIR",
    "detected_ides": ["antigravity", "cursor", "claude-code"],
    "setup_completed": True,
    "setup_date": datetime.datetime.now().isoformat(),
    "version": "0.2.0"
}

if os.path.exists(config_path):
    try:
        existing = json.load(open(config_path))
        existing.update(data)
        data = existing
    except Exception:
        pass

with open(config_path, "w") as f:
    json.dump(data, f, indent=2)
print("✓ Config written to config/jarvis.config.json")
PYEOF

# Run build-registry.sh
if [[ -x "$PLUGIN_ROOT/scripts/build-registry.sh" ]]; then
  echo "Executing build-registry.sh..."
  "$PLUGIN_ROOT/scripts/build-registry.sh" "$DEVELOP_DIR" "$DESIGN_DIR" || echo "⚠ Warning: Registry build encountered non-critical errors."
fi

echo ""
echo "── 4. Initializing Global Memory ──"
MEMORY_FILE="$PLUGIN_ROOT/JARVIS_MEMORY.md"
if [[ ! -f "$MEMORY_FILE" ]] && [[ -f "$PLUGIN_ROOT/templates/JARVIS_MEMORY.template.md" ]]; then
  cp "$PLUGIN_ROOT/templates/JARVIS_MEMORY.template.md" "$MEMORY_FILE"
  echo "✓ Initialized JARVIS_MEMORY.md from template"
else
  echo "✓ JARVIS_MEMORY.md exists"
fi

echo ""
echo "── 5. Generating IDE Adapters ──"
if [[ -x "$PLUGIN_ROOT/scripts/sync-adapters.sh" ]]; then
  "$PLUGIN_ROOT/scripts/sync-adapters.sh" "$PLUGIN_ROOT/skills" "$PLUGIN_ROOT/adapters" || echo "⚠ Warning: Adapter sync had warnings."
fi

echo ""
echo "=================================================="
echo "✓ Jarvis-Matrix v0.2.0 setup complete!"
echo "=================================================="
