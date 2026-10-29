---
task_id: "15"
title: "Refresh .jarvis/CONTEXT.md"
depends_on: ["12", "13"]
parallel_group: wave-6
target_files:
  - .jarvis/CONTEXT.md
plugins:
  - understand-anything
  - graphify
compression: ponytail-full
estimated_complexity: low
status: completed
---

# Task 15 — Refresh `.jarvis/CONTEXT.md`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Execute `/jarvis-refresh` (or `/jarvis-understand`) upon implementation completion to update `.jarvis/CONTEXT.md` with the full v0.2.0 codebase structure, registering all new design skills, design sub-agents (`jarvis-design-...`), scripts, and adapters.

---

## Context

`.jarvis/CONTEXT.md` provides the distilled architecture and module graph for the active project. Whenever significant architectural changes land, CONTEXT.md must be refreshed to reflect the new state and maintain accurate cross-tool cache indexing.

---

## Acceptance Criteria

1. `.jarvis/CONTEXT.md` updated with v0.2.0 directory structure.
2. File & Module Graph registers:
   - `skills/jarvis-design/`
   - `agents/jarvis-design-interrogator.md`
   - `agents/jarvis-design-architect.md`
   - `agents/jarvis-design-taste-director.md`
   - `agents/jarvis-design-motion-engineer.md`
   - `agents/jarvis-design-executor.md`
   - `agents/jarvis-designer.md`
   - `scripts/setup.sh`
   - New adapters under `adapters/`
3. Dependency graph captures all design plugin interactions.
4. Confirms `apex-update` is omitted from the module graph.
5. Removes all obsolete references to `skills/jarvis-setup/`.
6. `analysis_hash` updated to the latest git state.
7. All `[[WikiLinks]]` remain valid.

---

## Implementation Notes

- Invoked as the final post-implementation step.
