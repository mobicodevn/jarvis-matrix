---
type: jarvis-global-memory
version: 2
created: "2026-10-24T13:42:30Z"
last_modified: "2026-10-25T09:44:00Z"
linked_projects: []
tags: [global, orchestrator, rules, v0.2.0]
---

# Jarvis Global Memory

> Cross-project knowledge for the Jarvis-Matrix orchestrator.
> This file is managed by `/jarvis-memory` and read by every `/jarvis-*` command.

## Global Coding Standards

- Always enforce 10-point Anti-Slop checklist on UI/UX work (no generic 3-card columns, stock gradients, emoji functional icons).
- Motion frequency gate: UI elements interacted with 100+ times/day receive NO animation. Standard animations capped at 350ms with custom cubic-bezier curves.
- Performance budget: animate only `transform` and `opacity`; never layout properties (`width`, `height`, `margin`).
- Always include `@media (prefers-reduced-motion: reduce)` fallbacks.
- Strictly adhere to semantic token architectures (`--color-ground`, `--color-surface`, `--color-ink`, `--color-accent`, `--color-border`).

## Orchestrator Routing Rules

- Mandatory 4-Repo Ensemble Rule: all UI/UX requests evaluate `impeccable`, `skills`, `taste-skill`, and `ui-ux-pro-max-skill`.
- Strict "design" Keyword Naming Rule: all design sub-agents must contain "design" (`jarvis-design-...`).
- Zero-Bloat Context Isolation: sub-agents load only their assigned single SKILL.md slice.
- Lazy-loading protocol: consult `config/registry.json` before injecting skills.

## User Preferences

- default_compression: ponytail-full + caveman
- default_planning_depth: atomic
- default_design_quality: impeccable
- preferred_ide: antigravity

## Plugin Version Log

| Pillar | Plugin | Version | Last Synced |
|--------|--------|---------|-------------|
| develop | Understand-Anything | 2.9.7 | 2026-10-24 |
| develop | graphify | 0.9.95 | 2026-10-24 |
| develop | humanizer | 3.1.0 | 2026-10-24 |
| develop | ponytail | 5.3.2 | 2026-10-24 |
| develop | caveman | 4.0.1 | 2026-10-24 |
| develop | agent-skills | 0.6.13 | 2026-10-24 |
| design | impeccable | 1.0.0 | 2026-10-25 |
| design | skills (emilkowalski) | 1.0.0 | 2026-10-25 |
| design | taste-skill | 1.0.0 | 2026-10-25 |
| design | ui-ux-pro-max-skill | 1.0.0 | 2026-10-25 |

## Global Blame / Post-Mortem Log

<!-- Cross-project corrections and lessons learned. -->
<!-- Format:
### YYYY-MM-DD — Brief title
- **What went wrong:** concise description
- **Root cause:** one line
- **Correction applied:** what changed
- **Applies to:** global | [[PROJECT_MEMORY.md]]
-->
