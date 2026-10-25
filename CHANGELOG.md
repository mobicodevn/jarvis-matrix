# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.2.0] - 2026-10-25

### Added
- **Design Pillar (`github-plugins/design/`):** First-class support for UI/UX, aesthetic curation, and animation engineering across four external repositories (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`).
- **`/jarvis-design` Master Skill:** Dual-mode design orchestrator supporting 1-call autonomous execution and direct user invocation of sub-skills and sub-agents.
- **Mirrored Design Sub-Agent Fleet:** Cloned 5 specialized sub-agents and master coordinator from `apex-design` under the strict `jarvis-` namespace with the mandatory "design" keyword:
  - `jarvis-design-interrogator` — Requirement scoring framework with strict ≥95% clarity gate.
  - `jarvis-design-architect` — Claim-driven information architecture and responsive layout grids.
  - `jarvis-design-taste-director` — Visual art direction, semantic color tokens, and 10-point Anti-Slop checklist.
  - `jarvis-design-motion-engineer` — Emil Kowalski spring physics, custom cubic-bezier curves, duration budgets, and frequency gates.
  - `jarvis-design-executor` — Production frontend code synthesizer adhering to Impeccable execution standards.
  - `jarvis-designer` — Master pipeline coordinator.
- **Automated Bootstrap Script (`scripts/setup.sh`):** Non-interactive script cloning and updating all 10 repositories across both pillars, building registry, initializing memory, and generating adapters.
- **Mandatory 4-Repo Ensemble Rule:** Strict orchestrator rule requiring all four design repos to be evaluated on every design task.
- **Zero-Bloat Context Isolation:** Scopes design sub-agents to single relevant SKILL.md slices without ingesting entire repo trees.
- **Registry Schema v2:** Support for `design_plugins` and `design_plugins_root` in `config/registry.json`.

### Changed
- **`scripts/build-registry.sh`:** Updated for dual-pillar directory scanning (`develop/` and `design/`), discovering all 25 develop skills and 24 design skills.
- **`skills/jarvis-update/SKILL.md`:** Expanded to pull all 10 repositories across both pillars.
- **`scripts/sync-adapters.sh`:** Enhanced to generate direct adapters for `jarvis-design` and all `jarvis-design-*` sub-agents across Cursor, Claude Code, and Codex.
- **`rules/AGENTS.md` & `rules/jarvis-routing.md`:** Updated with design sub-agent routing rules, memory read/write matrices, and fallback commands.
- **`JARVIS_MEMORY.md`:** Expanded Plugin Version Log to track all 10 repositories and codified global aesthetic standards.

### Removed
- **`/jarvis-setup` Skill:** Replaced by automated `scripts/setup.sh` script to streamline initial bootstrapping.
- **`apex-update`:** Excluded from cloning or adaptation as repository synchronization is handled centrally by `/jarvis-update`.

---

## [0.1.0] - 2026-10-24

### Added
- **Initial Jarvis-Matrix Multi-Agent System:** Root-level orchestrator routing six engineering plugins (`Understand-Anything`, `graphify`, `humanizer`, `ponytail`, `caveman`, `agent-skills`).
- **Core Slash Commands:** `/jarvis-understand`, `/jarvis-context`, `/jarvis-refresh`, `/jarvis-spec`, `/jarvis-plan`, `/jarvis-build`, `/jarvis-review`, `/jarvis-memory`, `/jarvis-project-memory`, `/jarvis-update`, `/jarvis-setup`.
- **Obsidian Memory System:** Tri-tier brain architecture (`JARVIS_MEMORY.md`, `PROJECT_MEMORY.md`, `CONTEXT.md`) with bidirectional WikiLinks.
- **Cross-Tool Adapter Engine:** Dynamic generator for Cursor (`.mdc`), Claude Code (`.md`), and Codex CLI (`.toml`).
- **Compression & Wave Execution Engine:** Integration with `ponytail` and `caveman` for token-efficient multi-agent dispatch.
