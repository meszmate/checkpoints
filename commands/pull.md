---
description: Push branch and create a pull request
argument-hint: "[--draft] [title]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

Push the current branch and create a pull request.

**Steps:**

1. Check for uncommitted changes (`git status --porcelain`). If there are changes, offer to commit them first using the checkpoint script at `${CLAUDE_PLUGIN_ROOT}/scripts/checkpoint.sh`.

2. Detect the default branch:
   - Try `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'`
   - If that fails, check if `main` or `master` exists: `git rev-parse --verify origin/main 2>/dev/null` or `git rev-parse --verify origin/master 2>/dev/null`
   - Fall back to `main` if neither is found.

3. Verify a remote is configured: `git remote -v`. If no remote, warn the user and stop.

4. Get the current branch name: `git rev-parse --abbrev-ref HEAD`. If on the default branch, warn the user they should create a feature branch first.

5. Push the current branch: `git push -u origin <branch-name>`.

6. Parse `$ARGUMENTS`:
   - Check for `--draft` flag
   - Remaining text is the PR title (if provided)

7. If no title is provided, generate one from the branch name and recent commit history:
   - Convert branch name hyphens to spaces, capitalize first letter
   - Review `git log <default-branch>..<branch> --oneline` for context

8. Generate the PR body from the commit log:
   ```
   git log <default-branch>..<branch> --oneline --no-merges
   ```
   Format as a markdown list of changes.

9. Check if `gh` CLI is available (`command -v gh`):
   - **If yes:** Create the PR:
     ```
     gh pr create --title "<title>" --body "<body>" [--draft]
     ```
   - **If no:** Construct and display a manual URL for the user:
     - Get the remote URL and extract owner/repo
     - Print: `https://github.com/<owner>/<repo>/compare/<branch>?expand=1`

10. Output the PR URL.
