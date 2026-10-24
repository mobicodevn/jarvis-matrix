---
name: jarvis-refresh
description: |
  Incremental delta update of CONTEXT.md using git diff — no full re-indexing.
  Analyzes only changed files since last analysis and merges results into existing context.
triggers: ["/jarvis-refresh"]
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
writes: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md]
plugins_invoked: [understand-anything, graphify]
compression: ponytail-full
---

# /jarvis-refresh — Incremental Context Update

> **Memory Sync:** Reads all three brain files before executing.

## When to Use

After committing changes that affect a subset of files. Cheaper than `/jarvis-understand` — only re-analyzes what changed.

If no CONTEXT.md exists, this skill will suggest `/jarvis-understand` instead.

## Process

### Step 1 — Memory Sync

Read JARVIS_MEMORY.md and PROJECT_MEMORY.md.

### Step 2 — Load Existing CONTEXT.md

Read `<project-root>/.jarvis/CONTEXT.md`.

If not found:
> "No CONTEXT.md found. Run `/jarvis-understand` to create initial context."
> Stop here.

Extract `analysis_hash` from frontmatter.

### Step 3 — Identify Changed Files

```bash
git -C <project-root> diff <analysis_hash>..HEAD --name-only
```

If no changed files:
> "CONTEXT.md is already up to date (HEAD matches stored hash)."
> Update `last_analyzed` timestamp.
> Stop here.

### Step 4 — Assess Delta Size

Count changed files. Calculate percentage of total project files changed.

If ≥ 30% of files changed:
> "⚠ More than 30% of files changed. A full re-analysis is recommended. Run `/jarvis-understand` for best results. Continue with incremental refresh anyway? (yes/no)"

If user confirms, continue. If no, stop.

### Step 5 — Targeted graphify Analysis

Run graphify extraction on changed files only:

```python
from graphify import extract, build, cluster, analyze
nodes, edges = extract(changed_files, root=project_root)
G_delta = build({'nodes': nodes, 'edges': edges})
```

### Step 6 — Merge Delta Into CONTEXT.md

Update existing CONTEXT.md:
- **New files:** Add their nodes and edges to File & Module Graph
- **Modified files:** Update existing nodes/edges
- **Deleted files:** Remove nodes and their edges
- Recompute community clusters if significant topology changes
- Update Analysis Notes (god_nodes, cycles) if delta affects them

Preserve all other sections and all WikiLinks.

### Step 7 — Update Frontmatter

```yaml
last_analyzed: <current ISO datetime>
analysis_hash: <current git HEAD>
```

### Step 8 — Sync WikiLinks in PROJECT_MEMORY.md

Check PROJECT_MEMORY.md for WikiLinks referencing renamed/moved files. Update stale links. Log any WikiLinks that could not be resolved.

### Step 9 — Report

```
✓ Context refreshed
  Changed files analyzed: <count>
  Nodes added: <count> | Updated: <count> | Removed: <count>
  New HEAD: <hash[:8]>
```

## Verification

- CONTEXT.md `analysis_hash` matches current `git rev-parse HEAD`
- All deleted file nodes removed from graph
- All new file nodes present
- PROJECT_MEMORY.md WikiLinks still resolve
