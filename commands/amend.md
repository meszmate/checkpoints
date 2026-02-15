---
description: Amend the last commit with current changes and an updated message
argument-hint: "[instructions]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

Amend the most recent git commit — stage current changes into it and regenerate the commit message.

**Steps:**

1. Verify this is a git repository and that git identity is configured:
   - Run `git rev-parse --is-inside-work-tree`
   - Run `git config user.name` and `git config user.email` — if either is missing, warn the user with setup instructions: `git config --global user.name "Your Name"` and `git config --global user.email "you@example.com"`. Do **not** set these values yourself. Stop here if identity is missing.

2. Show the commit that will be amended:
   - Run `git log --oneline -1` to display the current HEAD commit.

3. Run `git status` to see staged, unstaged, and untracked files.

4. If there are untracked files, list them and ask the user whether to include them before staging.

5. Stage the files the user agreed to include (use `git add <file>` for specific files, or `git add -u` for tracked files only).

6. Determine the updated commit message:
   - Analyze `git diff --cached` (the new changes being added) and the previous commit's diff (`git diff HEAD~1 HEAD`) to understand the full scope of the amended commit.
   - Use the previous commit message (from step 2) as a starting point. Generate a conventional commit message that covers both the original and newly staged changes. Use these prefixes: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`, `style:`, `test:`, `perf:`, `ci:`, `build:`. Keep the message concise (under 72 characters for the subject line).
   - If `$ARGUMENTS` is provided, treat it as **instructions** for how to phrase or focus the message — not as the literal commit message.

7. Run `git commit --amend -m "<message>"`. Do **not** append `Co-Authored-By` trailers or any other attribution — commits must only show the user's git identity.

8. Show a summary: run `git diff --stat HEAD~1` to display files changed, insertions, and deletions.

**Writing style rules:**
- Write like a human developer — short, direct, no fluff.
- Do **not** use em dashes (—), semicolons for joining clauses, or formal/flowery language.
- Do **not** add verbose commit bodies unless the change truly needs explanation. A subject line is usually enough.
