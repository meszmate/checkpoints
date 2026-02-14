#!/bin/sh
set -e

# Session marker — only run full checks once per session
# Use TMPDIR (macOS), TEMP (Windows), or /tmp as fallback
_TMPDIR="${TMPDIR:-${TEMP:-/tmp}}"
MARKER="${_TMPDIR}/.checkpoints-session-$$"

if [ -f "$MARKER" ]; then
    exit 0
fi

touch "$MARKER"

warnings=""

# Check if current directory is a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    warnings="${warnings}[checkpoints] Warning: Not inside a git repository. Run \`git init\` to initialize one.\n"
fi

# Check git identity
if [ -z "$(git config user.name 2>/dev/null)" ]; then
    warnings="${warnings}[checkpoints] Warning: Git user.name is not set. Run: git config --global user.name \"Your Name\"\n"
fi

if [ -z "$(git config user.email 2>/dev/null)" ]; then
    warnings="${warnings}[checkpoints] Warning: Git user.email is not set. Run: git config --global user.email \"you@example.com\"\n"
fi

# Check gh CLI availability
if command -v gh > /dev/null 2>&1; then
    if ! gh auth status > /dev/null 2>&1; then
        warnings="${warnings}[checkpoints] Note: gh CLI is installed but not authenticated. Run \`gh auth login\` to enable /pull PR creation.\n"
    fi
else
    warnings="${warnings}[checkpoints] Note: gh CLI is not installed. /pull will provide manual URLs instead. Install from https://cli.github.com\n"
fi

# Show auto-checkpoint status
if [ -f "$HOME/.checkpoints-auto" ]; then
    warnings="${warnings}[checkpoints] Auto-checkpointing: on. Toggle with /auto-checkpoint.\n"
else
    warnings="${warnings}[checkpoints] Auto-checkpointing: off. Toggle with /auto-checkpoint.\n"
fi

# Output warnings if any
if [ -n "$warnings" ]; then
    printf "%b" "$warnings"
fi

exit 0
