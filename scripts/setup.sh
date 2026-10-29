#!/usr/bin/env bash
# setup.sh — Automated bootstrap for Jarvis-Matrix
# Usage: ./scripts/setup.sh [plugins-base-dir]
#
# Clones/updates all 13 repositories across develop/, design/, and copywriting/ pillars,
# builds unified registry, initializes memory, and syncs IDE adapters.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

BASE_DIR="${1:-$HOME/.gemini/config/github-plugins}"
DEVELOP_DIR="$BASE_DIR/develop"
DESIGN_DIR="$BASE_DIR/design"
COPYWRITING_DIR="$BASE_DIR/copywriting"

echo "=================================================="
echo "⚡ Jarvis-Matrix v0.3.0 Automated Setup"
echo "=================================================="
echo "Develop Pillar Target:     $DEVELOP_DIR"
echo "Design Pillar Target:      $DESIGN_DIR"
echo "Copywriting Pillar Target: $COPYWRITING_DIR"
echo ""

mkdir -p "$DEVELOP_DIR"
mkdir -p "$DESIGN_DIR"
mkdir -p "$COPYWRITING_DIR"

# 1. DEVELOP REPOSITORIES (5 repos)
declare -A DEVELOP_REPOS=(
  ["Understand-Anything"]="https://github.com/Egonex-AI/Understand-Anything"
  ["graphify"]="https://github.com/Graphify-Labs/graphify"
  ["ponytail"]="https://github.com/DietrichGebert/ponytail"
  ["caveman"]="https://github.com/JuliusBrussee/caveman"
  ["agent-skills"]="https://github.com/addyosmani/agent-skills"
)

# 2. DESIGN REPOSITORIES (6 repos)
declare -A DESIGN_REPOS=(
  ["impeccable"]="https://github.com/pbakaus/impeccable"
  ["skills"]="https://github.com/emilkowalski/skills"
  ["taste-skill"]="https://github.com/leonxlnx/taste-skill"
  ["ui-ux-pro-max-skill"]="https://github.com/nextlevelbuilder/ui-ux-pro-max-skill"
  ["hyperframes"]="https://github.com/heygen-com/hyperframes"
  ["logo-design-skill"]="https://github.com/kaankiziltug/logo-design-skill"
)

# 3. COPYWRITING REPOSITORIES (2 repos)
declare -A COPYWRITING_REPOS=(
  ["humanizer"]="https://github.com/blader/humanizer"
  ["vietnamese-humanizer"]="https://github.com/longhang2004/vietnamese-humanizer"
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
for name in "Understand-Anything" "graphify" "ponytail" "caveman" "agent-skills"; do
  clone_or_update "$DEVELOP_DIR" "$name" "${DEVELOP_REPOS[$name]}"
done

echo ""
echo "── 2. Syncing UI/UX & Animation Plugins (design/) ──"
for name in "impeccable" "skills" "taste-skill" "ui-ux-pro-max-skill" "hyperframes" "logo-design-skill"; do
  clone_or_update "$DESIGN_DIR" "$name" "${DESIGN_REPOS[$name]}"
done

echo ""
echo "── 3. Syncing Copywriting Plugins (copywriting/) ──"
for name in "humanizer" "vietnamese-humanizer"; do
  clone_or_update "$COPYWRITING_DIR" "$name" "${COPYWRITING_REPOS[$name]}"
done

echo ""
echo "── 4. Updating Config & Building Registry ──"

# Update jarvis.config.json
CONFIG_FILE="$PLUGIN_ROOT/config/jarvis.config.json"
mkdir -p "$PLUGIN_ROOT/config"

python3 - <<PYEOF
import json, os, datetime

config_path = "$CONFIG_FILE"
data = {
    "plugins_root": "$DEVELOP_DIR",
    "design_plugins_root": "$DESIGN_DIR",
    "copywriting_plugins_root": "$COPYWRITING_DIR",
    "detected_ides": ["antigravity", "cursor", "claude-code", "codex"],
    "setup_completed": True,
    "setup_date": datetime.datetime.now().isoformat(),
    "version": "0.3.0"
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
  "$PLUGIN_ROOT/scripts/build-registry.sh" "$DEVELOP_DIR" "$DESIGN_DIR" "$COPYWRITING_DIR" || echo "⚠ Warning: Registry build encountered non-critical errors."
fi

echo ""
echo "── 5. Initializing Global Memory ──"
MEMORY_FILE="$PLUGIN_ROOT/JARVIS_MEMORY.md"
if [[ ! -f "$MEMORY_FILE" ]] && [[ -f "$PLUGIN_ROOT/templates/JARVIS_MEMORY.template.md" ]]; then
  cp "$PLUGIN_ROOT/templates/JARVIS_MEMORY.template.md" "$MEMORY_FILE"
  echo "✓ Initialized JARVIS_MEMORY.md from template"
else
  echo "✓ JARVIS_MEMORY.md exists"
fi

echo ""
echo "── 6. Generating IDE Adapters ──"
if [[ -x "$PLUGIN_ROOT/scripts/sync-adapters.sh" ]]; then
  "$PLUGIN_ROOT/scripts/sync-adapters.sh" "$PLUGIN_ROOT/skills" "$PLUGIN_ROOT/adapters" || echo "⚠ Warning: Adapter sync had warnings."
fi

echo ""
echo "=================================================="
echo "✓ Jarvis-Matrix v0.3.0 setup complete!"
echo "=================================================="
