---
task_id: "09"
title: "Update rules/jarvis-routing.md"
depends_on: ["01", "07"]
parallel_group: wave-4
target_files:
  - rules/jarvis-routing.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 09 — Update `rules/jarvis-routing.md`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `rules/jarvis-routing.md` with the complete design plugin routing reference, sub-agent handoff tree for `jarvis-design-...`, memory read/write matrix, and error handling updates.

---

## Context

`rules/jarvis-routing.md` provides detailed routing mechanics, decision trees, and memory boundaries for the orchestrator. It must be updated to cover the two-pillar architecture and design sub-agent dispatch paths with strict distinction between develop and design agents.

---

## Acceptance Criteria

1. **Plugin Routing Reference:**
   - Adds entries for all 4 design repos (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`) detailing their domains, key skill paths, and capabilities.
   - Confirms `apex-update` is excluded from registration.
2. **Sub-Agent Routing Tree:**
   - Visualizes the 6-phase pipeline with `jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-design-taste-director`, `jarvis-design-motion-engineer`, `jarvis-design-executor`.
3. **Strict "design" Keyword Separation:**
   - Highlights the distinction between design agents (`jarvis-design-...`) and develop agents (`jarvis-planner`, `jarvis-builder`, `jarvis-analyzer`).
4. **Memory Read/Write Matrix:**
   - Adds `/jarvis-design` and each design sub-agent to the matrix:
     - `jarvis-design-interrogator`: R: JARVIS_MEMORY | RW: PROJECT_MEMORY (spec)
     - `jarvis-design-architect`: R: JARVIS_MEMORY, CONTEXT | RW: PROJECT_MEMORY (layout)
     - `jarvis-design-taste-director`: R: JARVIS_MEMORY | RW: PROJECT_MEMORY (tokens)
     - `jarvis-design-motion-engineer`: R: JARVIS_MEMORY | RW: PROJECT_MEMORY (motion)
     - `jarvis-design-executor`: R: JARVIS_MEMORY, CONTEXT | RW: PROJECT_MEMORY (decisions)
   - Removes `/jarvis-setup` row; adds `scripts/setup.sh`.
5. **Error Handling Table:**
   - Updated per Section 7 of `PRP-v0.2.0.md` (recommending `bash scripts/setup.sh` on missing registry, zero-bloat enforcement, clarity gates).
6. All `[[WikiLinks]]` preserved intact.

---

## Implementation Notes

- Maintain consistent markdown table styling and preserve existing develop plugin documentation.
