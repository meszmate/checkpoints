---
description: Quick snapshot — stage all changes and commit instantly
allowed-tools:
  - Bash
---

Take a quick checkpoint snapshot of the current state. No questions asked — just stage everything and commit.

**Steps:**

1. Run the checkpoint script:
   ```
   sh ${CLAUDE_PLUGIN_ROOT}/scripts/checkpoint.sh
   ```
   This will stage all changes and commit, but it needs a commit message as the first argument.

2. Before running the script, analyze recent changes to generate a brief description:
   - Run `git diff --stat` and `git diff --name-only` to see what changed.
   - Generate a concise description (a few words) of the changes.

3. Run the checkpoint script with the generated message:
   ```
   sh ${CLAUDE_PLUGIN_ROOT}/scripts/checkpoint.sh "checkpoint: <brief description>"
   ```

4. If the script exits with a non-zero code, interpret the error:
   - Exit 1: Not a git repo
   - Exit 2: No git identity configured — tell the user to set `git config --global user.name` and `git config --global user.email`
   - Exit 3: No message provided (shouldn't happen)
   - Exit 4: Nothing to commit — inform the user the working tree is clean

5. Show the checkpoint summary from the script output.
