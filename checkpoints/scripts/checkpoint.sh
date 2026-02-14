#!/bin/sh
set -e

# Exit codes:
# 1 = not a git repo
# 2 = no git identity configured
# 3 = no commit message provided
# 4 = nothing to commit

# 1. Verify git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not inside a git repository." >&2
    exit 1
fi

# 2. Verify git identity
if [ -z "$(git config user.name 2>/dev/null)" ] || [ -z "$(git config user.email 2>/dev/null)" ]; then
    echo "Error: Git identity not configured." >&2
    echo "Run:" >&2
    echo "  git config --global user.name \"Your Name\"" >&2
    echo "  git config --global user.email \"you@example.com\"" >&2
    exit 2
fi

# 3. Check for commit message
if [ -z "$1" ]; then
    echo "Error: No commit message provided." >&2
    echo "Usage: checkpoint.sh \"<commit message>\"" >&2
    exit 3
fi

MESSAGE="$1"

# 4. Check for changes
if git diff --quiet HEAD 2>/dev/null && git diff --cached --quiet 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "Nothing to commit — working tree is clean."
    exit 4
fi

# 5. Stage all changes
git add -A

# 6. Commit
git commit -m "$MESSAGE"

# 7. Output summary
echo ""
echo "Checkpoint saved:"
git log --oneline -1
echo ""
git diff --stat HEAD~1
