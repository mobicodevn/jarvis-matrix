---
task_id: "07"
title: "Create Mirrored Design Sub-Agent Fleet"
depends_on: ["06"]
parallel_group: wave-3
target_files:
  - agents/jarvis-design-interrogator.md
  - agents/jarvis-design-architect.md
  - agents/jarvis-design-taste-director.md
  - agents/jarvis-design-motion-engineer.md
  - agents/jarvis-design-executor.md
  - agents/jarvis-designer.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: high
status: completed
---

# Task 07 — Create Mirrored Design Sub-Agent Fleet

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Mirror the 5 specialized sub-agents and master coordinator from `.gemini/config/plugins/apex-design` into `agents/` under the `jarvis-` namespace with the **Strict "design" Keyword Naming Rule** (`jarvis-design-...`), 1-to-1 blueprint fidelity, zero-bloat context isolation, and Obsidian memory bindings. Explicitly exclude `apex-update`.

---

## Context

`Jarvis-Matrix` achieves peak design craft by delegating to specialized sub-agents rather than relying on a single generalist prompt:
- `jarvis-design-interrogator.md` (mirrored from `apex-interrogator`)
- `jarvis-design-architect.md` (mirrored from `apex-architect`)
- `jarvis-design-taste-director.md` (mirrored from `apex-taste-director`)
- `jarvis-design-motion-engineer.md` (mirrored from `apex-motion-engineer`)
- `jarvis-design-executor.md` (mirrored from `apex-executor`)
- `jarvis-designer.md` (mirrored from `apex-design` unified engine)

### Strict "design" Keyword Naming Rule
Every sub-agent and skill cloned from `apex-design` **MUST contain the keyword "design"** (e.g. `jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-designer`). If the word "design" is missing from the name, it will be misunderstood and confused with engineering/develop skills (`jarvis-spec`, `jarvis-planner`, `jarvis-builder`, `jarvis-analyzer`).

### Exclusion of `apex-update`
`apex-update` is explicitly NOT needed and will NOT be cloned or created. Repository updates across both `develop/` and `design/` are unified under `/jarvis-update`.

---

## Acceptance Criteria

1. **Strict Namespace & "design" Keyword Rule:**
   - All files prefixed with `jarvis-` and contain the keyword `design`:
     - `agents/jarvis-design-interrogator.md`
     - `agents/jarvis-design-architect.md`
     - `agents/jarvis-design-taste-director.md`
     - `agents/jarvis-design-motion-engineer.md`
     - `agents/jarvis-design-executor.md`
     - `agents/jarvis-designer.md`
   - Zero occurrences of `apex` in any prompt, agent description, or routing logic.
   - `apex-update` is NOT created.

2. **1-to-1 Blueprint Cloning:**
   - **`agents/jarvis-design-interrogator.md`**: Implements 6-dimension scoring framework (Target Audience, Brand Identity, Conversion Goal, Content Readiness, Tech Stack, Imagery). Enforces strict ≥ 95% clarity gate before downstream dispatch. Max 5 targeted questions.
   - **`agents/jarvis-design-architect.md`**: Implements claim-driven information architecture (every section proves a claim), 34 landing page patterns, component hierarchy, responsive grid strategies (375px → 768px → 1024px → 1440px), and conversion funnels.
   - **`agents/jarvis-design-taste-director.md`**: Implements visual art direction, 10-point Anti-Slop checklist (banning generic 3-card columns, stock gradients, emoji icons, grey placeholders), semantic color roles (`ground`, `ink`, `accent`, `surface`, `border`, `ring`), typography pairings, and 79 UI style mappings.
   - **`agents/jarvis-design-motion-engineer.md`**: Implements Emil Kowalski animation primitives: physics springs, custom cubic-bezier curves (`--ease-out: cubic-bezier(0.23, 1, 0.32, 1)`), frequency gates (100+/day = no animation), duration budgets (100-500ms max), stagger sequences (30-80ms), and `prefers-reduced-motion`.
   - **`agents/jarvis-design-executor.md`**: Implements Impeccable execution standards: finish the job, motion-off first, shipping size visual check, pre-delivery checklist (contrast 4.5:1, focus states, responsive, cursor-pointer).
   - **`agents/jarvis-designer.md`**: Master design coordinator managing the 6-phase pipeline, wave dispatches, and synthesis.

3. **Zero-Bloat Context Isolation:**
   - Each sub-agent definition specifies the exact, single SKILL.md slice it is permitted to load.
   - Forbids traversing or ingesting entire repository directories.

4. **Parallel vs. Sequential Handoff:**
   - Tasks frontmatter and handoff protocols declare parallel execution between `jarvis-design-taste-director` and `jarvis-design-motion-engineer`, with sequential gating before and after.

5. **Obsidian Memory Binding:**
   - Each agent's instructions mandate reading `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]` before taking action, and persisting finalized decisions back to `[[PROJECT_MEMORY.md]]`.

---

## Implementation Notes

- Read each blueprint file from `.gemini/config/plugins/apex-design/skills/` (`apex-interrogator/SKILL.md`, `apex-architect/SKILL.md`, etc.).
- Mirror their prompts with absolute precision into markdown agent files in `agents/`, replacing all namespace strings with `jarvis-design-...` and binding them into the Jarvis memory and DAG system.
