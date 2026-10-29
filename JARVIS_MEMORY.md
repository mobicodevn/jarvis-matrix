---
type: jarvis-global-memory
version: 3
created: "2026-10-24T13:42:30Z"
last_modified: "2026-10-29T09:17:00Z"
linked_projects: []
tags: [global, orchestrator, rules, v0.3.0, three-pillars]
---

# Jarvis Global Memory

> Cross-project knowledge for the Jarvis-Matrix orchestrator.
> This file is managed by `/jarvis-memory` and read by every `/jarvis-*` command.

## Global Coding & Design Standards

- Always enforce 10-point Anti-Slop checklist on UI/UX work (no generic 3-card columns, stock gradients, emoji functional icons).
- Motion frequency gate: UI elements interacted with 100+ times/day receive NO animation. Standard animations capped at 350ms with custom cubic-bezier curves.
- Performance budget: animate only `transform` and `opacity`; never layout properties (`width`, `height`, `margin`).
- Always include `@media (prefers-reduced-motion: reduce)` fallbacks.
- Strictly adhere to semantic token architectures (`--color-ground`, `--color-surface`, `--color-ink`, `--color-accent`, `--color-border`).

## Global Copywriting & Humanizer Standards

- Never produce synthetic or robotic text; eliminate staging sentences, forced triads, dash spam, and moralizing paragraph closers.
- For Vietnamese prose, strip translationese (excessive passive voice "được/bị", nominalization "việc/tiến hành/thực hiện", and generic intensifiers).
- Strictly preserve all factual claims, technical symbols, code snippets, numbers, and constraints during rewriting passes.

## Orchestrator Routing Rules

- Three-Pillar Architecture: `develop/` (engineering), `design/` (UI/UX, motion, branding), and `copywriting/` (language humanizers).
- Design Ensemble Evaluation: evaluate perspectives across `impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`, `hyperframes`, and `logo-design-skill`.
- Master Copywriting Router `jarvis-writer`: automatically detects language (Vietnamese vs English) and routes to `/jarvis-writer-vi` or `/jarvis-writer-en`.
- Strict "design" Keyword Naming Rule: all design sub-agents must contain "design" (`jarvis-design-...`).
- Zero-Bloat Context Isolation: sub-agents load only their assigned single SKILL.md slice.
- Lazy-loading protocol: consult `config/registry.json` before injecting skills.

## User Preferences

- default_compression: ponytail-full + caveman
- default_planning_depth: atomic
- default_design_quality: impeccable
- default_writing_quality: humanized
- preferred_ide: antigravity

## Plugin Version Log

| Pillar | Plugin | Version | Last Synced |
|--------|--------|---------|-------------|
| develop | Understand-Anything | 2.9.8 | 2026-10-29 |
| develop | graphify | 0.9.95 | 2026-10-29 |
| develop | ponytail | 5.3.2 | 2026-10-29 |
| develop | caveman | 4.0.1 | 2026-10-29 |
| develop | agent-skills | 0.6.13 | 2026-10-29 |
| design | impeccable | 4.8.0 | 2026-10-29 |
| design | skills (emilkowalski) | 1.0.0 | 2026-10-29 |
| design | taste-skill | 1.0.0 | 2026-10-29 |
| design | ui-ux-pro-max-skill | 1.0.0 | 2026-10-29 |
| design | hyperframes | 1.0.0 | 2026-10-29 |
| design | logo-design-skill | 1.4.5 | 2026-10-29 |
| copywriting | humanizer | 3.1.0 | 2026-10-29 |
| copywriting | vietnamese-humanizer | 0.4.6 | 2026-10-29 |

## Global Blame / Post-Mortem Log

<!-- Cross-project corrections and lessons learned. -->
<!-- Format:
### YYYY-MM-DD — Brief title
- **What went wrong:** concise description
- **Root cause:** one line
- **Correction applied:** what changed
- **Applies to:** global | [[PROJECT_MEMORY.md]]
-->
