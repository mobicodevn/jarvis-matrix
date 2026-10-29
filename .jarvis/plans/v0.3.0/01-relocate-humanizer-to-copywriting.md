---
task_id: "01"
title: "Relocate humanizer from develop/ to copywriting/"
depends_on: []
parallel_group: wave-1
target_files:
  - ~/.gemini/config/github-plugins/copywriting/humanizer
  - ~/.gemini/config/github-plugins/develop/humanizer
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: low
status: completed
---

# Task 01 — Relocate `humanizer` from `develop/` to `copywriting/`

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Move the existing `humanizer` repository out of `~/.gemini/config/github-plugins/develop/` into the newly established copywriting pillar directory at `~/.gemini/config/github-plugins/copywriting/`.

---

## Context

v0.1.0 and v0.2.0 placed `humanizer` in `develop/`. In v0.3.0, text humanizing and AI trope stripping are grouped under a dedicated **Pillar 3: Copywriting**, sitting alongside `vietnamese-humanizer`. Moving `humanizer` cleanly preserves its `.git` history while establishing the three-pillar filesystem structure.

---

## Acceptance Criteria

1. Target directory `~/.gemini/config/github-plugins/copywriting/` exists.
2. `humanizer` directory is moved to `~/.gemini/config/github-plugins/copywriting/humanizer`.
3. `~/.gemini/config/github-plugins/develop/humanizer` no longer exists.
4. Git remote and branch in `~/.gemini/config/github-plugins/copywriting/humanizer` remain valid (`https://github.com/blader/humanizer`).
5. `SKILL.md` is accessible at `~/.gemini/config/github-plugins/copywriting/humanizer/SKILL.md`.

---

## Implementation Notes

- Execute filesystem move via `mv ~/.gemini/config/github-plugins/develop/humanizer ~/.gemini/config/github-plugins/copywriting/`.
- Verify `.git` and `SKILL.md` existence post-move.

