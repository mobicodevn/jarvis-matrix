---
name: jarvis-plan
description: |
  Multi-agent planning pipeline that decomposes a validated spec into atomic numbered
  task files with dependency DAG, compression assignments, and wave groupings.
triggers: ["/jarvis-plan"]
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
writes: [.jarvis/plans/<plan-name>/*.md, .jarvis/PROJECT_MEMORY.md]
plugins_invoked: [agent-skills, ponytail, caveman, humanizer]
compression: ponytail-lite (escalates to ponytail-full if > 20 tasks)
---

# /jarvis-plan — Multi-Agent Planning Pipeline

> **Memory Sync:** Reads all three brain files before executing.

## When to Use

After `/jarvis-spec` has produced a validated spec. Do not plan without a spec — you will be asked to run `/jarvis-spec` first.

## Process

### Step 1 — Memory Sync

Load all three brain files. Extract:
- Active spec from `PROJECT_MEMORY.md` → Project Specs Vault
- Architecture from `CONTEXT.md`
- Global rules from `JARVIS_MEMORY.md`

If no validated spec found in PROJECT_MEMORY.md:
> "No spec found. Run `/jarvis-spec` first to define and validate requirements."
> Stop here.

### Step 2 — Name the Plan

Ask: "What should this plan be called? (used as directory name)"

Suggestion: slugified version of the spec title.

### Step 3 — Select Compression Level

Check JARVIS_MEMORY.md user preferences for `default_planning_depth`.

Default: ponytail-lite. Escalate to ponytail-full if estimated task count > 20.

### Step 4 — Dispatch Planning Pipeline (3 agents)

**Invoke `jarvis-planner` sub-agent** which internally runs:

**Agent 1 — Decompose** (`agent-skills/planning-and-task-breakdown`):
- Break spec into smallest atomic tasks
- Each task: one logical unit, completable by one sub-agent
- Assign target files from CONTEXT.md module graph

**Agent 2 — Minimize** (`ponytail` at selected level):
- For each task: confirm it's the smallest possible scope
- Merge tasks that touch identical files
- Remove tasks that are implied by others

**Agent 3 — Structure** (dependency review):
- Assign `depends_on` based on file-level dependencies in CONTEXT.md
- Identify parallel wave groups
- Flag tasks > 3 target files for compression escalation

### Step 5 — Dispatch Compression Assignment

Invoke `jarvis-compressor` sub-agent to assign ponytail/caveman per task.

### Step 6 — Generate Task Files

Write to `<project-root>/.jarvis/plans/<plan-name>/`:

**Numbered task files:**
```yaml
# frontmatter
task_id: 03
title: "Implement auth middleware"
depends_on: [01, 02]
parallel_group: wave-2
target_files:
  - src/middleware/auth.ts
  - src/types/auth.ts
plugins:
  - agent-skills/incremental-implementation
  - ponytail-full
compression: ponytail-full + caveman
estimated_complexity: medium
status: pending
```

**Body sections:**
- **Objective** — one sentence
- **Context** — relevant CONTEXT.md slice (only modules this task touches)
- **Acceptance Criteria** — from spec, scoped to this task
- **Implementation Notes** — constraints from JARVIS_MEMORY + PROJECT_MEMORY

### Step 7 — Generate Plan Overview

Write `00-plan-overview.md`:

```markdown
# Plan: <name>
Created: <date> | Tasks: <N> | Estimated waves: <W>

## Dependency DAG
[mermaid diagram of depends_on relationships]

## Wave Breakdown
| Wave | Tasks | Parallel? |
|------|-------|-----------|
| 0    | 01, 02, 03 | ✅ |
| 1    | 04, 05 | ✅ |
| 2    | 06 | ❌ |

## Compression Summary
[table: task_id → ponytail level → caveman mode → rationale]
```

Pass overview through humanizer (embedded mode).

### Step 8 — Update PROJECT_MEMORY.md

```yaml
active_plan: "[[.jarvis/plans/<plan-name>/00-plan-overview.md]]"
```

### Step 9 — Report

```
✓ Plan created: <plan-name>
  Tasks: <N> across <W> waves
  Parallelizable: <X> tasks | Sequential: <Y> tasks
  Location: .jarvis/plans/<plan-name>/

Next: /jarvis-build start
```

## Verification

- `00-plan-overview.md` exists with mermaid DAG
- All task files have valid frontmatter with `task_id`, `depends_on`, `parallel_group`, `status: pending`
- Dependency DAG is acyclic (no circular dependencies)
- `PROJECT_MEMORY.md` active_plan updated
