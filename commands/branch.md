---
description: Create a new git branch from a natural language description
argument-hint: <description>
allowed-tools:
  - Bash
  - Read
---

Create a new git branch based on the user's description.

**Input:** `$ARGUMENTS` — a natural language description of the branch purpose (e.g., "add login page", "fix header alignment").

**Steps:**

1. Check for uncommitted changes by running `git status --porcelain`. If there are uncommitted changes, warn the user and ask them to commit or stash before creating the branch. Do not proceed until the working tree is clean.

2. Generate a branch name from the description:
   - Convert to lowercase
   - Replace spaces and special characters with hyphens
   - Remove consecutive hyphens
   - Strip leading/trailing hyphens
   - Truncate to 50 characters maximum
   - Example: "Add Login Page!" → `add-login-page`

3. Run `git checkout -b <branch-name>` to create and switch to the new branch.

4. Confirm the branch was created successfully. Show the branch name.
