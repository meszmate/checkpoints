---
name: checkpoint
description: Automatically creates git checkpoint commits when significant milestones are reached. Triggers on keywords like checkpoint, milestone, significant progress, feature complete, bug fixed, refactor done, implementation complete, setup done.
---

# Checkpoint Skill

Automatically create a checkpoint commit when you have completed a significant piece of work. This skill helps track progress without the user needing to manually run `/checkpoint`.

## When to Checkpoint

Create a checkpoint after:
- Completing a feature or sub-feature
- Fixing a bug successfully
- Finishing a refactor
- Setting up infrastructure (configs, dependencies, project scaffolding)
- Completing a meaningful set of related changes

## When NOT to Checkpoint

Do **not** create a checkpoint for:
- Typo fixes or single-line edits
- Incomplete work (half-finished features)
- Changes that don't compile or break tests
- Exploratory changes the user hasn't confirmed

## How to Checkpoint

1. Verify git identity is configured:
   - Run `git config user.name` and `git config user.email`
   - If either is missing, warn the user and do **not** commit. Never set git identity yourself.

2. Run `git status` to see staged, unstaged, and untracked files.

3. Stage files selectively:
   - Use `git add -u` to stage tracked (modified/deleted) files.
   - For new files that were created as part of the current work, add them specifically with `git add <file>`.
   - Do **not** use `git add -A` — avoid blindly staging unrelated files.

4. Run `git diff --cached` to analyze the staged changes.

5. Generate a conventional commit message based on the diff. Use these prefixes:
   - `feat:` — new feature
   - `fix:` — bug fix
   - `refactor:` — code restructuring
   - `chore:` — setup, config, dependencies
   - `docs:` — documentation
   - `test:` — adding or updating tests
   - `style:` — formatting, whitespace
   - `perf:` — performance improvements

6. Run `git commit -m "<type>: <concise description>"`. Keep messages under 72 characters. Do **not** append `Co-Authored-By` trailers or any other attribution — commits must only show the user's git identity.

7. Show a summary: run `git diff --stat HEAD~1` to display what changed.

8. Briefly inform the user that a checkpoint was saved.

## Important

- **Never** run `git config user.name "..."` or `git config user.email "..."` to set values.
- All commits must use the user's own git identity.
- If the commit fails, report the error to the user without retrying.
