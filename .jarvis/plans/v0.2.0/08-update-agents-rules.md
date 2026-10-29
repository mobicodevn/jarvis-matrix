---
task_id: "08"
title: "Update rules/AGENTS.md"
depends_on: ["01", "07"]
parallel_group: wave-4
target_files:
  - rules/AGENTS.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 08 — Update `rules/AGENTS.md`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `rules/AGENTS.md` to establish the `/jarvis-design` routing rule, define the design sub-agent fleet under the mandatory `jarvis-design-` naming convention, codify the Zero-Bloat Context Isolation Protocol, specify Parallel vs. Sequential handoff rules, remove `/jarvis-setup`, and bind Obsidian memory.

---

## Context

`rules/AGENTS.md` is auto-loaded by Antigravity on every interaction. It governs the orchestrator's decision-making. Incorporating the sub-agent and skill routing rules directly into `rules/AGENTS.md` ensures that every design sub-agent dispatch strictly adheres to the architecture without colliding with develop agents.

---

## Acceptance Criteria

1. **Routing Map Table Updated:**
   - Adds `/jarvis-design` ➔ `jarvis-designer` + `jarvis-design-*` sub-agents + 4 design repos (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`).
   - Removes `/jarvis-setup` row completely.
2. **Registry Fallback Rule:**
   - References `bash scripts/setup.sh` instead of `/jarvis-setup`.
3. **Compression Decision Matrix:**
   - Adds `/jarvis-design` row (Default: `ponytail-lite`, Escalation: `ponytail-full`).
4. **Design Sub-Agent Fleet & "design" Keyword Rule:**
   - Explicitly records `jarvis-design-interrogator`, `jarvis-design-architect`, `jarvis-design-taste-director`, `jarvis-design-motion-engineer`, `jarvis-design-executor`.
   - Mandates that every design sub-agent contain "design" to eliminate any confusion with `develop` agents.
   - Confirms `apex-update` is excluded.
5. **Zero-Bloat Isolation Codified:**
   - Codifies that sub-agents must NEVER load entire plugin directories.
   - Restricts each `jarvis-design-...` sub-agent to its assigned SKILL.md slice.
6. **Parallel vs. Sequential Handoff Codified:**
   - Parallel dispatch for independent design tasks (`jarvis-design-taste-director` + `jarvis-design-motion-engineer`).
   - Sequential review for quality and critique gates.
7. **Mandatory 4-Repo Ensemble Rule:**
   - Strictly forbids omitting any of the 4 design repositories during `/jarvis-design` tasks.
8. **Obsidian Memory Binding Rule:**
   - Re-affirms mandatory sync with `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]` for all design sub-agents.
9. All `[[WikiLinks]]` remain intact.

---

## Implementation Notes

- Use `replace_file_content` or `multi_replace_file_content` to cleanly integrate the new sections without breaking existing develop routing rules.
