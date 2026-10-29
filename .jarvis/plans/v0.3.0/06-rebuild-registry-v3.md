---
task_id: "06"
title: "Rebuild config/registry.json to Schema Version 3"
depends_on: ["04", "05"]
parallel_group: wave-2
target_files:
  - config/registry.json
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 06 — Rebuild `config/registry.json` to Schema Version 3

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Execute the updated `scripts/build-registry.sh` to generate the complete `config/registry.json` v3, indexing all 13 plugins across develop, design, and copywriting pillars.

---

## Context

With `scripts/build-registry.sh` upgraded, running the script with all three pillar paths compiles the canonical index used by all orchestrator slash skills to lazily load SKILL.md definitions.

---

## Acceptance Criteria

1. Execute `./scripts/build-registry.sh ~/.gemini/config/github-plugins/develop ~/.gemini/config/github-plugins/design ~/.gemini/config/github-plugins/copywriting config/registry.json`.
2. Exit code is 0.
3. `config/registry.json` has `"version": 3`.
4. `config/registry.json` includes:
   - `plugins`: 5 develop plugins (`understand-anything`, `graphify`, `ponytail`, `caveman`, `agent-skills`).
   - `design_plugins`: 6 design plugins (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`, `hyperframes`, `logo-design-skill`).
   - `copywriting_plugins`: 2 copywriting plugins (`humanizer`, `vietnamese-humanizer`).
5. Validated against `config/registry.schema.json`.

---

## Implementation Notes

- Verify JSON formatting and run validation against the schema.

