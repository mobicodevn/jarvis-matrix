---
name: jarvis-context
description: |
  Instantly loads project context, architecture knowledge, and linked memory into the
  active session — without re-running analysis. Use after /jarvis-understand has been run.
triggers: ["/jarvis-context"]
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
writes: []
plugins_invoked: []
compression: none
---

# /jarvis-context — Load Project Context

> **Memory Sync:** Reads all three brain files and injects them into the active session.

## When to Use

Run at the start of any session where you want Jarvis to have full project awareness. Does not re-analyze the project — it simply loads what was already captured by `/jarvis-understand`.

If CONTEXT.md doesn't exist yet, run `/jarvis-understand` first.

## Process

### Step 1 — Locate CONTEXT.md

Look for `<project-root>/.jarvis/CONTEXT.md`.

If not found:
> "CONTEXT.md not found for this project. Run `/jarvis-understand` first to analyze the project architecture, then come back to `/jarvis-context`."
>
> Stop here.

### Step 2 — Read CONTEXT.md

Load the full CONTEXT.md content. Note the frontmatter fields:
- `project`, `project_root`, `last_analyzed`, `analysis_hash`
- `linked_memory.global` → path to JARVIS_MEMORY.md
- `linked_memory.project` → path to PROJECT_MEMORY.md

### Step 3 — Resolve WikiLinks

Resolve all `[[...]]` WikiLinks found in CONTEXT.md:

| WikiLink | Resolution |
|----------|-----------|
| `[[PROJECT_MEMORY.md]]` | Load `<project-root>/.jarvis/PROJECT_MEMORY.md` |
| `[[JARVIS_MEMORY.md]]` | Load `~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md` |
| Any other `[[...]]` | Attempt to resolve relative to `.jarvis/` or plugin root |

If a linked file doesn't exist: note it as missing, continue (don't halt).

### Step 4 — Inject Into Session

Set all three files as active session knowledge:
1. **JARVIS_MEMORY.md** — global coding standards, routing rules, user preferences
2. **PROJECT_MEMORY.md** — project rules, business logic, active plan status, blame log
3. **CONTEXT.md** — architecture summary, module graph, symbol index, clusters

All subsequent actions in this session should be informed by this context.

### Step 5 — Report

Display a brief status:
```
✓ Context loaded for: <project-name>
  Last analyzed: <last_analyzed>
  Modules: <count> | Clusters: <count>
  Active plan: <active_plan or "none">
  Global rules: <N entries> | Project rules: <M entries>
```

## Context Staleness Warning

If `analysis_hash` in CONTEXT.md does not match current `git rev-parse HEAD`:
> "⚠ Context is stale (analyzed at <hash[:8]>, current HEAD is <head[:8]>). Consider running `/jarvis-refresh` for an incremental update."

Display this warning but still load the (potentially stale) context.

## Verification

- All three brain files loaded into session
- WikiLinks resolved
- Staleness check performed and reported
