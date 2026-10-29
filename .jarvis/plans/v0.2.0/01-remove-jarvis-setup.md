---
task_id: "01"
title: "Remove /jarvis-setup Skill"
depends_on: []
parallel_group: wave-1
target_files:
  - skills/jarvis-setup/SKILL.md
  - rules/AGENTS.md
  - rules/jarvis-routing.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 01 — Remove `/jarvis-setup` Skill

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Delete the interactive `skills/jarvis-setup/` directory and scrub all references to `/jarvis-setup` across routing rules and documentation in preparation for automated bootstrap via `scripts/setup.sh`.

---

## Context

In v0.1.0, `/jarvis-setup` was an interactive slash command that prompted the user. In v0.2.0, this is replaced by an automated, idempotent bash bootstrap script (`scripts/setup.sh`). Leaving the old skill in place creates confusion and namespace pollution.

---

## Acceptance Criteria

1. `skills/jarvis-setup/` directory is completely deleted from the workspace.
2. `rules/AGENTS.md` removes `/jarvis-setup` from the Routing Map table and updates Registry Fallback rule to point to `bash scripts/setup.sh`.
3. `rules/jarvis-routing.md` removes `/jarvis-setup` from the memory matrix, routing trees, and updates setup error messages to reference `scripts/setup.sh`.
4. No stale references to `/jarvis-setup` remain in any `.md` or `.json` file.
5. All `[[WikiLinks]]` are preserved intact.

---

## Implementation Notes

- Perform file deletion of `skills/jarvis-setup/SKILL.md` and remove directory `skills/jarvis-setup/`.
- Carefully edit `rules/AGENTS.md` and `rules/jarvis-routing.md` using targeted chunk replacement without disturbing unrelated develop routes.
