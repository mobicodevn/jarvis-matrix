# Jarvis-Matrix `v0.3.0`

A central multi-agent orchestrator, design engineering engine, and dynamic routing plugin for AI coding assistants.

Jarvis connects your local plugin library to your active workspace across three powerful pillars: **Engineering (`develop/`)**, **UI/UX, Branding & Motion (`design/`)**, and **Language & Humanizing (`copywriting/`)**. It reads project architecture, manages persistent memory across sessions, routes tasks to specialized plugins, and dispatches sub-agents in parallel waves. Works natively in Antigravity, and generates native adapters for Cursor, Claude Code, and Codex.

---

## Architecture

```
┌────────────────────────────────────────────────────────────────────────┐
│         User via IDE (Antigravity / Cursor / Claude Code / Codex)      │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│                          Jarvis-Matrix Core                            │
│         Dynamic Router → Unified Registry (v3) → Sub-Agent Pool        │
│                               ↕ Memory Sync                            │
│             JARVIS_MEMORY.md · CONTEXT.md · PROJECT_MEMORY.md          │
└───────────┬───────────────────────┬───────────────────────┬────────────┘
            │ lazy-load develop     │ lazy-load design      │ lazy-load copywriting
┌───────────▼─────────────┐ ┌───────▼─────────────┐ ┌───────▼─────────────┐
│  develop/ (Engineering) │ │ design/ (UI & Motion)│ │ copywriting/ (Lang) │
│  Understand-Anything    │ │  impeccable         │ │  humanizer          │
│  graphify               │ │  skills (Kowalski)  │ │  vietnamese-        │
│  ponytail               │ │  taste-skill        │ │    humanizer        │
│  caveman                │ │  ui-ux-pro-max-skill│ │                     │
│  agent-skills           │ │  hyperframes        │ │                     │
│                         │ │  logo-design-skill  │ │                     │
└─────────────────────────┘ └─────────────────────┘ └─────────────────────┘
```

The router never pre-loads all skills. It reads `config/registry.json`, identifies the exact `SKILL.md` files required for the current command, and injects only those into context (Zero-Bloat Context Isolation).

---

## Quick Start

### 1. Automated Bootstrap (Zero-Config)

Clone `jarvis-matrix` and run the bootstrap script:

```bash
bash scripts/setup.sh
```

`setup.sh` clones or updates all 13 repositories across `develop/`, `design/`, and `copywriting/` pillars, builds `config/registry.json` (schema v3), initializes `JARVIS_MEMORY.md`, and generates IDE adapters for Cursor, Claude Code, and Codex.

### 2. Analyze Your Project

Open any project workspace and run:

```
/jarvis-understand
```

This runs Understand-Anything + graphify on your codebase and produces `.jarvis/CONTEXT.md` — a persistent architectural knowledge graph.

### 3. Write, Design, or Build

- **For Copywriting & Humanizing (Auto-Detect):** `/jarvis-writer <prompt or text>`
- **For Vietnamese Content:** `/jarvis-writer-vi <text>`
- **For English Content:** `/jarvis-writer-en <text>`
- **For UI/UX Design & Branding:** `/jarvis-design <prompt>`
- **For Engineering Specifications:** `/jarvis-spec`
- **For Implementation Planning:** `/jarvis-plan`
- **For Parallel Implementation:** `/jarvis-build start`

---

## Command Reference

| Command / Script | Pillar | Purpose |
|------------------|--------|---------|
| `bash scripts/setup.sh` | Core | Automated bootstrap & repo synchronization (13 repos) |
| `/jarvis-writer` | **Copywriting** | Master copywriting router (auto-detects Vietnamese vs English) |
| `/jarvis-writer-vi` | **Copywriting** | Dedicated Vietnamese humanized writer & translationese cleaner |
| `/jarvis-writer-en` | **Copywriting** | Dedicated English humanized writer & AI pattern stripper |
| `/jarvis-design` | **Design** | Dual-mode UI/UX design, branding & motion orchestrator |
| `/jarvis-understand` | Develop | Deep project analysis → CONTEXT.md |
| `/jarvis-context` | Develop | Load context into current session |
| `/jarvis-refresh` | Develop | Incremental context update (git diff) |
| `/jarvis-update` | Core | Pull latest changes across all 13 repositories |
| `/jarvis-spec` | Develop | Spec-before-code clarification interview (≥95%) |
| `/jarvis-plan` | Develop | Decompose spec into atomic task DAG |
| `/jarvis-build start` | Develop | Execute plan with parallel sub-agents |
| `/jarvis-build stop` | Develop | Checkpoint and halt build gracefully |
| `/jarvis-review` | Develop | Multi-agent parallel code review |
| `/jarvis-memory` | Core | View/edit global brain |
| `/jarvis-project-memory` | Core | View/edit project brain |

---

## The Copywriting Pillar (`/jarvis-writer*`)

The copywriting pillar eliminates synthetic AI phrasing, awkward translations, and mechanical cadence.

- **`/jarvis-writer` (Master Router Agent):** Automatically detects whether input text or instructions are Vietnamese or English via script diacritics and keyword heuristics, routing directly to the appropriate engine. Also accepts explicit flags (`--vi` or `--en`).
- **`/jarvis-writer-vi` (`vietnamese-humanizer`):** Strips translationese (passive voice "được/bị", nounification "việc/tiến hành/thực hiện", hollow intensifiers) and restores natural Vietnamese rhythm and registers (casual, neutral, academic).
- **`/jarvis-writer-en` (`humanizer`):** Targets Wikipedia-cataloged AI writing patterns (staged contrasts, forced triads, dash spam, robotic openers) while strictly preserving source facts, numbers, and technical nuance.

---

## The Design Pillar (`/jarvis-design`)

`/jarvis-design` synthesizes frontend interfaces combining structural UX, art direction, brand identity, and physics-based animations.

### Design Ensemble Evaluation
Every design task evaluates perspectives across 6 local design repositories:
1. **`impeccable`** (`pbakaus/impeccable`) — Component polish, craft details, interaction completeness, and execution standards.
2. **`skills`** (`emilkowalski/skills`) — Physics springs, micro-interactions, transition curves, and timing budgets.
3. **`taste-skill`** (`leonxlnx/taste-skill`) — Visual hierarchy, typography pairing, spacing scales, and 10-point anti-slop guardrails.
4. **`ui-ux-pro-max-skill`** (`nextlevelbuilder/ui-ux-pro-max-skill`) — Design systems, token architecture, accessibility, and 192 product categories.
5. **`hyperframes`** (`heygen-com/hyperframes`) — Animated video changelogs, frame composition, and synchronized captions overlays.
6. **`logo-design-skill`** (`kaankiziltug/logo-design-skill`) — Vector SVG brand marks, geometric icon construction, and favicon scaling.

### Design Sub-Agent Fleet
Built with the **Strict "design" Keyword Naming Rule**:
- **`jarvis-design-interrogator`**: Clarification gatekeeper enforcing **≥ 95% clarity** before code generation.
- **`jarvis-design-architect`**: Claim-driven information architecture and responsive layout grid strategy.
- **`jarvis-design-taste-director`**: Art direction, 10-point Anti-Slop checklist, and vector brand mark design (`logo-design-skill`).
- **`jarvis-design-motion-engineer`**: Emil Kowalski spring physics, duration budgets, and frame video overlays (`hyperframes`).
- **`jarvis-design-executor`**: Impeccable production code synthesizer.
- **`jarvis-designer`**: Master pipeline coordinator.

---

## Memory System

Jarvis maintains three bidirectional memory layers linked with `[[WikiLinks]]`:
1. **`JARVIS_MEMORY.md`**: Global cross-project rules, coding standards, and user preferences.
2. **`.jarvis/PROJECT_MEMORY.md`**: Project-specific specs, conventions, and Design Tokens Vault.
3. **`.jarvis/CONTEXT.md`**: Structured architecture and module graph generated by `/jarvis-understand`.
