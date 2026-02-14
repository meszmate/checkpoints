---
name: auto-checkpoint
description: Automatically creates git checkpoint commits when significant milestones are reached. Triggers on keywords like checkpoint, milestone, significant progress, feature complete, bug fixed, refactor done, implementation complete, setup done.
---

# Auto-Checkpoint Skill

**Before doing anything, check if auto-checkpointing is enabled** by running:
```
test -f ~/.checkpoints-auto && echo "ON" || echo "OFF"
```
If the result is "OFF", do **nothing** — do not create a checkpoint. Auto-checkpointing is off by default. The user can enable it with `/auto-checkpoint on`.

When enabled, you should automatically create a checkpoint commit when you have completed a significant piece of work. This skill helps track progress without the user needing to manually run `/checkpoint`.

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

1. First, verify git identity is configured:
   - Run `git config user.name` and `git config user.email`
   - If either is missing, warn the user and do **not** commit. Never set git identity yourself.

2. Run the checkpoint script with a conventional commit message:
   ```
   sh ${CLAUDE_PLUGIN_ROOT}/scripts/checkpoint.sh "<type>: <concise description>"
   ```

   Use conventional commit prefixes:
   - `feat:` — new feature
   - `fix:` — bug fix
   - `refactor:` — code restructuring
   - `chore:` — setup, config, dependencies
   - `docs:` — documentation
   - `test:` — adding or updating tests
   - `style:` — formatting, whitespace
   - `perf:` — performance improvements

3. Keep messages concise and descriptive (under 72 characters).

4. After the checkpoint, briefly inform the user that a checkpoint was saved.

## Important

- **Never** run `git config user.name "..."` or `git config user.email "..."` to set values.
- All commits must use the user's own git identity.
- If the checkpoint script fails, report the error to the user without retrying.
