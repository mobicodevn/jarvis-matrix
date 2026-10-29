---
type: jarvis-prp
version: "0.3.0"
previous_version: "0.2.0"
created: "2026-10-29T09:00:00+07:00"
last_updated: "2026-10-29T09:06:00+07:00"
status: validated
confidence: 99%
linked_memory:
  global: "[[JARVIS_MEMORY.md]]"
  context: "[[CONTEXT.md]]"
  project: "[[PROJECT_MEMORY.md]]"
tags: [prp, v0.3.0, three-pillars, copywriting, humanizer, vietnamese-humanizer, hyperframes, logo-design-skill, jarvis-writer]
---

# Jarvis-Matrix v0.3.0 — Product Requirement Prompt

> Links: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]
>
> **SPECIFICATION & IMPLEMENTATION BLUEPRINT:** Decomposed and validated for v0.3.0 execution.

---

## 1. Executive Summary

v0.1.0 established Jarvis-Matrix as an engineering-focused develop orchestrator. v0.2.0 expanded the architecture into two pillars by incorporating design and animation capabilities via four external repositories, `/jarvis-design`, and a specialized design sub-agent fleet.

**v0.3.0 advances Jarvis-Matrix to a comprehensive Three-Pillar Architecture (`develop/`, `design/`, `copywriting/`)**:
1. **Pillar 3 (`copywriting/`)**: Relocates `humanizer` from `develop/` into `copywriting/` and registers `vietnamese-humanizer` alongside it. Introduces:
   - **`jarvis-writer`** (Master Copywriting Agent & `/jarvis-writer` slash skill): Central language-detecting router agent that analyzes user input, detects language (Vietnamese vs English vs explicit flags), and dynamically delegates to specialized writers.
   - **`/jarvis-writer-vi`**: Vietnamese Humanized Writer routing to `vietnamese-humanizer` (`humanizer-vi`, `translationese-cleaner-vi`, `style-guide-vi`, `grammar-checker-vi`).
   - **`/jarvis-writer-en`**: English Humanized Writer routing to `humanizer` (`blader/humanizer`).
   - All bound across supported IDE adapters (Antigravity IDE, Cursor, Claude Code, Codex).
2. **Design Pillar Expansion**: Registers `hyperframes` (frame architecture and video changelog / captions flow) and `logo-design-skill` (vector marks, branding, and icon design) into `github-plugins/design/` and wires them into `/jarvis-design` and its design sub-agent fleet.
3. **Orchestration & Synchronization**: Upgrades `scripts/setup.sh`, `scripts/build-registry.sh`, `config/registry.schema.json`, and `/jarvis-update` to handle all three pillars (13 external repositories total).
4. **Knowledge Refresh & Humanized Documentation**: Executes `/jarvis-update` and `/jarvis-understand` to refresh the codebase knowledge graph, bumps version constants to `0.3.0`, and applies `/jarvis-writer-en` standards to produce clean, natural release notes in `CHANGELOG.md` and `README.md`.

---

### Key Deltas from v0.2.0

| Change | Type | Impact |
|--------|------|--------|
| Three-pillar directory structure (`develop/`, `design/`, `copywriting/`) | **NEW** | Reorganizes external plugins into 3 distinct functional pillars |
| Relocate `humanizer` to `copywriting/` | **REFACTORED** | Moved from `github-plugins/develop/humanizer` to `github-plugins/copywriting/humanizer` |
| Register `vietnamese-humanizer` | **NEW** | Cloned from `https://github.com/longhang2004/vietnamese-humanizer` into `github-plugins/copywriting/vietnamese-humanizer` |
| `jarvis-writer` master agent & skill | **NEW** | Language-detecting router agent (`agents/jarvis-writer.md` & `skills/jarvis-writer/SKILL.md`) determining when to write Vietnamese vs English |
| `/jarvis-writer-vi` slash skill | **NEW** | Dedicated Vietnamese humanized writer routing to `vietnamese-humanizer` with memory bindings |
| `/jarvis-writer-en` slash skill | **NEW** | Dedicated English humanized writer routing to `humanizer` with memory bindings |
| IDE Adapter generation for copywriting | **NEW** | Antigravity, Cursor (`.mdc`), Claude Code (`.md`), Codex (`.toml`) adapters for `/jarvis-writer`, `/jarvis-writer-vi`, `/jarvis-writer-en` |
| `hyperframes` design plugin integration | **NEW** | Cloned from `https://github.com/heygen-com/hyperframes` into `github-plugins/design/hyperframes` |
| `logo-design-skill` design plugin integration | **NEW** | Cloned from `https://github.com/kaankiziltug/logo-design-skill` into `github-plugins/design/logo-design-skill` |
| `/jarvis-design` expansion | **MODIFIED** | Integrates `hyperframes` and `logo-design-skill` into autonomous and direct selection modes |
| `scripts/setup.sh` upgrade | **MODIFIED** | Clones/updates 13 repositories across 3 pillars; writes `copywriting_plugins_root` |
| `scripts/build-registry.sh` & Schema v3 | **MODIFIED** | Supports 3 pillar roots, indexes copywriting plugins, produces v3 schema |
| `/jarvis-update` upgrade | **MODIFIED** | Scans and pulls all 13 repositories across develop (5), design (6), and copywriting (2) |
| `/jarvis-understand` refresh | **MODIFIED** | Re-analyzes Jarvis-Matrix codebase and refreshes `CONTEXT.md` knowledge graph |
| Version bump to `0.3.0` | **MODIFIED** | `plugin.json`, `config/jarvis.config.json`, `registry.json`, `JARVIS_MEMORY.md`, `PROJECT_MEMORY.md` |
| Humanized Documentation | **MODIFIED** | `CHANGELOG.md` and `README.md` polished with `/jarvis-writer-en` |

---

## 2. Target Three-Pillar Architecture

```
github-plugins/
├── develop/                         # Pillar 1: Engineering Plugins (5 repos)
│   ├── agent-skills/                # Addy Osmani agent workflow skills
│   ├── caveman/                     # Ultra-concise token compression
│   ├── graphify/                    # Codebase knowledge graph extraction
│   ├── ponytail/                    # Context minimization engine
│   └── Understand-Anything/         # AST and architecture analysis monorepo
│
├── design/                          # Pillar 2: UI/UX & Motion Plugins (6 repos)
│   ├── hyperframes/                 # Frame animations & video/captions overlays [NEW]
│   ├── impeccable/                  # Impeccable frontend design standards
│   ├── logo-design-skill/           # Brand identity & logo/mark crafting [NEW]
│   ├── skills/                      # Emil Kowalski physics springs & transitions
│   ├── taste-skill/                 # Curated anti-slop visual identities
│   └── ui-ux-pro-max-skill/         # Comprehensive design system & UI tokens
│
└── copywriting/                     # Pillar 3: Language & Humanizer Plugins (2 repos)
    ├── humanizer/                   # English AI pattern stripping & prose polishing [RELOCATED]
    └── vietnamese-humanizer/        # Vietnamese authentic writing & style guide [NEW]
```

---

## 3. Scope Boundaries & Confidence Assessment

### Confidence Score: 99%

- **Scope: IN**
  - Relocating `humanizer` to `github-plugins/copywriting/humanizer`.
  - Adding `vietnamese-humanizer` to `github-plugins/copywriting/`.
  - Creating `agents/jarvis-writer.md` as the master language-detection and copywriting coordinator agent.
  - Creating `skills/jarvis-writer/SKILL.md` with auto-routing between Vietnamese and English.
  - Creating `skills/jarvis-writer-vi/SKILL.md` and `skills/jarvis-writer-en/SKILL.md`.
  - Updating `config/registry.schema.json` to schema version 3 with `copywriting_plugins_root` and `copywriting_plugins`.
  - Updating `config/jarvis.config.json` to version `0.3.0`.
  - Upgrading `scripts/setup.sh` and `scripts/build-registry.sh` for three pillars.
  - Generating IDE adapters for all copywriting commands.
  - Wiring `hyperframes` and `logo-design-skill` into `/jarvis-design` and design sub-agents (`jarvis-designer`, `jarvis-design-motion-engineer`, `jarvis-design-taste-director`).
  - Updating references in existing skills (`/jarvis-understand`, `/jarvis-plan`, `/jarvis-review`, `jarvis-analyzer`, `jarvis-planner`) to point to `copywriting/humanizer`.
  - Upgrading and executing `/jarvis-update` across all 13 repositories.
  - Executing `/jarvis-understand` to refresh `CONTEXT.md` and `JARVIS_MEMORY.md`.
  - Bumping all version tags to `0.3.0` and updating `CHANGELOG.md` and `README.md` using humanized prose.

- **Scope: OUT**
  - Modifying the internal source code or business logic of external cloned repositories.
  - Forking or duplicating external skills locally (strict zero-bloat dynamic routing).
  - Integrating `apex-update` (remains explicitly excluded; unified under `/jarvis-update`).

---

## 4. Acceptance Criteria

1. **Copywriting Pillar Structure:**
   - `github-plugins/copywriting/humanizer` exists and is functional; `github-plugins/develop/humanizer` is removed.
   - `github-plugins/copywriting/vietnamese-humanizer` exists with all skills (`humanizer-vi`, `style-guide-vi`, `translationese-cleaner-vi`, `grammar-checker-vi`).
2. **Master Agent `jarvis-writer` & Router Skill `/jarvis-writer`:**
   - `agents/jarvis-writer.md` defined with language-detection heuristics (diacritics ratio, explicit keywords/flags `--vi`/`--en`, target audience rules).
   - `skills/jarvis-writer/SKILL.md` allows unified 1-call copywriting invocation with automatic language routing to `/jarvis-writer-vi` or `/jarvis-writer-en`.
   - Dedicated skills `/jarvis-writer-vi` and `/jarvis-writer-en` support direct language-specific invocation.
3. **Registry & Configuration:**
   - `config/registry.schema.json` conforms to schema v3 with `copywriting_plugins_root` and `copywriting_plugins`.
   - `config/jarvis.config.json` contains `plugins_root`, `design_plugins_root`, `copywriting_plugins_root`, and version `"0.3.0"`.
   - `scripts/build-registry.sh` succeeds with all 3 pillars, indexing 5 develop, 6 design, and 2 copywriting plugins.
4. **IDE Adapters:**
   - Generated for `/jarvis-writer`, `/jarvis-writer-vi`, and `/jarvis-writer-en` across Cursor (`.mdc`), Claude Code (`.md`), Codex (`.toml`), and Antigravity.
5. **Design Pillar Expansion:**
   - `hyperframes` skills (`captions-overlay`, `changelog-video`) indexed in `registry.json` and integrated into `/jarvis-design` motion flows.
   - `logo-design-skill` (`logo-design`) indexed in `registry.json` and integrated into `/jarvis-design` branding/visual identity flows.
   - Autonomous selection and direct `--skill` flags supported for both.
6. **Orchestrator Routing Rules:**
   - `rules/AGENTS.md` and `rules/jarvis-routing.md` updated with the 3 pillars, new skills, master writer agent, and updated references.
   - All internal skills (`jarvis-understand`, `jarvis-plan`, `jarvis-review`) reference `copywriting/humanizer`.
7. **Updates, Context & Docs:**
   - `/jarvis-update` updates all 13 repos and syncs `JARVIS_MEMORY.md` Plugin Version Log.
   - `/jarvis-understand` refreshes `.jarvis/CONTEXT.md`.
   - `CHANGELOG.md` contains `[0.3.0]` release notes adhering to `/jarvis-writer-en` standards.
   - `README.md` documents 3-pillar structure, new slash commands, and expanded design fleet.

---

## 5. Wave Execution Roadmap (16 Tasks)

| Wave | Tasks | Description | Parallelism |
|------|-------|-------------|-------------|
| **Wave 1** | Tasks 01, 02, 03 | Foundation: Move humanizer, update registry schema v3, update config v0.3.0 | Parallel |
| **Wave 2** | Tasks 04, 05, 06 | Core Scripts: Update setup.sh, build-registry.sh, generate registry.json v3 | Parallel (04, 05) ➔ Sequential (06) |
| **Wave 3** | Tasks 07, 08, 09, 10 | Copywriting Engine: Create /jarvis-writer-vi, /jarvis-writer-en, jarvis-writer agent & skill, sync IDE adapters | Parallel (07, 08) ➔ Sequential (09, 10) |
| **Wave 4** | Tasks 11, 12 | Design Expansion & Routing: Wire hyperframes/logo-design, update rules & references | Parallel |
| **Wave 5** | Tasks 13, 14 | Synchronize & Refresh: Run /jarvis-update across 3 pillars, run /jarvis-understand | Sequential |
| **Wave 6** | Tasks 15, 16 | Docs & Memory: Humanize CHANGELOG/README, update PROJECT_MEMORY.md & release audit | Sequential |
