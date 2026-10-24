---
name: jarvis-spec
description: |
  "Spec Before Code" — interviews the user until >= 95% confidence in understanding the
  requirement. Produces a structured spec persisted to PROJECT_MEMORY.md. No code generated.
triggers: ["/jarvis-spec"]
reads: [.jarvis/CONTEXT.md, .jarvis/PROJECT_MEMORY.md, JARVIS_MEMORY.md]
writes: [.jarvis/PROJECT_MEMORY.md]
plugins_invoked: [agent-skills/spec-driven-development, agent-skills/interview-me]
compression: none
---

# /jarvis-spec — Spec Before Code

> **Memory Sync:** Reads all three brain files before executing.
>
> **Critical:** This skill produces **specs only**. No code. No plan. No implementation.

## When to Use

Before starting any implementation. Even if you think you know the requirement, running `/jarvis-spec` catches edge cases, clarifies scope, and creates a record for later stages.

## Process

### Step 1 — Memory Sync

Read all three brain files:
1. `JARVIS_MEMORY.md` — global standards, user preferences
2. `PROJECT_MEMORY.md` — existing specs, project rules, business constraints
3. `CONTEXT.md` — project architecture (if available)

Check `PROJECT_MEMORY.md` "Project Specs Vault" for any existing related specs. If a highly similar spec already exists, show it and ask: "Is this the same requirement, or a new one?"

### Step 2 — Capture Initial Requirement

Ask: "What do you want to build or change? Describe it in your own words."

### Step 3 — Load agent-skills

From registry, load:
- `agent-skills/spec-driven-development` skill
- `agent-skills/interview-me` skill (if available)

Use these to structure the clarification interview.

### Step 4 — Confidence Assessment Loop

Evaluate initial confidence (0–100%) across these dimensions:
- **Scope:** What is in? What is out?
- **Edge cases:** What happens when things go wrong?
- **Non-functional:** Performance, security, compatibility requirements?
- **User expectations:** What does success look like?
- **Technical constraints:** Dependencies, APIs, data shapes?
- **Domain rules:** Business logic that must be preserved?

While confidence < 95%:

1. Identify the lowest-confidence dimension
2. Ask 2–3 targeted questions in that area (never more than 3 at once)
3. Show progress after each answer:
   ```
   Confidence: ████████░░ 82%
   Still unclear: error handling, pagination behavior
   ```
4. Re-evaluate confidence after each answer
5. Continue until ≥ 95%

### Step 5 — Generate Structured Spec

At ≥ 95% confidence, produce:

```markdown
## Spec: <title> (confidence: 97%)

**Created:** YYYY-MM-DD
**Requirement:** one-sentence summary

**Acceptance Criteria:**
- [ ] criterion 1 — specific, testable
- [ ] criterion 2
- [ ] criterion 3

**Scope boundaries:**
- IN: what this covers
- OUT: explicitly excluded items

**Technical constraints:**
- From CONTEXT.md: <relevant architectural constraint>
- From PROJECT_MEMORY.md: <relevant business rule>

**Edge cases documented:**
- Edge case 1: expected behavior
- Edge case 2: expected behavior
```

### Step 6 — Persist to PROJECT_MEMORY.md

Append the spec to `PROJECT_MEMORY.md` under **Project Specs Vault**:

```markdown
### Spec: <title> (confidence: XX%)
...
```

Update `last_modified` in frontmatter. Add WikiLink in CONTEXT.md if it exists.

### Step 7 — Confirm

Show the persisted spec and confirm:
> "Spec saved to PROJECT_MEMORY.md. Ready to plan? Run `/jarvis-plan` to decompose this into atomic tasks."

## Anti-Patterns to Resist

- **Starting before 95%:** Never proceed to code, plan, or implementation with < 95% confidence
- **Asking too many questions at once:** Maximum 3 questions per round — users disengage with walls of questions
- **Making assumptions instead of asking:** If you're not sure, ask

## Verification

- Spec in PROJECT_MEMORY.md with correct frontmatter
- Confidence score ≥ 95% documented
- At least 3 acceptance criteria (specific and testable)
- Scope boundaries (in/out) explicitly documented
- No code generated
