---
task_id: "07"
title: "Create Skill /jarvis-writer-vi (Vietnamese Humanized Writer)"
depends_on: ["06"]
parallel_group: wave-3
target_files:
  - skills/jarvis-writer-vi/SKILL.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 07 — Create Skill `/jarvis-writer-vi` (Vietnamese Humanized Writer)

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Create the canonical skill file `skills/jarvis-writer-vi/SKILL.md` for the Vietnamese Humanized Writer, binding it to `vietnamese-humanizer` and memory sources.

---

## Context

Vietnamese AI-generated text often suffers from translationese (bị động giả tạo, lạm dụng cấu trúc "bằng việc/thông qua việc", "mang tính", danh từ hóa quá mức, từ ngữ dịch thô thiển). `/jarvis-writer-vi` provides an end-to-end slash command that routes to `github-plugins/copywriting/vietnamese-humanizer` (`humanizer-vi`, `translationese-cleaner-vi`, `style-guide-vi`, and `grammar-checker-vi`), syncing with Obsidian memory for project tone, audience register, and brand voice.

---

## Acceptance Criteria

1. File created at `skills/jarvis-writer-vi/SKILL.md`.
2. Valid YAML frontmatter:
   - `name: jarvis-writer-vi`
   - `triggers: ["/jarvis-writer-vi"]`
   - `reads: [.jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]`
   - `plugins_invoked: [vietnamese-humanizer]`
   - `compression: none`
3. Process workflow:
   - Step 1: Memory Sync — reads tone, register, and brand rules from `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]`.
   - Step 2: Lazy-Load `vietnamese-humanizer` skill definitions from `config/registry.json`.
   - Step 3: Diagnostic Scan — identifies AI patterns, translationese, repetitive rhythm, and inflated staging.
   - Step 4: Semantic Preservation — strictly adheres to preservation checklist (factual data, quotes, numbers, technical terms, nuance).
   - Step 5: Output Generation — outputs clean, natural, humanized Vietnamese prose with optional audit rationale if requested.
4. Includes clear usage instructions and CLI invocation examples.

---

## Implementation Notes

- Provide practical examples of translationese removal (e.g., transforming "thực hiện việc tối ưu hóa" to "tối ưu", eliminating "là một trong những... hàng đầu").
- Preserve all `[[WikiLinks]]`.

