---
name: jarvis-memory
description: |
  Direct interface to the global JARVIS_MEMORY.md brain.
  Supports display, add, search, blame, and prune sub-commands.
  All entries are compressed to semantic minimum before storage.
triggers:
  - "/jarvis-memory"
  - "/jarvis-memory add"
  - "/jarvis-memory search"
  - "/jarvis-memory blame"
  - "/jarvis-memory prune"
reads: [JARVIS_MEMORY.md]
writes: [JARVIS_MEMORY.md]
plugins_invoked: []
compression: none
---

# /jarvis-memory — Global Brain Interface

> **Memory Location:** `~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md`

## Sub-Commands

### `/jarvis-memory` (no args) — Display

Show a summary of the global memory:

```
Jarvis Global Memory
━━━━━━━━━━━━━━━━━━━━━━━━━
Last modified: 2026-10-24T13:00:00Z
Linked projects: 3

Sections:
  Global Coding Standards    → 7 rules
  Orchestrator Routing Rules → 4 rules
  User Preferences           → 3 settings
  Plugin Version Log         → 6 plugins
  Global Blame Log           → 2 entries
```

---

### `/jarvis-memory add <note>` — Add Entry

1. Receive the raw note from user
2. Compress to semantic minimum:
   - Remove: "the user mentioned", "generally", "tends to", "during our conversation"
   - Result must be one clean sentence or key:value pair
   
   **Before:** "The user mentioned during a conversation on Tuesday that they generally tend to prefer using TypeScript over JavaScript for backend services"
   **After:** "User prefers TypeScript for all new backend services"

3. Determine the appropriate section:
   - Coding style or language preferences → **Global Coding Standards**
   - Plugin routing or tool usage → **Orchestrator Routing Rules**
   - Personal preferences → **User Preferences**
   - Cross-project bug/mistake → **Global Blame Log**

4. Append to that section
5. Update `last_modified` in frontmatter
6. Preserve all existing entries and WikiLinks

---

### `/jarvis-memory search <query>` — Search

Full-text search across all sections of JARVIS_MEMORY.md.

Return matching entries with section name:
```
Results for "<query>":
  [Global Coding Standards] "User prefers TypeScript for all backend services"
  [Orchestrator Routing Rules] "Route TypeScript type errors to ponytail-review"
```

---

### `/jarvis-memory blame <description>` — Record Post-Mortem

Record a cross-project correction in the **Global Blame Log**:

```markdown
### 2026-10-24 — <brief title>
- **What went wrong:** concise description (1 line)
- **Root cause:** one line
- **Correction applied:** what changed
- **Applies to:** global | [[specific PROJECT_MEMORY.md]]
```

Update `last_modified`. Preserve all existing entries.

---

### `/jarvis-memory prune` — Review for Removal

1. Display all entries across all sections with their index
2. Identify potentially outdated entries:
   - Entries that contradict each other
   - Entries referencing old plugin versions now superseded
   - Rules that conflict with more recent blame entries
3. For each candidate, ask: "Remove this entry? (yes/no)"
   ```
   [5] [User Preferences] "Prefers caveman-lite for all tasks"
       ↳ Possibly superseded by: "default_compression: ponytail-full + caveman"
       Remove? (yes/no)
   ```
4. After confirmations, remove marked entries and compact the file

---

## Compression Rule

Every entry stored via `add` or `blame` is compressed to its semantic minimum:
- Maximum 1 sentence or 1 key:value pair
- Zero hedging language ("usually", "maybe", "tends to")
- Imperative or declarative form only

## Verification

- `JARVIS_MEMORY.md` frontmatter `last_modified` updated on every write
- No duplicate entries
- WikiLinks preserved across all operations
