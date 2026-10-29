---
task_id: "09"
title: "Create Master Copywriting Agent jarvis-writer & Skill /jarvis-writer"
depends_on: ["07", "08"]
parallel_group: wave-3
target_files:
  - agents/jarvis-writer.md
  - skills/jarvis-writer/SKILL.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 09 — Create Master Copywriting Agent `jarvis-writer` & Skill `/jarvis-writer`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Create the central copywriting coordinator agent `agents/jarvis-writer.md` and the master slash skill `skills/jarvis-writer/SKILL.md` that automatically analyzes input text or user prompts, decides whether to write in Vietnamese or English, and routes to `/jarvis-writer-vi` or `/jarvis-writer-en`.

---

## Context

While `/jarvis-writer-vi` and `/jarvis-writer-en` handle language-specific rewriting, users frequently want a unified command (`/jarvis-writer`) where the agent autonomously detects the language of the prompt or document and chooses the appropriate engine. `jarvis-writer` acts as the master copywriting router, inspecting diacritics, keyword patterns, and explicit flags (`--vi`, `--en`, `--auto`).

---

## Acceptance Criteria

1. **`agents/jarvis-writer.md`**:
   - YAML frontmatter:
     - `name: jarvis-writer`
     - `description`: Master copywriting coordinator agent and intelligent language router.
     - `role: copywriting-orchestration`
     - `reads: [user-prompt, JARVIS_MEMORY.md, PROJECT_MEMORY.md]`
     - `plugins: [humanizer, vietnamese-humanizer]`
   - Language Detection Logic:
     - **Explicit Directives/Flags:** `--vi`, `--en`, `--auto`, or phrasing like "viết bằng tiếng việt", "write in english".
     - **Diacritical & Script Heuristics:** Checks for Vietnamese diacritics (ă, â, đ, ê, ô, ơ, ư, etc.). If detected, selects Vietnamese engine.
     - **Project Memory Context:** Checks `PROJECT_MEMORY.md` for target audience default language when input is ambiguous or bilingual.
     - **Bilingual / Mixed Documents:** Splits or handles multi-lingual sections with corresponding engines.
   - Delegation:
     - Routes Vietnamese text to `jarvis-writer-vi` (`vietnamese-humanizer`).
     - Routes English text to `jarvis-writer-en` (`blader/humanizer`).
2. **`skills/jarvis-writer/SKILL.md`**:
   - Canonical slash command definition for `/jarvis-writer`.
   - Supports:
     ```bash
     /jarvis-writer "Text or draft prompt"             # Auto-detect language
     /jarvis-writer --vi "Văn bản cần làm mượt"         # Explicit Vietnamese
     /jarvis-writer --en "Text to humanize"            # Explicit English
     /jarvis-writer --file path/to/doc.md              # File-based rewriting
     ```
   - Synchronizes tone and brand rules from `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]`.
3. Preserves all `[[WikiLinks]]`.

---

## Implementation Notes

- Ensure `jarvis-writer` operates with zero bloat by only loading the specific SKILL.md slice required for the determined language.

