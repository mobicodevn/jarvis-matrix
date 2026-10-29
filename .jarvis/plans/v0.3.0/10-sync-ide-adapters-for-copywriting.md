---
task_id: "10"
title: "Sync IDE Adapters for Copywriting Skills & Agent"
depends_on: ["07", "08", "09"]
parallel_group: wave-3
target_files:
  - scripts/sync-adapters.sh
  - adapters/cursor/jarvis-writer.mdc
  - adapters/cursor/jarvis-writer-vi.mdc
  - adapters/cursor/jarvis-writer-en.mdc
  - adapters/claude-code/jarvis-writer.md
  - adapters/claude-code/jarvis-writer-vi.md
  - adapters/claude-code/jarvis-writer-en.md
  - adapters/codex/jarvis-writer.toml
  - adapters/codex/jarvis-writer-vi.toml
  - adapters/codex/jarvis-writer-en.toml
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 10 — Sync IDE Adapters for Copywriting Skills & Agent

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Run `scripts/sync-adapters.sh` to generate native IDE adapter files for `/jarvis-writer`, `/jarvis-writer-vi`, and `/jarvis-writer-en` across Cursor, Claude Code, and Codex, ensuring cross-environment slash command binding.

---

## Context

Jarvis-Matrix maintains compatibility with multiple AI code editors. The adapter generator scans `skills/*/SKILL.md` and produces `.mdc` for Cursor, `.md` for Claude Code, and `.toml` for Codex. With the three writer skills created (`jarvis-writer`, `jarvis-writer-vi`, `jarvis-writer-en`), running `sync-adapters.sh` generates all bridge files.

---

## Acceptance Criteria

1. Execute `./scripts/sync-adapters.sh skills adapters`.
2. Following files are generated with accurate descriptions and canonical paths:
   - `adapters/cursor/jarvis-writer.mdc`
   - `adapters/cursor/jarvis-writer-vi.mdc`
   - `adapters/cursor/jarvis-writer-en.mdc`
   - `adapters/claude-code/jarvis-writer.md`
   - `adapters/claude-code/jarvis-writer-vi.md`
   - `adapters/claude-code/jarvis-writer-en.md`
   - `adapters/codex/jarvis-writer.toml`
   - `adapters/codex/jarvis-writer-vi.toml`
   - `adapters/codex/jarvis-writer-en.toml`
3. Antigravity discovers `jarvis-writer`, `jarvis-writer-vi`, and `jarvis-writer-en` via direct `skills/` indexing.
4. All existing adapters remain untouched and valid.

---

## Implementation Notes

- Verify that `extract_field` in `sync-adapters.sh` parses multiline YAML descriptions properly.

