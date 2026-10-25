---
name: jarvis-update
description: |
  Pulls latest changes across all cloned plugin repositories across both develop and design
  pillars, re-syncs the unified registry, updates the JARVIS_MEMORY.md Plugin Version Log,
  and regenerates IDE adapters if skill signatures changed.
triggers: ["/jarvis-update"]
reads: [config/jarvis.config.json, config/registry.json]
writes: [config/registry.json, JARVIS_MEMORY.md]
plugins_invoked: []
compression: none
---

# /jarvis-update — Sync All Plugin Repositories

> **Memory Sync:** Reads `JARVIS_MEMORY.md` before executing (for user preferences).

## When to Use

Run periodically to keep all 10 external plugins current across both pillars (`develop/` and `design/`). Also run after manually adding a new plugin repo.

*Note: `apex-update` is completely redundant and omitted from Jarvis-Matrix; this unified `/jarvis-update` skill handles updating all repositories.*

## Process

### Step 1 — Load Configuration

Read `config/jarvis.config.json`. Extract:
- `plugins_root`: path to `github-plugins/develop/`
- `design_plugins_root`: path to `github-plugins/design/`
- `detected_ides`: list of IDEs to regenerate adapters for

If `jarvis.config.json` is missing:
> "Configuration not found. Run `bash scripts/setup.sh` first."
> Stop here.

### Step 2 — Pull All Repos Across Both Pillars

1. **Develop Repositories (6):**
   - `Understand-Anything`
   - `graphify`
   - `humanizer`
   - `ponytail`
   - `caveman`
   - `agent-skills`

2. **Design Repositories (4):**
   - `impeccable`
   - `skills` (emilkowalski)
   - `taste-skill`
   - `ui-ux-pro-max-skill`

For each repository:
```bash
cd <root>/<repo_path> && git pull --ff-only 2>&1
```

- **Fast-forward succeeded:** log `✓ <plugin> → <new-commit[:8]>`
- **Already up to date:** log `· <plugin> (no changes)`
- **Diverged / conflict:** log `⚠ <plugin> — could not fast-forward` and continue

### Step 3 — Rebuild Unified Registry

Run `scripts/build-registry.sh <plugins_root> <design_plugins_root>` to produce fresh `config/registry.json` (schema v2).

### Step 4 — Detect Changes

Compare old `config/registry.json` against the new one:
- New skills added: `+ <skill-name>`
- Skills removed: `- <skill-name>`
- Version changes: `~ <plugin> <old-version> → <new-version>`

### Step 5 — Update JARVIS_MEMORY.md

Update the **Plugin Version Log** section in `JARVIS_MEMORY.md` to reflect all 10 repositories. Update `last_modified` in frontmatter. Preserve all existing `[[WikiLinks]]`.

### Step 6 — Regenerate Adapters (if needed)

If any skill signatures changed:
- Run `scripts/sync-adapters.sh`
- Log: `↺ Adapters regenerated for: cursor, claude-code, codex`

### Step 7 — Summary Report

```
✓ Jarvis update complete

  develop/ (6 repos):
  · understand-anything  (no changes)
  ✓ graphify            v0.x.x → v0.y.y
  · humanizer           (no changes)
  · ponytail            (no changes)
  · caveman             (no changes)
  · agent-skills        (no changes)

  design/ (4 repos):
  ✓ impeccable          v1.x.x → v1.y.y
  · skills              (no changes)
  · taste-skill         (no changes)
  · ui-ux-pro-max-skill (no changes)

  Registry rebuilt: X develop skills, Y design skills, Z agents indexed
  JARVIS_MEMORY.md: Plugin Version Log updated (10 plugins)
  Adapters: regenerated
```
