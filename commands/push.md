---
description: Push current branch to remote
allowed-tools:
  - Bash
---

Push the current branch to the remote repository.

**Steps:**

1. Verify this is a git repository: `git rev-parse --is-inside-work-tree`

2. Check for uncommitted changes (`git status --porcelain`). If there are changes, warn the user and ask if they want to commit first before pushing.

3. Verify a remote is configured: `git remote -v`. If no remote exists, warn the user and stop.

4. Get the current branch name: `git rev-parse --abbrev-ref HEAD`.

5. Push the branch: `git push -u origin <branch-name>`.

6. Show a confirmation with the branch name and remote URL.
