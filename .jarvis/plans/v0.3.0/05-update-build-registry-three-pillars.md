---
task_id: "05"
title: "Update scripts/build-registry.sh for Three Pillars & Expanded Design"
depends_on: ["02"]
parallel_group: wave-2
target_files:
  - scripts/build-registry.sh
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 05 — Update `scripts/build-registry.sh` for Three Pillars & Expanded Design

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Upgrade `scripts/build-registry.sh` to accept up to 3 pillar root paths (`develop/`, `design/`, `copywriting/`), discover all 13 plugins and their skills, and output a valid v3 `config/registry.json`.

---

## Context

`build-registry.sh` is the core registry compiler.
- It must move `humanizer` scanning logic from the develop block to a new copywriting block.
- It must index `vietnamese-humanizer` (`humanizer-vi`, `style-guide-vi`, `translationese-cleaner-vi`, `grammar-checker-vi`).
- It must index `hyperframes` (`captions-overlay`, `changelog-video`) and `logo-design-skill` (`logo-design`).
- If a copywriting root is provided, it outputs schema version 3 with `copywriting_plugins_root` and `copywriting_plugins`.

---

## Acceptance Criteria

1. CLI argument parsing accepts:
   `./build-registry.sh <develop-root> [design-root] [copywriting-root] [output-path]`
   with clean handling when output-path is omitted.
2. In Develop pillar: `humanizer` scanning is moved to Copywriting pillar.
3. In Design pillar:
   - Index `hyperframes`: inspects `.agents/skills` for skills (`captions-overlay`, `changelog-video`).
   - Index `logo-design-skill`: inspects `skills/logo-design` for `logo-design` skill.
4. In Copywriting pillar:
   - Index `humanizer`: finds `humanizer/SKILL.md` (type: `skill-only`, invocation: `embedded-mode`).
   - Index `vietnamese-humanizer`: finds `skills/*/SKILL.md` (type: `skill-collection`, version from `pyproject.toml` or `package.json`).
5. Output JSON assembly:
   - When copywriting root is supplied: sets `"version": 3`, `"copywriting_plugins_root": "..."`, and `"copywriting_plugins": {...}`.
   - Preserves backward compatibility if copywriting root is omitted (version 2 or 1).
6. Script passes syntax check and produces valid JSON via `python3 -m json.tool`.

---

## Implementation Notes

- Use modular scanning functions for scanning nested `.agents/skills` or `skills`.
- Test scanning with absolute paths to avoid directory resolution errors.

