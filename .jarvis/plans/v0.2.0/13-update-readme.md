---
task_id: "13"
title: "Update README.md"
depends_on: ["08", "09", "10", "11", "14"]
parallel_group: wave-5
target_files:
  - README.md
plugins:
  - humanizer
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 13 — Update `README.md`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `README.md` to comprehensively document the v0.2.0 two-pillar orchestrator architecture, the new `/jarvis-design` skill, the mirrored design sub-agent fleet (`jarvis-design-...`), the strict design naming convention, and the `scripts/setup.sh` automated bootstrap flow.

---

## Context

`README.md` is the primary entry point for developers and AI agents discovering `Jarvis-Matrix`. It must accurately reflect all v0.2.0 capabilities, setup instructions, routing tables, and design quality standards.

---

## Acceptance Criteria

1. Version badge and header reflect version `0.2.0`.
2. Architecture section visualizes the two-pillar structure (`develop/` + `design/`).
3. Documents all 10 repositories across both pillars.
4. Quickstart instructions guide users to run `bash scripts/setup.sh` (removes `/jarvis-setup`).
5. Command reference table includes `/jarvis-design` with worked examples for both Autonomous Mode and Direct Sub-Skill Invocation.
6. Documents the mirrored design sub-agent fleet (`jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-design-taste-director`, `jarvis-design-motion-engineer`, `jarvis-design-executor`, `jarvis-designer`).
7. Explicitly explains the strict "design" keyword naming requirement to avoid confusion with develop skills.
8. Highlights the Mandatory 4-Repo Ensemble Rule, Zero-Bloat Context Isolation, and Obsidian Memory Binding.
9. Retains all existing develop command documentation without regressions.

---

## Implementation Notes

- Ensure all formatting, ASCII directory trees, and Markdown links are valid and clean.
