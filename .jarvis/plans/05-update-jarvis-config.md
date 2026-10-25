---
task_id: "05"
title: "Update config/jarvis.config.json"
depends_on: ["02"]
parallel_group: wave-2
target_files:
  - config/jarvis.config.json
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 05 — Update `config/jarvis.config.json`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Update `config/jarvis.config.json` to store `design_plugins_root` alongside `plugins_root`, and advance version to `0.2.0`.

---

## Context

The orchestrator reads `config/jarvis.config.json` during `/jarvis-*` skill activations. Exposing `design_plugins_root` ensures that `/jarvis-design` and `/jarvis-update` can dynamically resolve design skills without hardcoding file paths.

---

## Acceptance Criteria

1. `config/jarvis.config.json` contains:
   ```json
   {
     "plugins_root": "~/.gemini/config/github-plugins/develop",
     "design_plugins_root": "~/.gemini/config/github-plugins/design",
     "detected_ides": ["antigravity", "cursor", "claude-code"],
     "setup_completed": true,
     "version": "0.2.0"
   }
   ```
2. Existing settings (`detected_ides`, `setup_completed`) are preserved.
3. Version field reads `"0.2.0"`.

---

## Implementation Notes

- Ensure `setup.sh` generates this file on clean runs, while existing config is gracefully migrated.
