---
task_id: "13"
title: "Upgrade and Execute /jarvis-update Across All Three Pillars"
depends_on: ["10", "11", "12"]
parallel_group: wave-5
target_files:
  - skills/jarvis-update/SKILL.md
  - JARVIS_MEMORY.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 13 — Upgrade and Execute `/jarvis-update` Across All Three Pillars

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Upgrade the `/jarvis-update` skill to iterate through all 13 external repositories across `develop/`, `design/`, and `copywriting/`, then execute the update process to pull latest commits and sync the `Plugin Version Log` in `JARVIS_MEMORY.md`.

---

## Context

`/jarvis-update` ensures that all external cloned plugins are up to date and that `JARVIS_MEMORY.md` records current versions. In v0.3.0, it must scan 3 pillars:
- `develop/` (5): `Understand-Anything`, `graphify`, `ponytail`, `caveman`, `agent-skills`
- `design/` (6): `impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`, `hyperframes`, `logo-design-skill`
- `copywriting/` (2): `humanizer`, `vietnamese-humanizer`

---

## Acceptance Criteria

1. `skills/jarvis-update/SKILL.md`:
   - Step 1: Reads `plugins_root`, `design_plugins_root`, and `copywriting_plugins_root` from `config/jarvis.config.json`.
   - Step 2: Iterates across all 13 repos in their respective directories.
   - Step 3: Rebuilds registry using `build-registry.sh` passing all 3 directories.
   - Step 5: Updates `Plugin Version Log` in `JARVIS_MEMORY.md` to reflect all 13 plugins across the 3 pillars.
2. Execute the update workflow:
   - Git pull executed across each cloned repo.
   - `build-registry.sh` re-run.
   - `JARVIS_MEMORY.md` updated with the 13 plugins and current dates.
   - Tag `v0.3.0` added to frontmatter in `JARVIS_MEMORY.md`.

---

## Implementation Notes

- Handle repositories that are non-git or have local clean checkouts without aborting.
- Preserve existing `[[WikiLinks]]` in `JARVIS_MEMORY.md`.

