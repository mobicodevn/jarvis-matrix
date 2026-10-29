---
name: jarvis-update
description: |
  Pulls latest changes across all 13 cloned plugin repositories across develop, design, and copywriting
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

Run periodically to keep all 13 external plugins current across all three pillars (`develop/`, `design/`, and `copywriting/`). Also run after manually adding a new plugin repo.

*Note: `apex-update` is completely redundant and omitted from Jarvis-Matrix; this unified `/jarvis-update` skill handles updating all repositories across all pillars.*

## Process

### Step 1 — Load Configuration

Read `config/jarvis.config.json`. Extract:
- `plugins_root`: path to `github-plugins/develop/`
- `design_plugins_root`: path to `github-plugins/design/`
- `copywriting_plugins_root`: path to `github-plugins/copywriting/`
- `detected_ides`: list of IDEs to regenerate adapters for

If `jarvis.config.json` is missing:
> "Configuration not found. Run `bash scripts/setup.sh` first."
> Stop here.

### Step 2 — Pull All Repos Across All Three Pillars

1. **Develop Repositories (5):**
   - `Understand-Anything`
   - `graphify`
   - `ponytail`
   - `caveman`
   - `agent-skills`

2. **Design Repositories (6):**
   - `impeccable`
   - `skills` (emilkowalski)
   - `taste-skill`
   - `ui-ux-pro-max-skill`
   - `hyperframes`
   - `logo-design-skill`

3. **Copywriting Repositories (2):**
   - `humanizer`
   - `vietnamese-humanizer`

For each repository:
```bash
cd <root>/<repo_path> && git pull --ff-only 2>&1
```

- **Fast-forward succeeded:** log `✓ <plugin> → <new-commit[:8]>`
- **Already up to date:** log `· <plugin> (no changes)`
- **Diverged / conflict / non-git:** log `⚠ <plugin> — pull skipped` and continue

### Step 3 — Rebuild Unified Registry

Run `scripts/build-registry.sh "$plugins_root" "$design_plugins_root" "$copywriting_plugins_root"` to produce fresh `config/registry.json` (schema v3).

### Step 4 — Detect Changes

Compare old `config/registry.json` against the new one:
- New skills added: `+ <skill-name>`
- Skills removed: `- <skill-name>`
- Version changes: `~ <plugin> <old-version> → <new-version>`

### Step 5 — Update JARVIS_MEMORY.md

Update the **Plugin Version Log** section in `JARVIS_MEMORY.md` to reflect all 13 repositories. Update `last_modified` in frontmatter. Preserve all existing `[[WikiLinks]]`.

### Step 6 — Regenerate Adapters (if needed)

If any skill signatures changed:
- Run `scripts/sync-adapters.sh`
- Log: `↺ Adapters regenerated for: cursor, claude-code, codex`

### Step 7 — Summary Report

```
✓ Jarvis update complete

  develop/ (5 repos):
  · understand-anything  (no changes)
  · graphify            (no changes)
  · ponytail            (no changes)
  · caveman             (no changes)
  · agent-skills        (no changes)

  design/ (6 repos):
  · impeccable          (no changes)
  · skills              (no changes)
  · taste-skill         (no changes)
  · ui-ux-pro-max-skill (no changes)
  · hyperframes         (no changes)
  · logo-design-skill   (no changes)

  copywriting/ (2 repos):
  · humanizer           (no changes)
  · vietnamese-humanizer(no changes)

  Registry rebuilt: 5 develop, 6 design, 2 copywriting plugins indexed
  JARVIS_MEMORY.md: Plugin Version Log updated (13 plugins)
  Adapters: regenerated
```
