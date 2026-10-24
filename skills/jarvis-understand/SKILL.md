---
name: jarvis-understand
description: |
  Deep project analysis combining Understand-Anything and graphify.
  Builds a cross-tool knowledge graph and stores the distilled result in CONTEXT.md.
  Supports cross-workspace caching to avoid re-analysis on unchanged projects.
triggers: ["/jarvis-understand"]
reads: [JARVIS_MEMORY.md, PROJECT_MEMORY.md]
writes: [.jarvis/CONTEXT.md, cache/]
plugins_invoked: [understand-anything, graphify, humanizer]
compression: ponytail-full (escalates to ponytail-ultra + caveman for > 500 files)
---

# /jarvis-understand — Deep Project Analysis

> **Memory Sync:** Reads JARVIS_MEMORY.md + PROJECT_MEMORY.md before every run.

## When to Use

Run once after cloning a project, or when major structural changes have been made. For incremental updates after smaller changes, use `/jarvis-refresh` instead.

## Process

### Step 1 — Memory Sync

Read the following files before proceeding:
1. `~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md` — global rules, user preferences
2. `<project-root>/.jarvis/PROJECT_MEMORY.md` — project conventions (if exists)

### Step 2 — Cache Check

Invoke `scripts/cache-manager.sh check <project-root>`:
- **Exit 0 (cache hit):** Load cached CONTEXT.md → write to `.jarvis/CONTEXT.md` → skip to Step 8
- **Exit 1 (miss/stale):** Continue to Step 3

### Step 3 — Estimate Analysis Scale

Run `git ls-files | wc -l` (or equivalent file count). If > 500 files, escalate compression to `ponytail-ultra + caveman`.

### Step 4 — Understand-Anything Analysis

Load the Understand-Anything skill from registry:
```
registry["understand-anything"]["skills"][0]["path"]  →  understand-anything-plugin/skills/understand/SKILL.md
```

Read that SKILL.md and delegate: "Run the `/understand` skill on `<project_root>`."

Collect output from `.ua/knowledge-graph.json`.

### Step 5 — graphify Pipeline

Invoke the graphify pipeline against the project:

```python
# Steps to run via graphify
detect(project_root)           # → scan summary
extract(file_paths, root=...)  # → {nodes, edges}
build(extractions)             # → NetworkX graph G
cluster(G)                     # → community groupings
analyze.god_nodes(G)           # → highly-connected nodes
analyze.surprising_connections(G)
analyze.find_import_cycles(G)
report.generate(G, communities, ...)  # → GRAPH_REPORT.md
```

### Step 6 — Merge & Distill

Combine Understand-Anything and graphify outputs:
- Architecture Summary: UA overview prose
- File & Module Graph: graphify extract/build relationships
- Function/Class Index: graphify high-value symbol list
- Community Clusters: graphify cluster groupings
- Analysis Notes: graphify god_nodes + cycles + surprising connections

Fill `templates/CONTEXT.template.md` with the merged content.

### Step 7 — Humanizer Pass

Pass the **Architecture Summary** section through `humanizer` in **embedded mode**:
- Load `humanizer/SKILL.md` from registry
- Remove AI writing tells: passive voice, forced triads, staged openers
- Preserve all technical content

### Step 8 — Write CONTEXT.md

Write the completed CONTEXT.md to `<project-root>/.jarvis/CONTEXT.md`.

Insert WikiLinks:
- `[[PROJECT_MEMORY.md]]` in the frontmatter `linked_memory.project` field
- `[[~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md]]` in `linked_memory.global`

### Step 9 — Update Cache

Invoke `scripts/cache-manager.sh store <project-root>` to cache the result.

### Step 10 — Report

Display summary:
```
✓ Project analysis complete
  Project: <name>
  Files analyzed: <count>
  Modules detected: <count>
  Clusters: <count>
  Cache: stored (key: <short-hash>)

Next steps:
  • /jarvis-context — Load context into current session
  • /jarvis-spec — Define a requirement to implement
```

## Error Handling

| Condition | Response |
|-----------|----------|
| Understand-Anything not in registry | Warn, skip UA step, continue with graphify only |
| graphify not in registry | Warn, skip graphify, produce partial CONTEXT.md from UA |
| Both missing | Warn, halt: "Run /jarvis-setup to configure plugins" |
| No git repo | Disable cache, proceed with full analysis |
| `.jarvis/` dir missing | Create it automatically |

## Verification

- `<project-root>/.jarvis/CONTEXT.md` exists with all sections populated
- Frontmatter contains `analysis_hash` (git HEAD) and `cache_key`
- WikiLinks to PROJECT_MEMORY.md and JARVIS_MEMORY.md present
- Cache entry exists at `~/.gemini/config/plugins/jarvis-matrix/cache/<key>/`
