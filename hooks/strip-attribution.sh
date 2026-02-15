#!/bin/sh
# PreToolUse hook: blocks git commit / gh pr create commands
# that contain Co-Authored-By trailers or "Generated with Claude Code".
# This forces Claude to retry without the attribution.

INPUT="$(cat)"

# Only check Bash tool calls
case "$INPUT" in
    *'"tool_name"'*'"Bash"'*) ;;
    *) exit 0 ;;
esac

# Check for git commit or checkpoint.sh with Co-Authored-By
if echo "$INPUT" | grep -qi "git commit\|checkpoint\.sh"; then
    if echo "$INPUT" | grep -qi "co-authored-by"; then
        echo '{"decision":"block","reason":"Do not add Co-Authored-By trailers to commit messages. Commits must only show the users git identity. Remove the Co-Authored-By line and retry."}'
        exit 0
    fi
fi

# Check for gh pr create with "Generated with Claude Code" or Co-Authored-By
if echo "$INPUT" | grep -qi "gh pr create"; then
    if echo "$INPUT" | grep -qi "generated with"; then
        echo '{"decision":"block","reason":"Do not add Generated with Claude Code to PR descriptions. Remove that line and retry."}'
        exit 0
    fi
    if echo "$INPUT" | grep -qi "co-authored-by"; then
        echo '{"decision":"block","reason":"Do not add Co-Authored-By to PR descriptions. Remove that line and retry."}'
        exit 0
    fi
fi

exit 0
