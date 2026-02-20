#!/bin/sh
set -e

# Resolve the checkpoints installation root in a portable way across agent runtimes.
if [ -n "${CHECKPOINTS_ROOT:-}" ]; then
    ROOT="$CHECKPOINTS_ROOT"
elif [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
    ROOT="$CLAUDE_PLUGIN_ROOT"
else
    SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
    ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
fi

SCRIPT="$ROOT/scripts/checkpoint.sh"
if [ ! -f "$SCRIPT" ]; then
    echo "Error: checkpoint script not found at $SCRIPT" >&2
    echo "Set CHECKPOINTS_ROOT to the checkpoints installation path." >&2
    exit 1
fi

# Ensure helper scripts are executable when invoked directly.
if [ -f "$ROOT/scripts/commit-safe.sh" ]; then
    chmod +x "$ROOT/scripts/commit-safe.sh" 2>/dev/null || true
fi

exec sh "$SCRIPT" "$@"
