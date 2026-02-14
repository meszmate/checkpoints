---
description: Smart commit with auto-generated conventional commit messages
argument-hint: "[message]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

Create a git commit, optionally with an auto-generated conventional commit message.

**Steps:**

1. Verify this is a git repository and that git identity is configured:
   - Run `git rev-parse --is-inside-work-tree`
   - Run `git config user.name` and `git config user.email` — if either is missing, warn the user with setup instructions: `git config --global user.name "Your Name"` and `git config --global user.email "you@example.com"`. Do **not** set these values yourself. Stop here if identity is missing.

2. Run `git status` to see staged, unstaged, and untracked files.

3. If there are untracked files, list them and ask the user whether to include them before staging.

4. Stage the files the user agreed to include (use `git add <file>` for specific files, or `git add -u` for tracked files only).

5. Determine the commit message:
   - If `$ARGUMENTS` is provided, use it as the commit message directly.
   - If no arguments, analyze `git diff --cached` (and `git diff` for context) to generate a conventional commit message. Use these prefixes: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`, `style:`, `test:`, `perf:`, `ci:`, `build:`. Keep the message concise (under 72 characters for the subject line).

6. Run `git commit -m "<message>"`.

7. Show a summary: run `git diff --stat HEAD~1` to display files changed, insertions, and deletions.
