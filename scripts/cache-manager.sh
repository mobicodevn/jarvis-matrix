#!/usr/bin/env bash
# cache-manager.sh — Cross-workspace CONTEXT.md cache operations
# Usage:
#   ./cache-manager.sh check <project-root>    → exit 0=hit, 1=miss/stale, 2=error
#   ./cache-manager.sh store <project-root>    → creates/updates cache entry
#   ./cache-manager.sh invalidate <project-root> → removes cache entry

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CACHE_DIR="$PLUGIN_ROOT/cache"

OPERATION="${1:-}"
PROJECT_ROOT="${2:-}"

# ── Validation ──────────────────────────────────────────────────────
if [[ -z "$OPERATION" || -z "$PROJECT_ROOT" ]]; then
  echo "[cache-manager] ERROR: operation and project-root required" >&2
  echo "  Usage: $0 check|store|invalidate <project-root>" >&2
  exit 2
fi

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "[cache-manager] ERROR: project root does not exist: $PROJECT_ROOT" >&2
  exit 2
fi

PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"

# ── Cache key: sha256 of realpath ────────────────────────────────────
if command -v sha256sum &>/dev/null; then
  CACHE_KEY="$(echo -n "$PROJECT_ROOT" | sha256sum | awk '{print $1}')"
elif command -v shasum &>/dev/null; then
  CACHE_KEY="$(echo -n "$PROJECT_ROOT" | shasum -a 256 | awk '{print $1}')"
else
  echo "[cache-manager] ERROR: no sha256 tool available" >&2
  exit 2
fi

ENTRY_DIR="$CACHE_DIR/$CACHE_KEY"
CONTEXT_CACHE="$ENTRY_DIR/context.md.cache"
HASH_FILE="$ENTRY_DIR/hash.sha256"
META_FILE="$ENTRY_DIR/metadata.json"

# ── Get current HEAD ─────────────────────────────────────────────────
get_current_head() {
  git -C "$PROJECT_ROOT" rev-parse HEAD 2>/dev/null || echo "NO_GIT"
}

# ── check ────────────────────────────────────────────────────────────
cmd_check() {
  if [[ ! -d "$ENTRY_DIR" || ! -f "$HASH_FILE" || ! -f "$CONTEXT_CACHE" ]]; then
    echo "[cache-manager] miss: no cache entry" >&2
    exit 1
  fi

  stored_hash="$(cat "$HASH_FILE")"
  current_head="$(get_current_head)"

  if [[ "$stored_hash" == "$current_head" ]]; then
    echo "[cache-manager] hit: $CACHE_KEY (HEAD=$current_head)" >&2
    echo "$CONTEXT_CACHE"  # Print cache path to stdout for caller
    exit 0
  else
    echo "[cache-manager] stale: stored=$stored_hash current=$current_head" >&2
    exit 1
  fi
}

# ── store ────────────────────────────────────────────────────────────
cmd_store() {
  local context_src="$PROJECT_ROOT/.jarvis/CONTEXT.md"

  if [[ ! -f "$context_src" ]]; then
    echo "[cache-manager] ERROR: CONTEXT.md not found at $context_src" >&2
    exit 2
  fi

  mkdir -p "$ENTRY_DIR"

  current_head="$(get_current_head)"
  now="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

  # Use flock if available for concurrent safety
  if command -v flock &>/dev/null; then
    (
      flock -x 200
      cp "$context_src" "$CONTEXT_CACHE"
      echo "$current_head" > "$HASH_FILE"
      cat > "$META_FILE" <<JSON
{
  "project_root": "$PROJECT_ROOT",
  "cache_key": "$CACHE_KEY",
  "analyzed_at": "$now",
  "git_hash": "$current_head",
  "workspaces": ["$PROJECT_ROOT"]
}
JSON
    ) 200>"$ENTRY_DIR/.lock"
  else
    cp "$context_src" "$CONTEXT_CACHE"
    echo "$current_head" > "$HASH_FILE"
    cat > "$META_FILE" <<JSON
{
  "project_root": "$PROJECT_ROOT",
  "cache_key": "$CACHE_KEY",
  "analyzed_at": "$now",
  "git_hash": "$current_head",
  "workspaces": ["$PROJECT_ROOT"]
}
JSON
  fi

  echo "[cache-manager] stored: $CACHE_KEY (HEAD=$current_head)" >&2
  exit 0
}

# ── invalidate ───────────────────────────────────────────────────────
cmd_invalidate() {
  if [[ -d "$ENTRY_DIR" ]]; then
    rm -rf "$ENTRY_DIR"
    echo "[cache-manager] invalidated: $CACHE_KEY" >&2
  else
    echo "[cache-manager] nothing to invalidate for $CACHE_KEY" >&2
  fi
  exit 0
}

# ── Dispatch ─────────────────────────────────────────────────────────
case "$OPERATION" in
  check)      cmd_check ;;
  store)      cmd_store ;;
  invalidate) cmd_invalidate ;;
  *)
    echo "[cache-manager] ERROR: unknown operation '$OPERATION'" >&2
    exit 2
    ;;
esac
