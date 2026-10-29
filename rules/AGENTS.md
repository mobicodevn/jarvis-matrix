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

**Rationale:** Thirteen plugins across develop, design, and copywriting pillars with dozens of skills would consume thousands of tokens if pre-loaded.

### 3. Compression Decision Matrix

Apply compression levels as follows:

| Task Phase | Default | Escalation Trigger | Max |
|------------|---------|-------------------|-----|
| `/jarvis-spec` | **None** | — | None |
| `/jarvis-plan` | ponytail-lite | > 20 tasks | ponytail-full |
| `/jarvis-build` | ponytail-full + caveman | > 3 files per task | ponytail-ultra + ultracave |
| `/jarvis-design` | ponytail-lite | > 5 components | ponytail-full |
| `/jarvis-writer*` | **None** | — | None |
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

### 5. Design Sub-Agent Fleet & Zero-Bloat Isolation

When handling UI/UX, styling, branding, or animation tasks under `/jarvis-design`:

1. **Strict "design" Keyword Naming Rule:**
   All design sub-agents must contain the keyword `design` to eliminate any confusion with `develop` or `copywriting` skills:
   - `jarvis-design-interrogator`: Requirement clarification (≥95% gate)
   - `jarvis-design-architect`: Information architecture & layout grid
   - `jarvis-design-taste-director`: Art direction, anti-slop checklist & logo/brand marks
   - `jarvis-design-motion-engineer`: Emil Kowalski spring physics, duration budgets & hyperframes overlays
   - `jarvis-design-executor`: Impeccable production code synthesizer
   - `jarvis-designer`: Master pipeline coordinator
   - *Note: `apex-update` is explicitly excluded and omitted.*

2. **Zero-Bloat Context Isolation:**
   Sub-agents must NEVER load the entire `github-plugins/design/` directory. Each sub-agent is strictly restricted to its specific assigned SKILL.md slice.

3. **Design Ensemble Evaluation Rule:**
   The design pipeline evaluates perspectives across all 6 design repositories (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`, `hyperframes`, `logo-design-skill`).

4. **Parallel vs. Sequential Dispatch:**
   - Interrogation gate is strictly sequential (≥ 95% clarity required before downstream dispatch).
   - Independent design tasks (`jarvis-design-taste-director` + `jarvis-design-motion-engineer`) are dispatched in parallel.
   - Code synthesis (`jarvis-design-executor`) runs after receiving tokens and layout.
   - Quality critique runs sequentially post-synthesis.

### 6. Copywriting Pillar & Language Routing Protocol

When executing copywriting, translation, or text polishing under `/jarvis-writer*`:

1. **Intelligent Language Routing:**
   - `/jarvis-writer` autonomously detects whether input is Vietnamese or English via script diacritics and keyword heuristics.
   - Vietnamese content routes to `jarvis-writer-vi` (`github-plugins/copywriting/vietnamese-humanizer`).
   - English content routes to `jarvis-writer-en` (`github-plugins/copywriting/humanizer`).
2. **Absolute Preservation:**
   - Never alter technical identifiers, facts, numbers, dates, or code blocks.
3. **Tone & Memory Binding:**
   - Respect tone and audience register rules defined in `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]`.

### 7. Never Rewrite Plugins

Jarvis-Matrix routes to plugins. It does NOT rewrite them.

- Read plugin capabilities from `config/registry.json`
- Invoke them by reading their SKILL.md files and delegating dynamically
- Treat each plugin's SKILL.md as authoritative

### 8. Registry Fallback

If `config/registry.json` does not exist:
1. Warn the user: "Registry not found. Run `bash scripts/setup.sh` to initialize."
2. Do not attempt to invoke any plugin
3. Stop and wait for setup

### 9. WikiLink Maintenance

Every write to any brain file (JARVIS_MEMORY.md, CONTEXT.md, PROJECT_MEMORY.md) MUST:
- Preserve all existing `[[WikiLinks]]`
- Add new WikiLinks for any cross-references introduced
- Never break bidirectional link integrity

---

## Routing Map

| User Intent | Skill to Invoke | Plugins Used |
|-------------|-----------------|-------------|
| Understand this codebase | `/jarvis-understand` | UA, graphify, humanizer |
| Load context into session | `/jarvis-context` | — |
| Update plugins to latest | `/jarvis-update` | — |
| Refresh context after changes | `/jarvis-refresh` | UA, graphify |
| Define requirements | `/jarvis-spec` | agent-skills |
| Create an implementation plan | `/jarvis-plan` | ponytail, caveman, agent-skills, humanizer |
| Execute the plan | `/jarvis-build start` | ponytail, caveman, agent-skills |
| Stop current build | `/jarvis-build stop` | — |
| Design UI/UX, branding & animations | `/jarvis-design` | impeccable, skills, taste-skill, ui-ux-pro-max-skill, hyperframes, logo-design-skill |
| Write/humanize (auto-detect language) | `/jarvis-writer` | humanizer, vietnamese-humanizer |
| Write/humanize Vietnamese | `/jarvis-writer-vi` | vietnamese-humanizer |
| Write/humanize English | `/jarvis-writer-en` | humanizer |
| Review code quality | `/jarvis-review` | agent-skills agents |
| View/edit global memory | `/jarvis-memory` | — |
| View/edit project memory | `/jarvis-project-memory` | — |
