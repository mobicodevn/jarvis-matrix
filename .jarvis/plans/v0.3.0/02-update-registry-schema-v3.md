---
task_id: "02"
title: "Update config/registry.schema.json to Schema Version 3"
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

# Task 02 — Update `config/registry.schema.json` to Schema Version 3

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Extend `config/registry.schema.json` to version 3 to support the three-pillar architecture (`develop/`, `design/`, `copywriting/`), adding `copywriting_plugins_root` and `copywriting_plugins` definitions.

---

## Context

v2 schema supported `plugins` (develop) and `design_plugins`. v3 schema formalizes `copywriting_plugins` and its corresponding base root `copywriting_plugins_root` to allow seamless validation and indexing of language/humanizer plugins without namespace collisions.

---

## Acceptance Criteria

1. Update description of `version` in `config/registry.schema.json` to specify `(1 for develop-only, 2 for develop + design, 3 for develop + design + copywriting)`.
2. Add `copywriting_plugins_root` property:
   ```json
   "copywriting_plugins_root": {
     "type": "string",
     "description": "Absolute path to the copywriting github-plugins directory"
   }
   ```
3. Add `copywriting_plugins` property:
   ```json
   "copywriting_plugins": {
     "type": "object",
     "description": "Map of copywriting plugin-id to plugin metadata",
     "additionalProperties": {
       "$ref": "#/definitions/Plugin"
     }
   }
   ```
4. `required` array maintains backward compatibility while reflecting core requirements.
5. JSON syntax remains strictly valid according to Draft-07 schema.

---

## Implementation Notes

- Edit `config/registry.schema.json` using exact JSON formatting.
- Validate with `python3 -m json.tool config/registry.schema.json`.

