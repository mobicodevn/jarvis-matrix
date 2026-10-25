---
type: jarvis-project-memory
version: 1
project: "jarvis-matrix"
project_root: "/Users/kietnguyen/.gemini/config/plugins/jarvis-matrix"
created: "2026-10-25T09:38:00+07:00"
last_modified: "2026-10-25T09:48:00+07:00"
linked_context: "[[CONTEXT.md]]"
linked_global: "[[JARVIS_MEMORY.md]]"
active_plan: "[[.jarvis/plans/PRP-v0.2.0.md]]"
tags: [project, memory, rules, v0.2.0]
---

# Project Memory: jarvis-matrix

> Project-scoped knowledge for the Jarvis-Matrix orchestrator.
> Links: [[CONTEXT.md]] | [[JARVIS_MEMORY.md]]
> Managed by `/jarvis-project-memory`. Read by every `/jarvis-*` command operating in this project.

## Project Specs Vault

### Spec: v0.2.0 Two-Pillar Architecture & Design Sub-Agent Fleet (confidence: 99%)
**Created:** 2026-10-25
**Requirement:** Add design pillar (`github-plugins/design/` with 4 repos), `/jarvis-design` master skill, mirrored design sub-agent fleet (`jarvis-design-...`), and automated `scripts/setup.sh` bootstrap script.
**Acceptance Criteria:**
- [x] Task 01: Remove `/jarvis-setup` skill
- [x] Task 02: Write `scripts/setup.sh` bootstrap script
- [x] Task 03: Update `config/registry.schema.json`
- [x] Task 04: Modify `scripts/build-registry.sh` for dual-pillar scanning
- [x] Task 05: Update `config/jarvis.config.json`
- [x] Task 06: Create `skills/jarvis-design/SKILL.md`
- [x] Task 07: Create mirrored design sub-agent fleet in `agents/` (`jarvis-design-...`)
- [x] Task 08: Update `rules/AGENTS.md`
- [x] Task 09: Update `rules/jarvis-routing.md`
- [x] Task 10: Update `skills/jarvis-update/SKILL.md`
- [x] Task 11: Modify `scripts/sync-adapters.sh`
- [x] Task 12: Create `CHANGELOG.md`
- [x] Task 13: Update `README.md`
- [x] Task 14: Update `JARVIS_MEMORY.md` Plugin Version Log & aesthetic rules
- [x] Task 15: Refresh `.jarvis/CONTEXT.md`

## Project Rules & Conventions

- Strictly maintain two-pillar directory structure: `develop/` and `design/`.
- Every design sub-agent cloned from `apex-design` MUST contain the keyword "design" in its name (`jarvis-design-...`).
- `apex-update` is explicitly excluded from integration.
- Sub-agents must never load entire plugin directories (Zero-Bloat Context Isolation).
- Dynamic referencing: never duplicate or rewrite external cloned skill files.
- Preserve all `[[WikiLinks]]`.

## Active Plan Status

- **Active plan:** [[.jarvis/plans/PRP-v0.2.0.md]]
- **Tasks complete:** 15/15 (100%)
- **Last checkpoint:** 2026-10-25T09:48:00+07:00
- **In-progress tasks:** []
- **Status:** COMPLETED

## Design Tokens Vault

<!-- Populated by /jarvis-design sub-agents -->
