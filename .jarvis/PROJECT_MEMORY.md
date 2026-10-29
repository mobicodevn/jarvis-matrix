---
type: jarvis-project-memory
version: 2
project: "jarvis-matrix"
project_root: "/Users/kietnguyen/.gemini/config/plugins/jarvis-matrix"
created: "2026-10-25T09:38:00+07:00"
last_modified: "2026-10-29T09:20:00+07:00"
linked_context: "[[CONTEXT.md]]"
linked_global: "[[JARVIS_MEMORY.md]]"
active_plan: "[[.jarvis/plans/v0.3.0/00-plan-overview.md]]"
tags: [project, memory, rules, v0.3.0, three-pillars, jarvis-writer]
---

# Project Memory: jarvis-matrix

> Project-scoped knowledge for the Jarvis-Matrix orchestrator.
> Links: [[CONTEXT.md]] | [[JARVIS_MEMORY.md]]
> Managed by `/jarvis-project-memory`. Read by every `/jarvis-*` command operating in this project.

## Project Specs Vault

### Spec: v0.3.0 Three-Pillar Architecture, Copywriting Engine & Design Expansion (confidence: 99%)
**Created:** 2026-10-29  
**Requirement:** Establish three-pillar architecture (`develop/`, `design/`, `copywriting/`), relocate `humanizer` to `copywriting/`, register `vietnamese-humanizer`, create dedicated master agent `jarvis-writer` & skills `/jarvis-writer`, `/jarvis-writer-vi` & `/jarvis-writer-en` with IDE adapters, expand `design/` with `hyperframes` & `logo-design-skill`, upgrade `/jarvis-update` & `build-registry.sh`, execute `/jarvis-understand` post-refresh, bump version to `0.3.0`, and humanize `CHANGELOG.md` & `README.md`.  
**Acceptance Criteria:**
- [x] Task 01: Relocate `humanizer` to `github-plugins/copywriting/`
- [x] Task 02: Update `config/registry.schema.json` to schema v3
- [x] Task 03: Update `config/jarvis.config.json` & `plugin.json` to v0.3.0
- [x] Task 04: Update `scripts/setup.sh` for three pillars & 13 repositories
- [x] Task 05: Update `scripts/build-registry.sh` for three pillars & expanded design
- [x] Task 06: Rebuild `config/registry.json` to schema v3
- [x] Task 07: Create skill `/jarvis-writer-vi` (Vietnamese Humanized Writer)
- [x] Task 08: Create skill `/jarvis-writer-en` (English Humanized Writer)
- [x] Task 09: Create master copywriting agent `jarvis-writer` & skill `/jarvis-writer` (Language Detection & Auto-Routing)
- [x] Task 10: Sync IDE adapters for copywriting skills across Cursor, Claude Code, Codex
- [x] Task 11: Wire `hyperframes` & `logo-design-skill` into `/jarvis-design` & design sub-agents
- [x] Task 12: Update orchestrator routing rules & redirect `humanizer` references
- [x] Task 13: Upgrade and execute `/jarvis-update` across all 3 pillars
- [x] Task 14: Execute `/jarvis-understand` to refresh project architecture knowledge
- [x] Task 15: Humanize and update `CHANGELOG.md` & `README.md`
- [x] Task 16: Validate v0.3.0 release integrity & update `PROJECT_MEMORY.md`

**Scope Boundaries:**
- IN: Three pillars structure, master copywriting router agent, copywriting engine, 13-repo indexing, `/jarvis-writer-*`, design expansion, full sync and docs.
- OUT: External plugin source alteration, duplicate local skill definitions, apex-update.

**Technical Constraints:**
- Strict Zero-Bloat Context Isolation.
- Preserve all `[[WikiLinks]]`.
- Backward compatibility for registry and configs.

---

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

- Strictly maintain three-pillar directory structure: `develop/`, `design/`, and `copywriting/`.
- Humanized writing: all documentation and user-facing content must adhere to `/jarvis-writer-en` (or `/jarvis-writer-vi`) standards to eliminate AI tropes.
- Master copywriting agent `jarvis-writer` acts as the intelligent language-detection router between Vietnamese and English.
- Every design sub-agent cloned from `apex-design` MUST contain the keyword "design" in its name (`jarvis-design-...`).
- `apex-update` is explicitly excluded from integration.
- Sub-agents must never load entire plugin directories (Zero-Bloat Context Isolation).
- Dynamic referencing: never duplicate or rewrite external cloned skill files.
- Preserve all `[[WikiLinks]]`.

## Active Plan Status

- **Active plan:** [[.jarvis/plans/v0.3.0/00-plan-overview.md]]
- **Tasks complete:** 16/16 (100%)
- **Last checkpoint:** 2026-10-29T09:20:00+07:00
- **In-progress tasks:** []
- **Status:** COMPLETED

## Design Tokens Vault

<!-- Populated by /jarvis-design sub-agents -->
