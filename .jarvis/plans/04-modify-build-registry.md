---
task_id: "04"
title: "Modify scripts/build-registry.sh for Dual-Pillar Scanning"
depends_on: ["03"]
parallel_group: wave-2
target_files:
  - scripts/build-registry.sh
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 04 — Modify `scripts/build-registry.sh` for Dual-Pillar Scanning

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Enhance `scripts/build-registry.sh` to accept an optional second argument `[design-root]`, discover skills and agents across both `develop/` and `design/` directories, and output a valid v2 `config/registry.json`.

---

## Context

The four design repositories have varying internal structures for locating SKILL.md:
- `impeccable`: `.gemini/skills/impeccable/SKILL.md`
- `skills` (emilkowalski): `skills/*/SKILL.md` (15 individual skills)
- `taste-skill`: `skills/taste-skill/SKILL.md`
- `ui-ux-pro-max-skill`: `.claude/skills/*/SKILL.md` (7 individual skills)

`build-registry.sh` must scan these non-uniform structures and construct the `design_plugins` section in `config/registry.json`.

---

## Acceptance Criteria

1. Accepts syntax: `./scripts/build-registry.sh <develop-root> [design-root]`.
2. Sets `version: 2` in generated `config/registry.json` when design root is supplied.
3. Automatically identifies all skills in:
   - `impeccable`: discovers `impeccable` skill.
   - `skills` (emilkowalski): discovers all 15 skills (`animate`, `animation-performance`, etc.).
   - `taste-skill`: discovers `taste-skill`.
   - `ui-ux-pro-max-skill`: discovers all 7 skills (`ui-ux-pro-max`, `design`, `design-system`, etc.).
4. Records accurate relative paths from design root.
5. Populates `design_plugins` JSON object according to `config/registry.schema.json`.
6. Backward compatible: single argument run generates valid develop-only registry.

---

## Implementation Notes

- Use modular bash functions for scanning develop plugins vs design plugins.
- Use `jq` or python inline JSON serializer to construct valid JSON without escaping bugs.
