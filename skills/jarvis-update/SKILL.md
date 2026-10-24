---
name: jarvis-update
description: |
  Pulls latest changes across all cloned plugin repositories and re-syncs the registry.
  Updates JARVIS_MEMORY.md Plugin Version Log and regenerates IDE adapters if skill
  signatures changed.
triggers: ["/jarvis-update"]
reads: [config/jarvis.config.json, config/registry.json]
writes: [config/registry.json, JARVIS_MEMORY.md]
plugins_invoked: []
compression: none
---

# /jarvis-update — Sync Plugin Repositories

> **Memory Sync:** Reads JARVIS_MEMORY.md before executing (for user preferences).

## When to Use

Run periodically to keep all plugins current. Also run after manually cloning a new plugin repo into `github-plugins/develop/`.

## Process

### Step 1 — Load Configuration

Read `config/jarvis.config.json`. Extract:
- `plugins_root`: path to `github-plugins/develop/`
- `detected_ides`: list of IDEs to regenerate adapters for

If `jarvis.config.json` is missing:
> "Configuration not found. Run `/jarvis-setup` first."
> Stop here.

### Step 2 — Pull All Repos

For each plugin in `config/registry.json`:

```bash
cd <plugins_root>/<plugin_path> && git pull --ff-only 2>&1
```

- **Fast-forward succeeded:** log `✓ <plugin> → <new-commit[:8]>`
- **Already up to date:** log `· <plugin> (no changes)`
- **Diverged / conflict:** log `⚠ <plugin> — could not fast-forward (manual intervention needed)` and continue

### Step 3 — Rebuild Registry

Run `scripts/build-registry.sh <plugins_root>` to produce a fresh `config/registry.json`.

### Step 4 — Detect Changes

Compare old `config/registry.json` against the new one:
- New skills added: `+ <skill-name>`
- Skills removed: `- <skill-name>`
- Version changes: `~ <plugin> <old-version> → <new-version>`

### Step 5 — Update JARVIS_MEMORY.md

Update the **Plugin Version Log** section in `JARVIS_MEMORY.md`:

Format:
```markdown
| Plugin | Version | Last Synced |
|--------|---------|-------------|
| understand-anything | 0.x.x | 2026-10-24T13:00:00Z |
| graphify | 0.x.x | 2026-10-24T13:00:00Z |
...
```

Update `last_modified` in frontmatter. Preserve all other sections.

### Step 6 — Regenerate Adapters (if needed)

If any skill signatures changed (new name, description change, new/removed skill):
- Run `scripts/sync-adapters.sh` to regenerate all adapter files
- Log: `↺ Adapters regenerated for: cursor, claude-code, codex`

### Step 7 — Report

```
✓ Jarvis update complete

  Plugin updates:
  · understand-anything  (no changes)
  ✓ graphify            v0.x.x → v0.y.y (+2 new skills)
  ✓ ponytail            v0.x.x → v0.y.y
  · humanizer           (no changes)
  · caveman             (no changes)
  · agent-skills        (no changes)

  Registry rebuilt: X skills, Y agents indexed
  JARVIS_MEMORY.md: Plugin Version Log updated
  Adapters: regenerated (skill signatures changed)
```

## Verification

- `config/registry.json` has updated `last_indexed` timestamp
- `JARVIS_MEMORY.md` Plugin Version Log reflects current versions
- All repos are on latest HEAD (barring conflicts)
