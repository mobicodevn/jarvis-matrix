---
task_id: "04"
title: "Update scripts/setup.sh for Three Pillars & 13 Repositories"
depends_on: ["01", "03"]
parallel_group: wave-2
target_files:
  - scripts/setup.sh
plugins:
  - agent-skills/incremental-implementation
compression: ponytail-lite
estimated_complexity: medium
status: completed
---

# Task 04 — Update `scripts/setup.sh` for Three Pillars & 13 Repositories

> Linked Memory: [[JARVIS_MEMORY.md]] | [[CONTEXT.md]] | [[PROJECT_MEMORY.md]]

---

## Objective

Enhance `scripts/setup.sh` to automate bootstrapping across all three pillars (`develop/`, `design/`, `copywriting/`), provisioning all 13 external repositories and writing v3 configuration.

---

## Context

`setup.sh` bootstraps external repositories for developers and CI environments. It must now manage:
- `develop/` (5): `Understand-Anything`, `graphify`, `ponytail`, `caveman`, `agent-skills`
- `design/` (6): `impeccable`, `skills`, `taste-skill`, `ui-ux-pro-max-skill`, `hyperframes`, `logo-design-skill`
- `copywriting/` (2): `humanizer`, `vietnamese-humanizer`

---

## Acceptance Criteria

1. Defines `COPYWRITING_DIR="$BASE_DIR/copywriting"` and creates directory.
2. Removes `humanizer` from `DEVELOP_REPOS` array.
3. Adds `hyperframes` and `logo-design-skill` to `DESIGN_REPOS` array:
   - `["hyperframes"]="https://github.com/heygen-com/hyperframes"`
   - `["logo-design-skill"]="https://github.com/kaankiziltug/logo-design-skill"`
4. Defines `declare -A COPYWRITING_REPOS` containing:
   - `["humanizer"]="https://github.com/blader/humanizer"`
   - `["vietnamese-humanizer"]="https://github.com/longhang2004/vietnamese-humanizer"`
5. Loops and clones/updates across all three pillars.
6. Writes `copywriting_plugins_root` into `config/jarvis.config.json` with `version: "0.3.0"`.
7. Calls `$PLUGIN_ROOT/scripts/build-registry.sh "$DEVELOP_DIR" "$DESIGN_DIR" "$COPYWRITING_DIR"`.
8. Script runs cleanly under `set -euo pipefail`.

---

## Implementation Notes

- Ensure backwards compatibility if optional args are provided.
- Ensure all 13 git repository entries have valid URLs.

