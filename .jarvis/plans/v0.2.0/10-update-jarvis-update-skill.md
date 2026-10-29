---
task_id: "10"
title: "Update /jarvis-update SKILL.md"
depends_on: ["04", "05"]
parallel_group: wave-4
target_files:
  - skills/jarvis-update/SKILL.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 10 — Update `/jarvis-update` SKILL.md

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Expand `/jarvis-update` to iterate both `develop/` (6 repos) and `design/` (4 repos), rebuild the v2 registry, log all 10 plugin versions in `JARVIS_MEMORY.md`, and regenerate IDE adapters when skill signatures change. Confirms that `apex-update` is excluded from the ecosystem.

---

## Context

In v0.1.0, `/jarvis-update` only updated the 6 develop plugins. In v0.2.0, design plugins are first-class citizens and must be automatically kept in sync so the "No-Rewrite Rule" maintains fresh external design capabilities without manual intervention. Because `/jarvis-update` handles all repositories centrally, `apex-update` is completely redundant and excluded.

---

## Acceptance Criteria

1. Reads both `plugins_root` and `design_plugins_root` from `config/jarvis.config.json`.
2. Iterates across all 10 repositories across both pillars:
   - `develop/`: Understand-Anything, graphify, humanizer, ponytail, caveman, agent-skills
   - `design/`: impeccable, skills, taste-skill, ui-ux-pro-max-skill
3. Confirms `apex-update` is omitted from repo loops and adapters.
4. Rebuilds registry via `scripts/build-registry.sh <develop-root> <design-root>`.
5. Updates `JARVIS_MEMORY.md` Plugin Version Log table with rows for all 10 plugins.
6. Invokes `scripts/sync-adapters.sh` to update IDE adapter bindings.
7. Summary report clearly separates output into `develop/` (6 repos) and `design/` (4 repos).
8. Gracefully degrades if `design_plugins_root` is not yet configured.

---

## Implementation Notes

- Edit `skills/jarvis-update/SKILL.md` to document the dual-pillar update workflow and sample CLI output.
