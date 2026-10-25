---
task_id: "06"
title: "Create /jarvis-design Master Skill"
depends_on: ["04"]
parallel_group: wave-3
target_files:
  - skills/jarvis-design/SKILL.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: high
status: completed
---

# Task 06 — Create `/jarvis-design` Master Skill

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Author `skills/jarvis-design/SKILL.md` as the unified design engineering router and orchestrator for Jarvis-Matrix, implementing the Mandatory 4-Repo Ensemble Rule, Dual-Mode Accessibility, Zero-Bloat Context Isolation, and the 6-Phase Pipeline coordinating the mirrored design sub-agent fleet (`jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-design-taste-director`, `jarvis-design-motion-engineer`, `jarvis-design-executor`).

---

## Context

`/jarvis-design` brings elite frontend design, anti-slop curation, and animation engineering into `Jarvis-Matrix`. It incorporates the capabilities of all 4 external design repositories:
1. `impeccable` (`pbakaus/impeccable`) — component polish & execution standards
2. `skills` (`emilkowalski/skills`) — spring physics, micro-interactions & animation curves
3. `taste-skill` (`leonxlnx/taste-skill`) — visual hierarchy, typography & anti-generic curation
4. `ui-ux-pro-max-skill` (`nextlevelbuilder/ui-ux-pro-max-skill`) — design systems & token architecture

To ensure zero confusion with engineering/develop skills, all coordinated design sub-agents strictly include the keyword `design` in their identifiers. `apex-update` is explicitly excluded from integration.

---

## Acceptance Criteria

1. **YAML Frontmatter:**
   ```yaml
   name: jarvis-design
   description: >-
     Unified design engineering engine and sub-agent orchestrator. Synthesizes UI/UX
     architecture, aesthetic curation, physics-based motion, and production code execution.
     Enforces >= 95% requirement clarity before code generation.
   triggers: ["/jarvis-design"]
   reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
   writes: [.jarvis/PROJECT_MEMORY.md]
   plugins_invoked: [impeccable, skills, taste-skill, ui-ux-pro-max-skill]
   ```

2. **Mandatory 4-Repo Ensemble Rule (Never Skip):**
   Explicitly documents that every UI/UX or animation invocation MUST evaluate and combine perspectives across all four local design repositories. Skipping any repo is defined as a fatal routing failure.

3. **Dual-Mode Accessibility:**
   - **Mode 1: Autonomous (1-Call):** `/jarvis-design <prompt>` autonomously decomposes the request, selects optimal skills, dispatches sub-agents, and produces the complete deliverable.
   - **Mode 2: Direct Sub-Skill Invocation:** `/jarvis-design --skill <name>` allows direct execution of any sub-skill from the 4 repos, as well as direct invocation of any `jarvis-design-...` sub-agent.

4. **6-Phase Pipeline Orchestration:**
   - Phase 1: Interrogation (`jarvis-design-interrogator`) ➔ 6-dimension scoring; gate ≥ 95%.
   - Phase 2: Context Ingestion & Category Matching ➔ UI/UX Pro Max 192 product types.
   - Phase 3: Art Direction (`jarvis-design-taste-director`) ➔ color roles, font pairing, anti-slop checklist.
   - Phase 4: Architecture & Motion (`jarvis-design-architect` + `jarvis-design-motion-engineer`) ➔ claim-driven IA + Emil Kowalski spring curves & duration budgets dispatched in parallel.
   - Phase 5: Execution (`jarvis-design-executor`) ➔ Impeccable production code generation.
   - Phase 6: Sequential Self-Review / Critique Gate ➔ anti-slop audit and motion performance check.

5. **Strict "design" Keyword Naming & Exclusion:**
   - Enforces that every coordinated design sub-agent uses the `jarvis-design-` prefix.
   - Explicitly records that `apex-update` is excluded from the design pipeline.

6. **Zero-Bloat Context Isolation:**
   Explicit routing table instructing each sub-agent to load ONLY its specific assigned SKILL.md file and never the full repo directory.

7. **Obsidian Memory Binding:**
   Mandatory pre-read of `[[JARVIS_MEMORY.md]]` (aesthetics/preferences) and `[[PROJECT_MEMORY.md]]` (project tokens), with writes of finalized design decisions to `[[PROJECT_MEMORY.md]]`.

8. **No-Rewrite Rule:**
   Dynamically references clone paths in `~/.gemini/config/github-plugins/design/`.

---

## Implementation Notes

- Reference the architecture of `.gemini/config/plugins/apex-design/skills/apex-design/SKILL.md` as the blueprint, strictly re-namespacing everything to `jarvis-design-...` and binding to Obsidian memory.
