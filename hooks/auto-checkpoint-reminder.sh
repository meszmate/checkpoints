#!/bin/sh

# Lightweight check — runs on every prompt submission.
# Only outputs a reminder if auto-checkpointing is enabled.

if [ -f "$HOME/.checkpoints-auto" ] && git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "[checkpoints] Auto-checkpointing is ON. If you just completed significant work (feature, bug fix, refactor), create a checkpoint commit using: sh ${CLAUDE_PLUGIN_ROOT}/scripts/checkpoint.sh \"<type>: <message>\""
fi

exit 0
