# Jarvis-Matrix `v0.2.0`

A central multi-agent orchestrator, design engineering engine, and dynamic routing plugin for AI coding assistants.

Jarvis connects your local plugin library to your active workspace across two powerful pillars: **Engineering (`develop/`)** and **UI/UX & Motion (`design/`)**. It reads project architecture, manages persistent memory across sessions, routes tasks to specialized plugins, and dispatches sub-agents in parallel waves. Works natively in Antigravity, and generates adapters for Cursor, Claude Code, and Codex.

---

## Architecture

```
┌────────────────────────────────────────────────────────────────────────┐
│         User via IDE (Antigravity / Cursor / Claude Code / Codex)      │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│                          Jarvis-Matrix Core                            │
│         Dynamic Router → Unified Registry (v2) → Sub-Agent Pool        │
│                               ↕ Memory Sync                            │
│             JARVIS_MEMORY.md · CONTEXT.md · PROJECT_MEMORY.md          │
└──────────────────┬──────────────────────────────────┬──────────────────┘
                   │ lazy-load develop skills         │ lazy-load design skills
┌──────────────────▼──────────────────┐  ┌────────────▼──────────────────┐
│        develop/ (Engineering)       │  │        design/ (UI/UX & Motion)      │
│  Understand-Anything · graphify     │  │  impeccable · skills (Emil Kowalski) │
│  humanizer · ponytail · caveman     │  │  taste-skill · ui-ux-pro-max-skill   │
│  agent-skills                       │  │                                      │
└─────────────────────────────────────┘  └──────────────────────────────────────┘
```

The router never pre-loads all skills. It reads `config/registry.json`, identifies the exact SKILL.md files required for the current command, and injects only those into context (Zero-Bloat Context Isolation).

---

## Quick Start

### 1. Automated Bootstrap (Zero-Config)

Clone `jarvis-matrix` and run the bootstrap script:

```bash
bash scripts/setup.sh
```

`setup.sh` clones or updates all 10 repositories across both `develop/` and `design/` pillars, builds `config/registry.json` (schema v2), initializes `JARVIS_MEMORY.md`, and generates IDE adapters for Cursor, Claude Code, and Codex.

### 2. Analyze Your Project

Open any project workspace and run:

```
/jarvis-understand
```

This runs Understand-Anything + graphify on your codebase and produces `.jarvis/CONTEXT.md` — a persistent architectural knowledge graph.

### 3. Design Interfaces or Implement Features

- **For UI/UX Design & Animations:** `/jarvis-design <prompt>`
- **For Engineering Specifications:** `/jarvis-spec`
- **For Implementation Planning:** `/jarvis-plan`
- **For Parallel Implementation:** `/jarvis-build start`

---

## Command Reference

| Command / Script | Pillar | Purpose |
|------------------|--------|---------|
| `bash scripts/setup.sh` | Core | Automated bootstrap & repo synchronization |
| `/jarvis-design` | **Design** | Dual-mode UI/UX & motion design orchestrator |
| `/jarvis-understand` | Develop | Deep project analysis → CONTEXT.md |
| `/jarvis-context` | Develop | Load context into current session |
| `/jarvis-refresh` | Develop | Incremental context update (git diff) |
| `/jarvis-update` | Core | Pull latest changes across all 10 repositories |
| `/jarvis-spec` | Develop | Spec-before-code clarification interview (≥95%) |
| `/jarvis-plan` | Develop | Decompose spec into atomic task DAG |
| `/jarvis-build start` | Develop | Execute plan with parallel sub-agents |
| `/jarvis-build stop` | Develop | Checkpoint and halt build gracefully |
| `/jarvis-review` | Develop | Multi-agent parallel code review |
| `/jarvis-memory` | Core | View/edit global brain |
| `/jarvis-project-memory` | Core | View/edit project brain |

---

## The Design Pillar (`/jarvis-design`)

`/jarvis-design` synthesizes frontend interfaces combining structural UX, art direction, and physics-based animations.

### Mandatory 4-Repo Ensemble Rule
Every `/jarvis-design` invocation evaluates and combines perspectives across all four local design repositories:
1. **`impeccable`** (`pbakaus/impeccable`) — Component polish, craft details, interaction completeness, and execution standards.
2. **`skills`** (`emilkowalski/skills`) — Physics springs, micro-interactions, transition curves, and timing budgets.
3. **`taste-skill`** (`leonxlnx/taste-skill`) — Visual hierarchy, typography pairing, spacing scales, and 10-point anti-slop guardrails.
4. **`ui-ux-pro-max-skill`** (`nextlevelbuilder/ui-ux-pro-max-skill`) — Design systems, dark/light mode token architecture, accessibility, and 192 product categories.

### Design Sub-Agent Fleet
Built with the **Strict "design" Keyword Naming Rule** (all design sub-agents contain `design` to eliminate confusion with `develop` skills):
- **`jarvis-design-interrogator`**: Clarification gatekeeper scoring briefs across 6 dimensions. Enforces **≥ 95% clarity** before code generation.
- **`jarvis-design-architect`**: Claim-driven information architecture and responsive layout grid strategy (375px → 768px → 1024px → 1440px).
- **`jarvis-design-taste-director`**: Art direction, 10-point Anti-Slop checklist (banning default gradients, emoji UI icons, stock cards), and semantic color tokens.
- **`jarvis-design-motion-engineer`**: Emil Kowalski spring physics, custom cubic-bezier curves, duration budgets (100–350ms), and frequency gates.
- **`jarvis-design-executor`**: Impeccable production code synthesizer (tokens first, motion-off first, shipping size visual check).
- **`jarvis-designer`**: Master coordinator orchestrating the 6-phase pipeline.

### Invocation Modes
1. **Autonomous Mode (1-Call):**
   ```bash
   /jarvis-design Design a developer portfolio with dark/light mode and smooth micro-interactions
   ```
2. **Direct Sub-Skill & Sub-Agent Mode:**
   ```bash
   /jarvis-design --skill animate                      # Emil Kowalski animation primitives
   /jarvis-design --skill taste-skill                  # Aesthetic curation & anti-slop
   /jarvis-design --skill design-system                # UI/UX Pro Max tokens
   /jarvis-design-interrogator "Assess requirements"   # Direct requirement audit
   ```

---

## Memory System

Jarvis maintains three bidirectional memory layers linked with `[[WikiLinks]]`:
1. **`JARVIS_MEMORY.md`**: Global cross-project rules, coding standards, and user preferences.
2. **`.jarvis/PROJECT_MEMORY.md`**: Project-specific specs, conventions, and Design Tokens Vault.
3. **`.jarvis/CONTEXT.md`**: Structured architecture and module graph generated by `/jarvis-understand`.