---
task_id: "03"
title: "Update config/registry.schema.json"
depends_on: []
parallel_group: wave-1
target_files:
  - config/registry.schema.json
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 03 — Update `config/registry.schema.json`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Extend `config/registry.schema.json` to define the version 2 schema supporting the two-pillar design plugin architecture, including `design_plugins_root` and `design_plugins` object definitions.

---

## Context

v0.1.0 registry only had `plugins_root` and `plugins` (for develop plugins). To support the second pillar without colliding namespaces, schema v2 adds `design_plugins_root` (string) and `design_plugins` (object mapping plugin keys to metadata, skill paths, and agents).

---

## Acceptance Criteria

1. `version` property accepts value `2` (in addition to `1`).
2. Adds `design_plugins_root` property with description and string type.
3. Adds `design_plugins` property reusing the existing plugin object schema definitions (`type`, `path`, `skills`, `agents`, `version`).
4. Backward-compatible with v1 registries while strictly validating v2 registries.
5. JSON schema remains valid Draft-07 format.

---

## Implementation Notes

- Inspect existing `config/registry.schema.json`.
- Add `design_plugins_root` and `design_plugins` under `properties`.
- Ensure `required` array specifies `version`, `plugins_root`, and `plugins`, keeping `design_plugins_root` and `design_plugins` optional for backward-compatibility.
