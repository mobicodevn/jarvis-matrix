---
name: jarvis-review
description: |
  Multi-perspective code review dispatching three agent-skills review agents in parallel.
  Merges findings, cross-checks against memory rules, and auto-records recurring patterns.
triggers: ["/jarvis-review"]
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
writes: [.jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
plugins_invoked: [agent-skills/code-review-and-quality, agent-skills/agents]
compression: ponytail-lite
---

# /jarvis-review — Multi-Perspective Code Review

> **Memory Sync:** Reads all three brain files before executing.

## When to Use

After completing a build, before merging changes, or on-demand for any code changes. Can target staged changes, specific files, or the full project.

## Process

### Step 1 — Memory Sync

Read JARVIS_MEMORY.md, PROJECT_MEMORY.md, CONTEXT.md.

Extract:
- Global coding standards from JARVIS_MEMORY.md
- Project conventions and business rules from PROJECT_MEMORY.md
- Architecture context from CONTEXT.md

### Step 2 — Determine Review Scope

Ask if unclear. Determine scope in priority order:
1. Staged changes: `git diff --cached --name-only`
2. User-specified files: use those
3. Last commit: `git diff HEAD~1..HEAD --name-only`
4. Full project: confirm before proceeding (can be slow)

Display: "Reviewing: <N> files (<scope type>)"

### Step 3 — Load Review Agents

From registry, load paths to:
- `agent-skills/agents/code-reviewer.md`
- `agent-skills/agents/security-auditor.md`
- `agent-skills/agents/test-engineer.md`

### Step 4 — Dispatch Parallel Review (Fan-Out)

Dispatch all three agents **simultaneously**, each receiving:
- Review scope files (full content)
- Relevant CONTEXT.md sections for those files
- Project conventions from PROJECT_MEMORY.md

Agents run independently and return findings.

### Step 5 — Cross-Check Against Memory

For each finding:
1. Check JARVIS_MEMORY.md global coding standards — is this finding covered by an existing rule?
   - If yes: escalate severity (user was explicitly warned about this pattern)
   - If no: record as new finding
2. Check PROJECT_MEMORY.md project rules — does this violate a documented constraint?
   - If yes: mark as `[CRITICAL]` regardless of agent's original severity

### Step 6 — Merge & Deduplicate

- Same finding from multiple agents → single entry, highest severity from any agent
- Consolidate related findings into one actionable item
- Sort: Critical → Warning → Info

### Step 7 — Auto-Learning Rule

Scan the current findings AND previous blame log entries:
- If the same finding TYPE appears 3+ times across reviews → trigger auto-recording:
  - Project-specific pattern: add to PROJECT_MEMORY.md Project Rules
  - Cross-project pattern: add to JARVIS_MEMORY.md Global Coding Standards
  - Format: "Always [do X] when [context Y]"
  - Notify user: "Auto-recorded new rule: [rule text]"

### Step 8 — Present Report

```markdown
## Review Report — 2026-10-24T13:00:00Z
**Scope:** 8 files (staged changes)

### Critical [2]
- [CRITICAL] src/auth/middleware.ts:45 — JWT secret read from env without fallback validation.
  Violates PROJECT_MEMORY rule: "All secrets must validate presence at startup."
  Fix: Add `if (!process.env.JWT_SECRET) throw new Error('JWT_SECRET required')`
  (security-auditor)

- [CRITICAL] src/api/users.ts:23 — SQL query uses string interpolation. Injection risk.
  Fix: Use parameterized queries.
  (security-auditor)

### Warnings [3]
- [WARNING] src/auth/middleware.ts:30 — Function has 8 branches (cognitive complexity: 12).
  Suggest: Extract `validateToken()` and `authorizeRole()` as separate functions.
  (code-reviewer)
...

### Info [1]
- [INFO] src/utils/hash.ts — bcrypt rounds=10. Consider 12 for new deployments.
  (security-auditor)

### Memory Updates
- 🧠 New rule auto-recorded in PROJECT_MEMORY.md: "Always validate env secret presence at startup"
```

## Verification

- All three review agents consulted
- Findings sorted by severity
- PROJECT_MEMORY.md and/or JARVIS_MEMORY.md updated if recurring patterns found
- Report includes file + line attribution for all critical/warning findings
