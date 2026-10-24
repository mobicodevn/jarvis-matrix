---
name: jarvis-project-memory
description: |
  Direct interface to the project-specific PROJECT_MEMORY.md brain.
  Mirror of /jarvis-memory but scoped to the active project.
  Supports display, add, search, blame, and prune sub-commands.
triggers:
  - "/jarvis-project-memory"
  - "/jarvis-project-memory add"
  - "/jarvis-project-memory search"
  - "/jarvis-project-memory blame"
  - "/jarvis-project-memory prune"
reads: [.jarvis/PROJECT_MEMORY.md]
writes: [.jarvis/PROJECT_MEMORY.md]
plugins_invoked: []
compression: none
---

# /jarvis-project-memory — Project Brain Interface

> **Memory Location:** `<project-root>/.jarvis/PROJECT_MEMORY.md`
>
> Cross-linked to: `[[CONTEXT.md]]` | `[[JARVIS_MEMORY.md]]`

## Overview

All operations mirror `/jarvis-memory` but target the active project's `PROJECT_MEMORY.md`. Every entry is tagged with the project name and cross-linked to `CONTEXT.md` via WikiLinks.

## Sub-Commands

### `/jarvis-project-memory` (no args) — Display

```
Project Memory: <project-name>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Last modified: 2026-10-24T13:00:00Z
Active plan: [[.jarvis/plans/auth-refactor/]]

Sections:
  Project Specs Vault          → 2 specs
  Project Rules & Conventions  → 5 rules
  Business Logic Constraints   → 3 constraints
  Active Plan Status           → 7/12 tasks complete
  Project Blame Log            → 1 entry
```

---

### `/jarvis-project-memory add <note>` — Add Entry

Same compression rules as `/jarvis-memory add`:
- Compress to semantic minimum (1 sentence or key:value)
- No hedging language

Determine appropriate section:
- Coding convention for this project → **Project Rules & Conventions**
- Domain rule or invariant → **Business Logic Constraints**
- Project-specific mistake → **Project Blame Log**
- Validated spec → use `/jarvis-spec` instead (not this command)

After adding:
- Update `last_modified` in frontmatter
- Add WikiLink from CONTEXT.md to the new entry if CONTEXT.md exists
- Preserve all existing entries and WikiLinks

---

### `/jarvis-project-memory search <query>` — Search

Full-text search across all sections of PROJECT_MEMORY.md.

Return matches with section name and brief context.

---

### `/jarvis-project-memory blame <description>` — Record Post-Mortem

Record a project-specific correction in the **Project Blame Log**:

```markdown
### 2026-10-24 — <brief title>
- **What went wrong:** concise description
- **Root cause:** one line
- **Correction applied:** what changed
- **Recurrence risk:** high | medium | low
```

If the same type of mistake has appeared in this project 3+ times → also add to `JARVIS_MEMORY.md` Global Blame Log (cross-project pattern).

---

### `/jarvis-project-memory prune` — Review for Removal

Same flow as `/jarvis-memory prune` but scoped to PROJECT_MEMORY.md:
1. Display all entries with indices
2. Identify stale candidates (conflicts, superseded rules, completed plan references)
3. Ask for confirmation per entry
4. Remove confirmed entries, compact file

---

## Cross-Linking Rules

Every write operation MUST:
1. Maintain `linked_context: "[[CONTEXT.md]]"` in frontmatter
2. Maintain `linked_global: "[[~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md]]"` in frontmatter
3. Add WikiLinks for any new cross-references introduced
4. Never break existing `[[...]]` links

## When PROJECT_MEMORY.md Doesn't Exist

If `<project-root>/.jarvis/PROJECT_MEMORY.md` is not found:
1. Ask: "No project memory found. Initialize one for `<project-root>`? (yes/no)"
2. If yes: Copy `templates/PROJECT_MEMORY.template.md` to the location, fill in project name and timestamps
3. Continue with the requested operation

## Verification

- `PROJECT_MEMORY.md` frontmatter `last_modified` updated on every write
- `linked_context` and `linked_global` WikiLinks intact
- No duplicate entries
- All entries compressed to semantic minimum
