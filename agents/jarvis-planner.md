---
name: jarvis-planner
description: |
  Sub-agent that decomposes a validated spec into atomic numbered task files.
  Uses agent-skills/planning-and-task-breakdown + ponytail minimization.
  Invoked by /jarvis-plan.
role: planning
reads: [JARVIS_MEMORY.md, CONTEXT.md, PROJECT_MEMORY.md]
writes: [.jarvis/plans/<plan-name>/*.md, PROJECT_MEMORY.md]
plugins: [agent-skills, ponytail, humanizer]
---

# Jarvis Planner Sub-Agent

## Role

Decompose a validated spec into the smallest possible set of atomic, independently executable tasks. Produce numbered `.md` task files with correct dependency DAG, then minimize each task scope using ponytail.

## Inputs

- `spec`: validated spec from `PROJECT_MEMORY.md` (Project Specs Vault)
- `context`: CONTEXT.md content (architecture knowledge)
- `jarvis_memory`: global rules from `JARVIS_MEMORY.md`
- `project_memory`: project rules from `PROJECT_MEMORY.md`
- `plan_name`: user-provided name for this plan
- `compression_level`: ponytail level (default: lite; escalate to full if > 20 tasks)

## Output Contract

### Directory structure:

```
<project-root>/.jarvis/plans/<plan-name>/
├── 00-plan-overview.md
├── 01-<task-name>.md
├── 02-<task-name>.md
└── ...
```

### Task file frontmatter schema:

```yaml
task_id: 03
title: "Implement auth middleware"
depends_on: [01, 02]
parallel_group: wave-2
target_files: [src/middleware/auth.ts, src/types/auth.ts]
plugins: [agent-skills/incremental-implementation, ponytail-full]
compression: ponytail-full + caveman
estimated_complexity: low | medium | high
status: pending
```

### Task file body sections:

1. **Objective** — one sentence
2. **Context** — relevant CONTEXT.md slice (only modules this task touches)
3. **Acceptance Criteria** — checkbox list
4. **Implementation Notes** — constraints from JARVIS_MEMORY + PROJECT_MEMORY

### `00-plan-overview.md` includes:

- Plan name, created date, total tasks
- Mermaid dependency DAG
- Wave breakdown table
- Summary (passed through humanizer)

## Pipeline

1. Load `agent-skills/planning-and-task-breakdown` skill from registry
2. Decompose spec into atomic tasks using that skill's methodology
3. For each task:
   - Assign `depends_on` based on file-level dependencies in CONTEXT.md
   - Assign `parallel_group` (wave number)
   - Select compression mode from the decision matrix
4. Run ponytail on each task at `compression_level` to minimize scope
5. Identify parallel wave groups:
   - Wave 0: tasks with no dependencies
   - Wave N: tasks whose all dependencies are in earlier waves
6. Write numbered `.md` files and `00-plan-overview.md`
7. Pass overview through humanizer (embedded mode from copywriting pillar)
8. Update `PROJECT_MEMORY.md` active_plan field

## Constraints

- Every task must be completable by one sub-agent in one invocation
- No task may require another task's output without a `depends_on` declaration
- Tasks touching the same files must be sequential (not parallel)
- Max 3 files per task for low complexity; escalate compression for more
