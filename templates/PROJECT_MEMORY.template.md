---
type: jarvis-project-memory
version: 1
project: "{{project_name}}"
project_root: "{{project_root}}"
created: "{{created_at}}"
last_modified: "{{last_modified}}"
linked_context: "[[CONTEXT.md]]"
linked_global: "[[~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md]]"
active_plan: null
tags: [project, memory, rules]
---

# Project Memory: {{project_name}}

> Project-scoped knowledge for the Jarvis-Matrix orchestrator.
> Links: [[CONTEXT.md]] | [[JARVIS_MEMORY.md]]
> Managed by `/jarvis-project-memory`. Read by every `/jarvis-*` command operating in this project.

## Project Specs Vault

<!-- Validated specs from /jarvis-spec. Format:
### Spec: <title> (confidence: XX%)
**Created:** YYYY-MM-DD
**Requirement:** one-sentence summary
**Acceptance Criteria:**
- [ ] criterion 1
- [ ] criterion 2
**Scope boundaries:** what is IN and what is OUT
**Technical constraints:** from CONTEXT.md
**Domain rules:** from this file
-->

## Project Rules & Conventions

<!-- Domain-specific rules and architectural constraints for this project. One line per rule. -->

## Business Logic Constraints

<!-- Rules that must never be violated — domain invariants, compliance requirements, data contracts. -->

## Active Plan Status

<!-- Updated by /jarvis-plan and /jarvis-build -->

- **Active plan:** {{active_plan_link}}
- **Tasks complete:** {{completed}}/{{total}}
- **Last checkpoint:** {{checkpoint_datetime}}
- **In-progress tasks:** {{in_progress_tasks}}

## Project Blame / Post-Mortem Log

<!-- Project-specific corrections. Format:
### YYYY-MM-DD — Brief title
- **What went wrong:** concise description
- **Root cause:** one line
- **Correction applied:** what changed
- **Recurrence risk:** high | medium | low
-->
