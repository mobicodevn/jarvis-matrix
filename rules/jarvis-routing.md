# Jarvis-Matrix — Detailed Routing Decision Tree

> Supplement to `rules/AGENTS.md`. Contains the full routing logic for mapping user intent to plugin invocations.

---

## Routing Decision Tree

```
User invokes /jarvis-* command
│
├── Step 1: Memory Sync
│   ├── Read JARVIS_MEMORY.md (always)
│   └── Read PROJECT_MEMORY.md (if exists)
│
├── Step 2: Registry Check
│   ├── registry.json exists? → continue
│   └── Missing → warn + halt ("Run /jarvis-setup")
│
├── Step 3: Identify Required Plugins
│   └── Consult registry.json for skill paths
│
├── Step 4: Load Only Required Skills
│   └── Read exact SKILL.md files → inject into context
│
└── Step 5: Execute Skill
    └── Dispatch sub-agents if needed
```

---

## Plugin Routing Reference

### Understand-Anything

- **Registry key:** `understand-anything`
- **Primary skill:** `understand-anything-plugin/skills/understand/SKILL.md`
- **Output:** `.ua/knowledge-graph.json` (in project root)
- **Invocation:** Read skill, delegate full project scan
- **Used by:** `/jarvis-understand`, `/jarvis-refresh`

### graphify

- **Registry key:** `graphify`
- **Type:** Python library (not a skill file — invoke as pipeline)
- **Pipeline steps:** detect → extract → build → cluster → analyze → report → export
- **Output:** `graphify-out/graph.json`, `GRAPH_REPORT.md`
- **Used by:** `/jarvis-understand`, `/jarvis-refresh`

### humanizer

- **Registry key:** `humanizer`
- **Skill path:** `humanizer/SKILL.md`
- **Invocation mode:** embedded (pass text, get back clean prose)
- **Used by:** `/jarvis-understand` (summaries), `/jarvis-plan` (overview), `/jarvis-review` (report)

### ponytail

- **Registry key:** `ponytail`
- **Levels:**
  - `lite` — Remove unnecessary words, minimal scope reduction
  - `full` — Aggressively scope-minimize each task (default for builds)
  - `ultra` — Maximum compression, smallest possible change
- **Used by:** `/jarvis-plan`, `/jarvis-build`, `/jarvis-understand`

### caveman

- **Registry key:** `caveman`
- **Modes:**
  - `caveman` — Basic compression for sub-agent communications
  - `ultracave` — Heavy compression for large context windows
  - `megacave` — Maximum; strip all prose to minimal tokens
- **Agents:** `cavecrew-investigator`, `cavecrew-builder`, `cavecrew-reviewer`
- **Used by:** `/jarvis-build` (sub-agent comms), `/jarvis-understand` (large projects)

### agent-skills

- **Registry key:** `agent-skills`
- **Key skills for Jarvis routing:**
  - `spec-driven-development` — Spec interview flow
  - `interview-me` — Clarification question batching
  - `planning-and-task-breakdown` — Atomic task decomposition
  - `incremental-implementation` — Single-task implementation
  - `code-review-and-quality` — Code review workflow
- **Agents:**
  - `code-reviewer.md` — Code quality review
  - `security-auditor.md` — Security vulnerability scan
  - `test-engineer.md` — Test coverage review
  - `web-performance-auditor.md` — Performance analysis
- **Used by:** `/jarvis-spec`, `/jarvis-plan`, `/jarvis-build`, `/jarvis-review`

---

## Memory Read/Write Matrix

| Skill | JARVIS_MEMORY | CONTEXT | PROJECT_MEMORY |
|-------|:---:|:---:|:---:|
| `/jarvis-setup` | **W** (init) | — | — |
| `/jarvis-understand` | R | **W** (create) | R |
| `/jarvis-context` | **R** | **R** | **R** |
| `/jarvis-update` | **RW** (versions) | — | — |
| `/jarvis-refresh` | R | **RW** (delta) | **RW** (links) |
| `/jarvis-spec` | **R** | **R** | **RW** (spec) |
| `/jarvis-plan` | **R** | **R** | **RW** (plan) |
| `/jarvis-build` | **R** | **R** | **RW** (status) |
| `/jarvis-review` | **RW** (findings) | **R** | **RW** (blame) |
| `/jarvis-memory` | **RW** (direct) | — | — |
| `/jarvis-project-memory` | — | — | **RW** (direct) |

---

## Cross-Workspace Cache Protocol

```
/jarvis-understand invoked
│
├── cache-manager.sh check <project-root>
│   ├── EXIT 0 (hit, hash matches HEAD) → load cached CONTEXT.md → done
│   └── EXIT 1 (miss/stale)
│       ├── Diff size check: git diff <stored-hash>..HEAD --stat
│       │   ├── < 30% files changed → /jarvis-refresh (incremental)
│       │   └── >= 30% changed → full re-analysis
│       └── After analysis: cache-manager.sh store <project-root>
```

---

## Error Handling Rules

| Condition | Action |
|-----------|--------|
| Registry missing | Halt + suggest `/jarvis-setup` |
| CONTEXT.md missing during `/jarvis-build` | Warn user, offer to proceed without context |
| Plugin repo missing | Warn on stderr, skip that plugin, continue |
| No git repo in project | Cache disabled, full analysis always |
| PROJECT_MEMORY.md missing | Create from template, continue |
| JARVIS_MEMORY.md missing | Create from template, continue |
