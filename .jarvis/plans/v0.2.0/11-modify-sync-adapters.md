---
task_id: "11"
title: "Modify scripts/sync-adapters.sh for Design Skills & Sub-Agents"
depends_on: ["07"]
parallel_group: wave-4
target_files:
  - scripts/sync-adapters.sh
  - adapters/cursor/jarvis-design.mdc
  - adapters/claude-code/jarvis-design.md
  - adapters/codex/jarvis-design.toml
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 11 — Modify `scripts/sync-adapters.sh` for Design Skills & Sub-Agents

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `scripts/sync-adapters.sh` to generate adapter definitions for `/jarvis-design`, the 6 mirrored design sub-agents (`jarvis-design-...`), and all individual design sub-skills across Cursor, Claude Code, and Codex, while purging stale `/jarvis-setup` adapters and omitting `apex-update`.

---

## Context

To satisfy the **Dual-Mode Accessibility Rule**, the user must be able to call:
1. The autonomous master skill `/jarvis-design`
2. Any individual design sub-agent (e.g., `jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-design-taste-director`, `jarvis-design-motion-engineer`, `jarvis-design-executor`)
3. Any individual sub-skill from the 4 design repositories (e.g., `animate`, `taste-skill`, `ui-ux-pro-max`, `impeccable`)
directly from their IDE interface.

To prevent confusion between design and develop commands, every design adapter must strictly contain the keyword "design". `apex-update` is explicitly excluded.

---

## Acceptance Criteria

1. Purges obsolete `/jarvis-setup` adapter files (`adapters/cursor/jarvis-setup.mdc`, `adapters/claude-code/jarvis-setup.md`, `adapters/codex/jarvis-setup.toml`).
2. Generates adapter bindings for `/jarvis-design` across all 3 IDE targets:
   - Cursor: `adapters/cursor/jarvis-design.mdc`
   - Claude Code: `adapters/claude-code/jarvis-design.md`
   - Codex: `adapters/codex/jarvis-design.toml`
3. Generates adapter bindings for each mirrored design sub-agent containing the mandatory "design" keyword:
   - `jarvis-design-interrogator`
   - `jarvis-design-architect`
   - `jarvis-design-taste-director`
   - `jarvis-design-motion-engineer`
   - `jarvis-design-executor`
   - `jarvis-designer`
4. Registers exposed design sub-skills from `impeccable`, `skills`, `taste-skill`, and `ui-ux-pro-max-skill` in the adapter index.
5. Confirms `apex-update` adapter files are NOT generated.
6. All adapter files strictly follow the `jarvis-` namespace with zero `apex` occurrences.

---

## Implementation Notes

- Ensure `scripts/sync-adapters.sh` parses `config/registry.json` v2 and iterates both `plugins` and `design_plugins`.
