---
task_id: "11"
title: "Wire hyperframes and logo-design-skill into /jarvis-design & Sub-agents"
depends_on: ["06"]
parallel_group: wave-4
target_files:
  - skills/jarvis-design/SKILL.md
  - agents/jarvis-designer.md
  - agents/jarvis-design-motion-engineer.md
  - agents/jarvis-design-taste-director.md
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-full
estimated_complexity: medium
status: completed
---

# Task 11 — Wire `hyperframes` and `logo-design-skill` into `/jarvis-design` & Sub-agents

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Expand `/jarvis-design` and its specialized design sub-agents to integrate `hyperframes` (motion/captions/changelog videos) and `logo-design-skill` (vector logos, mark crafting, brand assets), enabling both 1-call autonomous selection and direct sub-skill invocation.

---

## Context

v0.2.0 routed design tasks across 4 core repositories. v0.3.0 expands the design fleet to 6 repositories by adding:
1. **`hyperframes`** (`heygen-com/hyperframes`): frame composition, animated video changelogs, and captions overlays. Integrated into `jarvis-design-motion-engineer`.
2. **`logo-design-skill`** (`kaankiziltug/logo-design-skill`): SVG geometry, mark design, typography lockups, and favicon generation. Integrated into `jarvis-design-taste-director` and `jarvis-designer`.

---

## Acceptance Criteria

1. `skills/jarvis-design/SKILL.md`:
   - Update frontmatter `plugins_invoked` to include `hyperframes` and `logo-design-skill`.
   - Update Core Routing Rules: expand ensemble evaluation to include `hyperframes` for video/frame motion and `logo-design-skill` for brand/vector marks.
   - Update Mode 2 (Direct Sub-Skill Invocation) examples:
     - `/jarvis-design --skill logo-design`
     - `/jarvis-design --skill captions-overlay`
     - `/jarvis-design --skill changelog-video`
2. `agents/jarvis-design-motion-engineer.md`:
   - Add references to `hyperframes` skills for video frame architecture and captions alongside `emilkowalski/skills`.
3. `agents/jarvis-design-taste-director.md`:
   - Add references to `logo-design-skill` for vector icon crafting, visual identity lockups, and mark generation.
4. `agents/jarvis-designer.md`:
   - Document routing to `hyperframes` and `logo-design-skill` within the pipeline dispatch phases.
5. All references maintain Zero-Bloat Context Isolation (only assigned skill slices loaded dynamically).

---

## Implementation Notes

- Respect the Strict "design" Keyword Naming Rule for any design sub-agents.
- Ensure bidirectional WikiLink preservation across all updated agent definitions.

