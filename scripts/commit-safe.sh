#!/bin/sh
set -e

# Exit codes:
# 1 = not a git repo
# 2 = no git identity configured
# 3 = no commit message provided

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not inside a git repository." >&2
    exit 1
fi

if [ -z "$(git config user.name 2>/dev/null)" ] || [ -z "$(git config user.email 2>/dev/null)" ]; then
    echo "Error: Git identity not configured." >&2
    echo "Run:" >&2
    echo "  git config --global user.name \"Your Name\"" >&2
    echo "  git config --global user.email \"you@example.com\"" >&2
    exit 2
fi

AMEND=""
if [ "$1" = "--amend" ]; then
    AMEND="--amend"
    shift
fi

MESSAGE="$1"
if [ -z "$MESSAGE" ]; then
    echo "Error: No commit message provided." >&2
    echo "Usage: commit-safe.sh [--amend] \"<commit message>\"" >&2
    exit 3
fi

# Enforce a single-line commit subject.
MESSAGE="$(printf '%s\n' "$MESSAGE" | tr '\r' '\n' | sed -n '/[^[:space:]]/{s/^[[:space:]]*//;s/[[:space:]]*$//;p;q;}')"
if [ -z "$MESSAGE" ]; then
    echo "Error: Commit message must contain a non-empty subject line." >&2
    exit 3
fi

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
HOOKS_DIR="$ROOT/githooks"

git -c core.hooksPath="$HOOKS_DIR" commit $AMEND -m "$MESSAGE"
