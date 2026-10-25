---
type: jarvis-plan-overview
plan_name: v0.2.0
version: "0.2.0"
spec: "[[PRP-v0.2.0.md]]"
created: "2026-10-25T09:35:00+07:00"
status: completed
total_tasks: 15
waves: 6
linked_memory:
  global: "[[JARVIS_MEMORY.md]]"
  context: "[[CONTEXT.md]]"
  project: "[[PROJECT_MEMORY.md]]"
---

# Plan Overview — Jarvis-Matrix v0.2.0

> Companion to [PRP-v0.2.0.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/PRP-v0.2.0.md)  
> Spec Confidence: 99% | Compression Level: `ponytail-lite`

---

## 1. Plan Summary

v0.2.0 introduces the **Design Pillar** to Jarvis-Matrix, incorporating 4 external design repositories (`impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`), replacing the interactive setup wizard with an automated bootstrap script (`scripts/setup.sh`), creating `/jarvis-design`, and cloning the elite design fleet from `apex-design` under the `jarvis-` namespace with the **Strict "design" Keyword Naming Rule** (`jarvis-design-...`), zero-bloat context isolation, parallel/sequential handoffs, and Obsidian memory bindings. `apex-update` is explicitly excluded as updates are unified under `/jarvis-update`.

---

## 2. Wave Execution Roadmap

| Wave | Tasks | Focus | Parallelism |
|------|-------|-------|-------------|
| **Wave 1** | Task 01, 02, 03 | Foundation: Clean `/jarvis-setup`, write bootstrap script, update registry schema | Parallel |
| **Wave 2** | Task 04, 05 | Core Infrastructure: Dual-pillar registry builder, update config | Parallel |
| **Wave 3** | Task 06, 07 | Design Core: `/jarvis-design` master skill & mirrored design sub-agent fleet | Sequential |
| **Wave 4** | Task 08, 09, 10, 11, 14 | Routing, Adapters & Updates: Rules, update script, IDE adapters, memory | Parallel |
| **Wave 5** | Task 12, 13 | Documentation: CHANGELOG.md, README.md | Parallel |
| **Wave 6** | Task 15 | Verification: Post-implementation CONTEXT.md refresh | Sequential |

---

## 3. Sub-Agent & Skill Routing Architecture Enforced

1. **Mirrored Design Sub-Agent Fleet (Strict "design" Keyword Naming):**
   - `jarvis-design-interrogator`: Clarification & requirement scoring (gate ≥95%)
   - `jarvis-design-architect`: Information architecture & claim-driven layout
   - `jarvis-design-taste-director`: Aesthetic curation & 10-point anti-slop guardrails
   - `jarvis-design-motion-engineer`: Emil Kowalski spring physics & timing budgets
   - `jarvis-design-executor`: Impeccable production code synthesizer
   - `jarvis-designer`: Master pipeline coordinator
2. **Strict Namespacing & Exclusion:** All design sub-agents contain "design" to eliminate any collision or confusion with develop skills (`jarvis-planner`, `jarvis-spec`, `jarvis-builder`). `apex-update` is explicitly excluded.
3. **Zero-Bloat Context Isolation:** Sub-agents load only their assigned single SKILL.md slices.
4. **Parallel vs. Sequential Handoff:** Sequential interrogation gate ➔ parallel token/curve synthesis ➔ sequential execution ➔ sequential quality review.
5. **Mandatory 4-Repo Ensemble Rule:** All 4 repos evaluated on every design task; never skipped.
6. **Dual-Mode Accessibility:** 1-call autonomous mode + direct invocation of individual skills & sub-agents.
7. **No-Rewrite Rule:** Dynamically reference cloned paths in `github-plugins/design/`.
8. **Obsidian Memory Binding:** Bi-directional sync with `[[JARVIS_MEMORY.md]]` and `[[PROJECT_MEMORY.md]]`.

---

## 4. Numbered Task Index

- [01-remove-jarvis-setup.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/01-remove-jarvis-setup.md)
- [02-write-setup-script.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/02-write-setup-script.md)
- [03-update-registry-schema.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/03-update-registry-schema.md)
- [04-modify-build-registry.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/04-modify-build-registry.md)
- [05-update-jarvis-config.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/05-update-jarvis-config.md)
- [06-create-jarvis-design-skill.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/06-create-jarvis-design-skill.md)
- [07-create-jarvis-design-subagents.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/07-create-jarvis-design-subagents.md)
- [08-update-agents-rules.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/08-update-agents-rules.md)
- [09-update-routing-rules.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/09-update-routing-rules.md)
- [10-update-jarvis-update-skill.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/10-update-jarvis-update-skill.md)
- [11-modify-sync-adapters.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/11-modify-sync-adapters.md)
- [12-create-changelog.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/12-create-changelog.md)
- [13-update-readme.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/13-update-readme.md)
- [14-update-jarvis-memory.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/14-update-jarvis-memory.md)
- [15-refresh-context.md](file:///Users/kietnguyen/.gemini/config/plugins/jarvis-matrix/.jarvis/plans/15-refresh-context.md)
