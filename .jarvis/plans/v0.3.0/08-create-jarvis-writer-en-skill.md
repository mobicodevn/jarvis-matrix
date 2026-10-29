---
task_id: "08"
title: "Create Skill /jarvis-writer-en (English Humanized Writer)"
depends_on: ["06"]
parallel_group: wave-3
target_files:
  - skills/jarvis-writer-en/SKILL.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 08 — Create Skill `/jarvis-writer-en` (English Humanized Writer)

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Create the canonical skill file `skills/jarvis-writer-en/SKILL.md` for the English Humanized Writer, binding it to `humanizer` (`blader/humanizer`) and memory sources.

---

## Context

English AI text exhibits predictable default choices: not-X-but-Y contrasts, one-line closers, staged openers, forced triads, excessive dashes, inflated claims, sales buzzwords, and repetitive cadence. `/jarvis-writer-en` provides a direct slash command that dynamically loads `github-plugins/copywriting/humanizer/SKILL.md`, checks memory rules, and rewrites or drafts authentic human prose.

---

## Acceptance Criteria

1. File created at `skills/jarvis-writer-en/SKILL.md`.
2. Valid YAML frontmatter:
   - `name: jarvis-writer-en`
   - `triggers: ["/jarvis-writer-en"]`
   - `reads: [.jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]`
   - `plugins_invoked: [humanizer]`
   - `compression: none`
3. Process workflow:
   - Step 1: Memory Sync — reads tone, brand voice, and domain terminology from `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]`.
   - Step 2: Lazy-Load `humanizer/SKILL.md` from `config/registry.json`.
   - Step 3: Pattern Audit — marks §1 contrasts, §2 closers, §6 triads, §8 dashes, §19 bold labels, and structural staging.
   - Step 4: Human Craft Rewrite — keeps every fact and claim while altering cadence, rhythm, and sentence structures to sound human.
   - Step 5: Deliverable Output — produces polished prose, highlighting key edits if requested.
4. Includes clear usage instructions and invocation options (file path, pasted text, draft generation).

---

## Implementation Notes

- Reference the Wikipedia "Signs of AI writing" catalog patterns incorporated in `blader/humanizer`.
- Ensure bidirectional WikiLink preservation.

