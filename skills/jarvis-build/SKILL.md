---
name: jarvis-build
description: |
  Multi-agent implementation pipeline executing plan tasks in parallel/sequential waves.
  Supports start and stop sub-commands with graceful checkpointing and resume support.
triggers:
  - "/jarvis-build start"
  - "/jarvis-build stop"
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md, .jarvis/plans/*]
writes: [.jarvis/plans/*.md, .jarvis/PROJECT_MEMORY.md, target source files]
plugins_invoked: [agent-skills, ponytail, caveman]
compression: ponytail-full + caveman (escalates per task complexity)
---

# /jarvis-build — Multi-Agent Implementation

> **Memory Sync:** Reads all three brain files before executing.

## Sub-Commands

---

## `/jarvis-build start`

### Step 1 — Memory Sync & Pre-flight

Read JARVIS_MEMORY.md, PROJECT_MEMORY.md, CONTEXT.md.

**CONTEXT.md check:**
- If `CONTEXT.md` does not exist:
  > "CONTEXT.md not found. Run `/jarvis-understand` first for full project awareness, or continue without project context? (understand first / continue anyway)"
- If stale (analysis_hash ≠ HEAD):
  > "⚠ CONTEXT.md is stale. Consider `/jarvis-refresh` before building. Continue anyway? (yes/no)"

### Step 2 — Load Active Plan

Read `active_plan` from PROJECT_MEMORY.md. Load the plan directory.

If no active plan:
> "No active plan found. Run `/jarvis-plan` to create a plan first."
> Stop.

### Step 3 — Resume Detection

Scan all task files for `status: completed` or `status: checkpoint`.

- **Completed tasks:** Skip (do not re-run)
- **Checkpoint tasks:** Load checkpoint data, re-run from checkpoint
- **Pending tasks:** Queue for execution

Report:
```
Plan: <name>
  Completed: 3/12 tasks (resuming)
  Checkpointed: 1 task (Task 04 — 50%)
  Pending: 8 tasks
```

### Step 4 — Build Wave Groups

Parse `depends_on` fields across all non-completed task files.

Algorithm:
1. Wave 0: all tasks with `depends_on: []`
2. Wave N: tasks whose every dependency is in a completed or earlier wave

### Step 5 — Dispatch Compression Assignment

Invoke `jarvis-compressor` sub-agent for pending tasks. Get ponytail/caveman config per task.

### Step 6 — Execute Waves

For each wave:
1. Dispatch all tasks **in parallel** via `jarvis-builder` sub-agents
2. Each builder receives:
   - Its atomic task file
   - Relevant CONTEXT.md slice (only modules the task touches, not full file)
   - Rules from both memory files
   - Loaded skill paths from registry
   - Assigned compression config
3. Wait for all tasks in wave to complete before starting next wave

### Step 7 — Update Status

As each task completes:
- Update task frontmatter: `status: completed`
- Update PROJECT_MEMORY.md "Active Plan Status":
  ```
  Tasks complete: X/N
  Last checkpoint: <datetime>
  ```

### Step 8 — Final Report

```
✓ Build complete: <plan-name>
  Tasks completed: 12/12
  Time: ~<estimate>

Review changes: /jarvis-review
```

---

## `/jarvis-build stop`

### Step 1 — Signal Halt

Signal all active `jarvis-builder` sub-agents to checkpoint gracefully.

Each builder saves its partial work and reports checkpoint state.

### Step 2 — Record Progress

Update PROJECT_MEMORY.md:
```yaml
active_plan: "[[...]]"
tasks_complete: X
last_checkpoint: <ISO datetime>
in_progress_tasks: [04, 09]
```

Update in-progress task files:
```yaml
status: checkpoint
checkpoint_data: "<brief description of partial work>"
```

### Step 3 — Report

```
Build stopped. Progress: 7/12 tasks complete.

In-progress (checkpointed):
  • Task 08 — auth middleware (50% — types written, middleware not implemented)
  • Task 09 — unit tests (25% — test file created, no assertions yet)

Remaining: Tasks 10, 11, 12

Resume with: /jarvis-build start
```

---

## Resume Protocol

`/jarvis-build start` after `/jarvis-build stop`:
1. Detects tasks with `status: checkpoint`
2. Loads `checkpoint_data` from task frontmatter
3. Continues each task from its checkpoint, not from scratch
4. Detects `status: completed` tasks and skips them

---

## Verification

- All task files end with `status: completed` after a full build
- PROJECT_MEMORY.md reflects final task count
- No task executed out of dependency order
- Each task's `target_files` constraint was respected (no scope creep)
