---
description: Check or change auto-checkpointing status
argument-hint: "[on|off|toggle]"
allowed-tools:
  - Bash
---

Check or change automatic checkpoint commits.

The toggle state is stored in `~/.checkpoints-auto`. If the file exists, auto-checkpointing is enabled. If it doesn't, it's disabled.

**Default:** off.

**Steps:**

1. If `$ARGUMENTS` is `on`:
   - Run `touch ~/.checkpoints-auto`
   - Confirm: "Auto-checkpointing enabled."

2. If `$ARGUMENTS` is `off`:
   - Run `rm -f ~/.checkpoints-auto`
   - Confirm: "Auto-checkpointing disabled."

3. If `$ARGUMENTS` is `toggle`:
   - Check if `~/.checkpoints-auto` exists
   - If it exists, remove it and confirm: "Auto-checkpointing disabled."
   - If it doesn't exist, create it and confirm: "Auto-checkpointing enabled."

4. If `$ARGUMENTS` is empty (no argument — show status):
   - Check if `~/.checkpoints-auto` exists
   - If it exists, report: "Auto-checkpointing is currently **enabled**. Use `/auto-checkpoint off` to disable."
   - If it doesn't exist, report: "Auto-checkpointing is currently **disabled**. Use `/auto-checkpoint on` to enable."
