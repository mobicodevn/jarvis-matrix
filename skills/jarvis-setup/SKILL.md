---
name: jarvis-setup
description: |
  Interactive setup wizard for Jarvis-Matrix. Validates the local plugin library,
  builds the skill registry index, initializes the global JARVIS_MEMORY.md brain,
  and generates IDE adapter bindings for Antigravity, Cursor, Claude Code, and Codex.
---

# /jarvis-setup — Jarvis-Matrix Setup Wizard

> **Memory Sync:** This skill writes to `JARVIS_MEMORY.md` during initialization.

## Overview

First-run setup for the Jarvis-Matrix orchestrator. Connects Jarvis to your local cloned plugin library, validates available tools, and prepares the routing infrastructure.

## When to Use

Run this once after installing the jarvis-matrix plugin, or whenever you add/remove plugins from your local library.

## Process

### Step 1 — Locate Plugin Library

Ask the user for their `github-plugins/` directory path.

**Default:** `~/.gemini/config/github-plugins/develop`

If the user provides a path, validate it exists. If not, ask again.

### Step 2 — Validate Required Plugins

Check for the presence of these 6 repositories by looking for their key files:

| Plugin | Validation Check |
|--------|-----------------|
| Understand-Anything | `understand-anything-plugin/skills/understand/SKILL.md` exists |
| graphify | `graphify/detect.py` exists |
| humanizer | `SKILL.md` exists at root |
| ponytail | `skills/ponytail/SKILL.md` exists |
| caveman | `skills/caveman/SKILL.md` exists |
| agent-skills | `skills/` directory contains >= 20 subdirectories |

For each **missing** plugin: print a warning but continue. Jarvis operates with whatever plugins are available.

For each **found** plugin: read its `plugin.json` (if present) for version info, and scan its `skills/` and `agents/` directories for available capabilities.

### Step 3 — Build Skill Registry

Run `scripts/build-registry.sh <plugins-path>` to produce `config/registry.json`.

The registry indexes every discovered skill, agent, entry point, and output format. This is the lookup table the router uses for lazy-loading.

### Step 4 — Initialize Global Brain

If `JARVIS_MEMORY.md` does not exist at the plugin root:
1. Copy `templates/JARVIS_MEMORY.template.md` to `JARVIS_MEMORY.md`
2. Fill in `created` and `last_modified` timestamps
3. Set default user preferences:
   - `default_compression: ponytail-full + caveman`
   - `default_planning_depth: atomic`
4. Populate the Plugin Version Log with discovered plugin versions

If `JARVIS_MEMORY.md` already exists: update the Plugin Version Log only.

### Step 5 — Detect IDEs & Generate Adapters

Check for installed IDEs:
- **Antigravity:** Always available (native — skills/ and rules/ are used directly)
- **Cursor:** Check if `.cursor/` exists in any workspace root
- **Claude Code:** Check if `~/.claude/` exists
- **Codex CLI:** Check if `codex` command is available on PATH

For each detected IDE, run `scripts/sync-adapters.sh` to generate adapter files in `adapters/`.

### Step 6 — Write Configuration

Write `config/jarvis.config.json`:

```json
{
  "plugins_root": "<user-provided-path>",
  "detected_ides": ["antigravity", "cursor", "claude-code"],
  "setup_completed": true,
  "setup_date": "<iso-datetime>"
}
```

### Step 7 — Report Summary

Display a summary to the user:

```
✓ Jarvis-Matrix Setup Complete
  
  Plugins found: 6/6
  • Understand-Anything  v0.x.x  ✓
  • graphify             v0.x.x  ✓
  • humanizer            v3.1.0  ✓
  • ponytail             v0.x.x  ✓
  • caveman              v0.x.x  ✓
  • agent-skills         v0.6.13 ✓
  
  Registry: config/registry.json (X skills, Y agents indexed)
  Global Brain: JARVIS_MEMORY.md initialized
  IDE Adapters: antigravity (native), cursor, claude-code
  
  Next steps:
  • /jarvis-understand — Analyze your project
  • /jarvis-memory — View or edit global rules
```

## Common Rationalizations to Resist

- "I'll set up later" — Setup takes < 30 seconds and unlocks all other commands.
- "I only need one plugin" — The registry indexes what's available; missing plugins are skipped gracefully.

## Verification

- `config/registry.json` exists and contains valid JSON with all found plugins
- `JARVIS_MEMORY.md` exists at plugin root with correct frontmatter
- `config/jarvis.config.json` exists with `setup_completed: true`
