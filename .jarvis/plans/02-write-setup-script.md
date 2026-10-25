---
task_id: "02"
title: "Write scripts/setup.sh Bootstrap Script"
depends_on: []
parallel_group: wave-1
target_files:
  - scripts/setup.sh
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 02 — Write `scripts/setup.sh` Bootstrap Script

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Create an automated, non-interactive bootstrap script `scripts/setup.sh` that clones and updates all 10 repositories (6 develop + 4 design), initializes global memory, runs the dual-pillar registry builder, and synchronizes IDE adapters.

---

## Context

v0.2.0 establishes a two-pillar external plugin directory under `~/.gemini/config/github-plugins/`:
- `develop/` (6 repos: Understand-Anything, graphify, humanizer, ponytail, caveman, agent-skills)
- `design/` (4 repos: pbakaus/impeccable, emilkowalski/skills, leonxlnx/taste-skill, nextlevelbuilder/ui-ux-pro-max-skill)

`scripts/setup.sh` is the automated entry point for any clean environment.

---

## Acceptance Criteria

1. `scripts/setup.sh` is executable (`chmod +x`).
2. Creates `develop/` and `design/` directories under `~/.gemini/config/github-plugins/` if missing.
3. Iterates all 10 repositories:
   - If missing: `git clone <url> <target>`
   - If present: `git pull --ff-only`
4. Gracefully warns if any repo fails to clone (e.g., network timeout) and proceeds with the remaining repos without hard crashing.
5. Invokes `scripts/build-registry.sh` with develop and design roots.
6. Initializes `JARVIS_MEMORY.md` from `templates/JARVIS_MEMORY.template.md` if not present.
7. Populates `JARVIS_MEMORY.md` Plugin Version Log with all 10 plugins.
8. Writes `config/jarvis.config.json` containing `plugins_root`, `design_plugins_root`, and `version: "0.2.0"`.
9. Invokes `scripts/sync-adapters.sh` to generate adapter bindings.
10. Preserves all `[[WikiLinks]]`.

---

## Implementation Notes

- Use robust bash scripting (`set -euo pipefail` with fallback blocks for optional clones).
- Ensure support for macOS default zsh / bash 3+.
