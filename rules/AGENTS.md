# Jarvis-Matrix — Always-On Routing Rules

> This file is auto-loaded by Antigravity and governs Jarvis orchestrator behavior.
> It is read before every `/jarvis-*` skill execution.

---

## Core Orchestration Rules

### 1. Mandatory Memory Sync (Every Skill)

**Before executing any `/jarvis-*` command, you MUST:**

1. Read `~/.gemini/config/plugins/jarvis-matrix/JARVIS_MEMORY.md` (global rules, coding standards, user preferences)
2. Read `.jarvis/PROJECT_MEMORY.md` in the active project (if it exists)
3. Load the rules into your working context before taking any action

**Failure to do this violates the core Jarvis contract.**

### 2. Lazy-Loading Protocol (Never Pre-load)

Do NOT load all skills at startup. Follow this sequence on every invocation:

1. Identify which plugins are required for the invoked `/jarvis-*` command
2. Consult `config/registry.json` to get the absolute path to required SKILL.md files
3. Read only the exact SKILL.md files needed — nothing more
4. Inject those files into sub-agent context alongside the task

**Rationale:** Six plugins with dozens of skills would consume thousands of tokens if pre-loaded.

### 3. Compression Decision Matrix

Apply compression levels as follows:

| Task Phase | Default | Escalation Trigger | Max |
|------------|---------|-------------------|-----|
| `/jarvis-spec` | **None** | — | None |
| `/jarvis-plan` | ponytail-lite | > 20 tasks | ponytail-full |
| `/jarvis-build` | ponytail-full + caveman | > 3 files per task | ponytail-ultra + ultracave |
| `/jarvis-review` | ponytail-lite | — | ponytail-full |
| `/jarvis-understand` | ponytail-full | > 500 files | ponytail-ultra + caveman |
| Sub-agent communications | caveman (always) | — | ultracave |

### 4. Multi-Agent Dispatch Protocol

When dispatching sub-agents for a plan:

1. Parse `depends_on` arrays in task frontmatter to build a DAG
2. Group tasks into parallel waves: tasks with no unresolved dependencies form a wave
3. Dispatch all tasks in a wave **in parallel**
4. Gate on wave completion before starting the next wave
5. Each sub-agent receives **only** its atomic task file, the relevant CONTEXT.md slice, and loaded skills — not the entire project context

### 5. Never Rewrite Plugins

Jarvis-Matrix routes to plugins. It does NOT rewrite them.

- Read plugin capabilities from `config/registry.json`
- Invoke them by reading their SKILL.md files and delegating
- Treat each plugin's SKILL.md as authoritative

### 6. Registry Fallback

If `config/registry.json` does not exist:
1. Warn the user: "Registry not found. Run `/jarvis-setup` to initialize."
2. Do not attempt to invoke any plugin
3. Stop and wait for setup

### 7. WikiLink Maintenance

Every write to any brain file (JARVIS_MEMORY.md, CONTEXT.md, PROJECT_MEMORY.md) MUST:
- Preserve all existing `[[WikiLinks]]`
- Add new WikiLinks for any cross-references introduced
- Never break bidirectional link integrity

---

## Routing Map

| User Intent | Skill to Invoke | Plugins Used |
|-------------|-----------------|-------------|
| First-time setup / add plugins | `/jarvis-setup` | — |
| Understand this codebase | `/jarvis-understand` | UA, graphify, humanizer |
| Load context into session | `/jarvis-context` | — |
| Update plugins to latest | `/jarvis-update` | — |
| Refresh context after changes | `/jarvis-refresh` | UA, graphify |
| Define requirements | `/jarvis-spec` | agent-skills |
| Create an implementation plan | `/jarvis-plan` | ponytail, caveman, agent-skills, humanizer |
| Execute the plan | `/jarvis-build start` | ponytail, caveman, agent-skills |
| Stop current build | `/jarvis-build stop` | — |
| Review code quality | `/jarvis-review` | agent-skills agents |
| View/edit global memory | `/jarvis-memory` | — |
| View/edit project memory | `/jarvis-project-memory` | — |
