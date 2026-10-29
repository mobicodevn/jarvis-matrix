# Jarvis-Matrix — Routing Reference & Decision Rules

> Companion reference for Antigravity, Cursor, Claude Code, and Codex adapters.
> Describes how the orchestrator evaluates user intents and maps them to external plugins across develop, design, and copywriting pillars.

---

## The Master Routing Loop

```
User invokes /jarvis-* command
│
├── Step 1: Memory Sync
│   ├── Read JARVIS_MEMORY.md (always)
│   └── Read PROJECT_MEMORY.md (if exists)
│
├── Step 2: Registry Check
│   ├── registry.json exists? → continue
│   └── Missing → warn + halt ("Run bash scripts/setup.sh")
│
├── Step 3: Identify Required Plugins
│   └── Consult registry.json for skill paths (develop, design, and copywriting pillars)
│
├── Step 4: Load Only Required Skills (Zero-Bloat Context Isolation)
│   └── Read exact SKILL.md files → inject into context
│
└── Step 5: Execute Skill
    └── Dispatch sub-agents if needed (parallel or sequential waves)
```

---

## Plugin Routing Reference

### Pillar 1: Engineering Plugins (`develop/`)

#### Understand-Anything
- **Registry key:** `understand-anything`
- **Primary skill:** `understand-anything-plugin/skills/understand/SKILL.md`
- **Output:** `.ua/knowledge-graph.json` (in project root)
- **Invocation:** Read skill, delegate full project scan
- **Used by:** `/jarvis-understand`, `/jarvis-refresh`

#### graphify
- **Registry key:** `graphify`
- **Type:** Python library (pipeline invocation: detect → extract → build → cluster → analyze → report → export)
- **Output:** `graphify-out/graph.json`, `GRAPH_REPORT.md`
- **Used by:** `/jarvis-understand`, `/jarvis-refresh`

#### ponytail
- **Registry key:** `ponytail`
- **Levels:** `lite`, `full`, `ultra`
- **Used by:** `/jarvis-plan`, `/jarvis-build`, `/jarvis-understand`

#### caveman
- **Registry key:** `caveman`
- **Modes:** `caveman`, `ultracave`, `megacave`
- **Used by:** `/jarvis-build` (sub-agent comms), `/jarvis-understand` (large projects)

#### agent-skills
- **Registry key:** `agent-skills`
- **Key skills:** `spec-driven-development`, `interview-me`, `planning-and-task-breakdown`, `incremental-implementation`, `code-review-and-quality`
- **Used by:** `/jarvis-spec`, `/jarvis-plan`, `/jarvis-build`, `/jarvis-review`

---

### Pillar 2: UI/UX, Aesthetic, Branding & Motion Plugins (`design/`)

#### impeccable
- **Registry key:** `impeccable`
- **Canonical skill:** `impeccable/.gemini/skills/impeccable/SKILL.md`
- **Capability:** Component polish, craft details, interaction completeness, and execution standards.
- **Used by:** `/jarvis-design`, `jarvis-design-executor`

#### skills (emilkowalski)
- **Registry key:** `skills`
- **Key skills:** `animate`, `animation-performance`, `animation-vocabulary`, `review-animations`, `improve-animations`
- **Capability:** Spring physics, custom cubic-bezier curves, duration budgets, frequency gates.
- **Used by:** `/jarvis-design`, `jarvis-design-motion-engineer`

#### taste-skill
- **Registry key:** `taste-skill`
- **Canonical skill:** `taste-skill/skills/taste-skill/SKILL.md`
- **Capability:** Visual hierarchy, typography pairing, spacing scales, 10-point Anti-Slop checklist.
- **Used by:** `/jarvis-design`, `jarvis-design-taste-director`

#### ui-ux-pro-max-skill
- **Registry key:** `ui-ux-pro-max-skill`
- **Key skills:** `ui-ux-pro-max`, `design`, `design-system`, `ui-styling`
- **Capability:** 192 product categories, 79 UI styles, 34 landing page patterns, token architecture.
- **Used by:** `/jarvis-design`, `jarvis-design-architect`, `jarvis-design-interrogator`

#### hyperframes
- **Registry key:** `hyperframes`
- **Key skills:** `captions-overlay`, `changelog-video`
- **Capability:** Frame composition, video changelog animations, synchronized text/captions overlays.
- **Used by:** `/jarvis-design`, `jarvis-design-motion-engineer`

#### logo-design-skill
- **Registry key:** `logo-design-skill`
- **Canonical skill:** `logo-design-skill/skills/logo-design/SKILL.md`
- **Capability:** Vector logo marks, geometric SVG construction, responsive favicon scaling, brand lockups.
- **Used by:** `/jarvis-design`, `jarvis-design-taste-director`, `jarvis-designer`

---

### Pillar 3: Copywriting & Language Plugins (`copywriting/`)

#### humanizer
- **Registry key:** `humanizer`
- **Skill path:** `humanizer/SKILL.md`
- **Invocation mode:** Direct or embedded (pass text, get back clean prose)
- **Used by:** `/jarvis-writer`, `/jarvis-writer-en`, `/jarvis-understand` (summaries), `/jarvis-plan` (overview), `/jarvis-review` (report)

#### vietnamese-humanizer
- **Registry key:** `vietnamese-humanizer`
- **Key skills:** `humanizer-vi`, `translationese-cleaner-vi`, `style-guide-vi`, `grammar-checker-vi`
- **Capability:** Vietnamese natural tone calibration, translationese stripping, authentic vocabulary, grammar verification.
- **Used by:** `/jarvis-writer`, `/jarvis-writer-vi`

#### jarvis-writer (Master Agent)
- **Agent file:** `agents/jarvis-writer.md`
- **Capability:** Autonomous language detection (Vietnamese vs English) via script diacritics and explicit flag parsing, routing to `/jarvis-writer-vi` or `/jarvis-writer-en`.

---

## Design Sub-Agent Pipeline Routing Tree

```
/jarvis-design invoked
│
├── Phase 1: Clarification Gate (jarvis-design-interrogator)
│   ├── Score prompt across 6 weighted dimensions
│   ├── Confidence >= 95%? → Proceed to Phase 2
│   └── Confidence < 95%? → Ask <= 5 targeted questions (gate blocks coding)
│
├── Phase 2: Category Ingestion
│   └── Match product type to 1 of 192 UI/UX Pro Max categories
│
├── Phase 3 & 4: Architecture & Parallel Design Synthesis
│   ├── Parallel Stream A: jarvis-design-taste-director + logo-design-skill (Colors, typography, anti-slop, vector marks)
│   ├── Parallel Stream B: jarvis-design-motion-engineer + hyperframes (Springs, timing curves, video frames)
│   └── Structural Stream: jarvis-design-architect (Claim-driven IA & layout grid)
│
├── Phase 5: Code Synthesis (jarvis-design-executor)
│   └── Impeccable execution (motion-off first, tokens, responsive, accessible)
│
└── Phase 6: Sequential Quality Review
    ├── Anti-slop checklist verification
    ├── Emil Kowalski animation performance audit
    └── Persist finalized tokens to [[PROJECT_MEMORY.md]]
```

---

## Memory Read/Write Matrix

| Skill / Sub-Agent | JARVIS_MEMORY | CONTEXT | PROJECT_MEMORY |
|-------------------|:---:|:---:|:---:|
| `scripts/setup.sh` | **W** (init) | — | — |
| `/jarvis-design` | **R** (preferences) | **R** (architecture) | **RW** (design tokens) |
| `jarvis-design-interrogator` | **R** | — | **RW** (spec) |
| `jarvis-design-architect` | **R** | **R** | **RW** (layout) |
| `jarvis-design-taste-director` | **R** (banned patterns) | — | **RW** (tokens) |
| `jarvis-design-motion-engineer`| **R** (timing preferences)| — | **RW** (motion) |
| `jarvis-design-executor` | **R** | **R** | **RW** (decisions) |
| `/jarvis-writer` | **R** | — | **RW** (glossary) |
| `/jarvis-writer-vi` | **R** | — | **RW** (tone rules) |
| `/jarvis-writer-en` | **R** | — | **RW** (brand voice) |
| `jarvis-writer` (agent) | **R** | — | **RW** (language preferences) |
| `/jarvis-understand` | R | **W** (create) | R |
| `/jarvis-context` | **R** | **R** | **R** |
| `/jarvis-update` | **RW** (versions x 13) | — | — |
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

## Error Handling & Guardrails

| Condition | Action |
|-----------|--------|
| Registry missing | Halt + suggest `bash scripts/setup.sh` |
| Design / Copywriting repo missing | Warn on stderr, skip that plugin, continue with remaining |
| `/jarvis-design` called with zero design plugins | Error: "No design plugins found. Run `bash scripts/setup.sh`." |
| Context bloat attempt (loading full repo) | Router blocks traversal; enforces single SKILL.md slice |
| Requirement clarity < 95% | Block code generation; ask up to 5 targeted questions |
| Skipped repo in design ensemble | Linter/router assertion fails; halt and inject missing repo |
| CONTEXT.md missing during `/jarvis-build` | Warn user, offer to proceed without context |
| PROJECT_MEMORY.md missing | Create from template, continue |
| JARVIS_MEMORY.md missing | Create from template, continue |
