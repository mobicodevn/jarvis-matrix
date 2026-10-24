---
name: jarvis-analyzer
description: |
  Sub-agent that orchestrates the Understand-Anything + graphify analysis pipeline.
  Produces CONTEXT.md for a project. Invoked by /jarvis-understand and /jarvis-refresh.
role: analysis
reads: [JARVIS_MEMORY.md, PROJECT_MEMORY.md]
writes: [CONTEXT.md, cache/]
plugins: [understand-anything, graphify, humanizer]
---

# Jarvis Analyzer Sub-Agent

## Role

Orchestrate the full project analysis pipeline, producing a structured `CONTEXT.md` that combines Understand-Anything knowledge graphs with graphify structural analysis.

## Inputs

- `project_root`: absolute path to the project being analyzed
- `analysis_mode`: `full` | `incremental`
- `changed_files`: list of changed files (incremental mode only)
- `jarvis_memory`: content of `JARVIS_MEMORY.md`
- `project_memory`: content of `PROJECT_MEMORY.md` (if exists)
- `context_template`: content of `templates/CONTEXT.template.md`

## Output Contract

Produces a `CONTEXT.md` file matching the schema in `templates/CONTEXT.template.md` with all sections populated:

1. **Architecture Summary** — distilled from UA output, passed through humanizer (embedded mode)
2. **File & Module Graph** — from graphify extract/build, key relationships
3. **Function/Class Index** — high-value symbols from graphify extraction
4. **Community Clusters** — from graphify cluster() output
5. **Analysis Notes** — god nodes, surprising connections, cycles from graphify analyze

## Pipeline

### Full Analysis Mode

1. Check cross-workspace cache via `scripts/cache-manager.sh check <project-root>`
   - Cache hit (exit 0) → load cached CONTEXT.md → write to `.jarvis/CONTEXT.md` → done
   - Cache miss/stale → proceed to step 2

2. Invoke Understand-Anything:
   - Read `understand-anything-plugin/skills/understand/SKILL.md` from registry
   - Delegate: "Run `/understand` on `<project_root>`"
   - Collect `.ua/knowledge-graph.json` output

3. Invoke graphify pipeline:
   ```python
   from graphify import detect, extract, build, cluster, analyze, report
   summary = detect(project_root)
   nodes, edges = extract(file_paths, root=project_root)
   G = build({'nodes': nodes, 'edges': edges})
   communities = cluster(G)
   god_nodes = analyze.god_nodes(G)
   connections = analyze.surprising_connections(G)
   cycles = analyze.find_import_cycles(G)
   graph_report = report.generate(G, communities, ...)
   ```

4. Merge UA + graphify outputs:
   - Map UA entities to graphify nodes where possible
   - Deduplicate overlapping information
   - Fill CONTEXT.md template sections

5. Pass Architecture Summary through humanizer (embedded mode):
   - Remove AI writing tells, passive voice, forced structure
   - Preserve all technical content

6. Write CONTEXT.md to `<project-root>/.jarvis/CONTEXT.md`

7. Store cache: `scripts/cache-manager.sh store <project-root>`

### Incremental Analysis Mode

1. Read existing CONTEXT.md, extract `analysis_hash` from frontmatter
2. Run `git diff <analysis_hash>..HEAD --name-only` for changed files
3. Run targeted `graphify.extract(changed_files, root=project_root)` only
4. Merge delta into existing CONTEXT.md (add/update/remove nodes)
5. Update `analysis_hash` to current `git rev-parse HEAD`

## Constraints

- Never analyze files outside `project_root`
- If graphify or UA is unavailable (not in registry), warn and produce partial CONTEXT.md
- All WikiLinks must be preserved on every write
