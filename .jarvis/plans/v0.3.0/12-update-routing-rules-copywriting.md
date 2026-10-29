---
task_id: "12"
title: "Update Orchestrator Routing Rules & Humanizer References"
depends_on: ["06", "09"]
parallel_group: wave-4
target_files:
  - rules/AGENTS.md
  - rules/jarvis-routing.md
  - skills/jarvis-understand/SKILL.md
  - skills/jarvis-plan/SKILL.md
  - skills/jarvis-review/SKILL.md
  - agents/jarvis-analyzer.md
  - agents/jarvis-planner.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 12 — Update Orchestrator Routing Rules & Humanizer References

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update central orchestrator routing rules in `rules/AGENTS.md` and `rules/jarvis-routing.md` to reflect the Three-Pillar structure, document the new copywriting skills (`/jarvis-writer`, `/jarvis-writer-vi`, `/jarvis-writer-en`), document `jarvis-writer` master agent, and redirect all internal references to `humanizer` to `github-plugins/copywriting/humanizer`.

---

## Context

Several existing skills (`/jarvis-understand`, `/jarvis-plan`, `/jarvis-review`) and sub-agents (`jarvis-analyzer`, `jarvis-planner`) rely on `humanizer` in embedded mode to polish architectural summaries and plan overviews. Because `humanizer` relocated from `develop/` to `copywriting/`, all internal routing documents and skill manifests must update their canonical paths.

---

## Acceptance Criteria

1. `rules/AGENTS.md`:
   - Document the Three-Pillar structure: `develop/`, `design/`, `copywriting/`.
   - Update Routing Map with `/jarvis-writer`, `/jarvis-writer-vi`, and `/jarvis-writer-en`.
   - Note `hyperframes` and `logo-design-skill` under design plugins.
2. `rules/jarvis-routing.md`:
   - Create **Pillar 3: Copywriting Plugins (`copywriting/`)** section covering `humanizer` and `vietnamese-humanizer`.
   - Document `jarvis-writer` routing heuristics (diacritics detection, explicit flags `--vi`/`--en`, target audience rules).
   - Remove `humanizer` from Pillar 1 (`develop/`).
   - Add `hyperframes` and `logo-design-skill` under Pillar 2 (`design/`).
3. Internal skills and sub-agents:
   - `skills/jarvis-understand/SKILL.md`: update `humanizer` path/lookup to `copywriting/humanizer`.
   - `skills/jarvis-plan/SKILL.md`: update `humanizer` path/lookup to `copywriting/humanizer`.
   - `skills/jarvis-review/SKILL.md`: update `humanizer` path/lookup to `copywriting/humanizer`.
   - `agents/jarvis-analyzer.md`: update plugin reference to `copywriting/humanizer`.
   - `agents/jarvis-planner.md`: update plugin reference to `copywriting/humanizer`.
4. Preserve all `[[WikiLinks]]`.

---

## Implementation Notes

- Verify that embedded mode invocation instructions remain consistent across skills.

