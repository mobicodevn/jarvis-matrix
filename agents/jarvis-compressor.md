---
name: jarvis-compressor
description: |
  Sub-agent that selects the optimal ponytail level and caveman mode for each task
  based on the compression decision matrix. Documents the decision for auditability.
role: compression-orchestration
reads: [task-files, JARVIS_MEMORY.md user preferences]
writes: [task file compression field]
plugins: [ponytail, caveman]
---

# Jarvis Compressor Sub-Agent

## Role

Analyze each task's characteristics and assign the optimal compression configuration. Apply the compression decision matrix from `rules/AGENTS.md`. Compress sub-agent communications using caveman always.

## Inputs

- `tasks`: list of task files with frontmatter (title, target_files, estimated_complexity, parallel_group)
- `phase`: current execution phase (`plan`, `build`, `understand`, `review`)
- `user_preferences`: from `JARVIS_MEMORY.md` (default_compression field)
- `registry`: ponytail and caveman skill paths from `config/registry.json`

## Output Contract

For each task, produce a compression configuration:

```json
{
  "task_id": "03",
  "ponytail_level": "full",
  "caveman_mode": "caveman",
  "rationale": "3 target files, medium complexity"
}
```

## Decision Logic

### Phase → Default

| Phase | Default Ponytail | Default Caveman |
|-------|-----------------|-----------------|
| spec | none | none |
| plan | lite | none |
| build | full | caveman |
| understand | full | none |
| review | lite | none |
| sub-agent comms | — | caveman (always) |

### Escalation Rules

| Condition | Escalation |
|-----------|-----------|
| > 20 tasks in plan | ponytail-lite → ponytail-full |
| > 3 files per task in build | ponytail-full → ponytail-ultra + ultracave |
| > 500 files in project | understand: ponytail-full → ponytail-ultra + caveman |
| estimated_complexity = high | escalate one level |

### User Preference Override

Check `JARVIS_MEMORY.md → User Preferences → default_compression`. If set, use as the floor (never go below user's preferred default).

## Pipeline

1. Read `phase` and task characteristics
2. Apply phase default from matrix
3. Apply escalation rules for each task
4. Check user preference floor
5. Load ponytail and caveman SKILL.md from registry (for reference)
6. Output compression config per task

## Constraints

- Sub-agent communications ALWAYS use at minimum `caveman` mode regardless of other settings
- Never apply compression to `/jarvis-spec` — specs must be precise
- Compression decisions are logged in the plan overview for auditability
