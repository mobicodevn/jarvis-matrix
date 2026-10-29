---
task_id: "03"
title: "Update config/jarvis.config.json & plugin.json to v0.3.0"
depends_on: []
parallel_group: wave-1
target_files:
  - config/jarvis.config.json
  - plugin.json
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 03 — Update `config/jarvis.config.json` & `plugin.json` to v0.3.0

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `config/jarvis.config.json` to declare `copywriting_plugins_root` alongside `plugins_root` and `design_plugins_root`, and advance plugin versions to `0.3.0`.

---

## Context

Orchestrator skills and scripts inspect `config/jarvis.config.json` to dynamically resolve plugin directories across the ecosystem. Declaring `copywriting_plugins_root` enables `/jarvis-writer-vi`, `/jarvis-writer-en`, and `/jarvis-update` to discover copywriting repositories dynamically.

---

## Acceptance Criteria

1. `config/jarvis.config.json` includes:
   ```json
   "plugins_root": "~/.gemini/config/github-plugins/develop",
   "design_plugins_root": "~/.gemini/config/github-plugins/design",
   "copywriting_plugins_root": "~/.gemini/config/github-plugins/copywriting",
   "version": "0.3.0"
   ```
2. `plugin.json` version is updated to `"0.3.0"`.
3. Both JSON files are valid and formatted with standard indentation.

---

## Implementation Notes

- Read and parse existing `config/jarvis.config.json`.
- Add `copywriting_plugins_root` and set `version: "0.3.0"`.
- Update `version` in `plugin.json` to `"0.3.0"`.

