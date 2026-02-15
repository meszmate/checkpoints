# Checkpoints

Git checkpoints for Claude Code. Auto-commits at milestones, smart branching, and open pull requests without leaving your terminal.

## Installation

Add the marketplace and install the plugin:

```
/plugin marketplace add meszmate/checkpoints
/plugin install checkpoints@checkpoints
```

Or from your terminal:

```sh
claude plugin marketplace add meszmate/checkpoints
claude plugin install checkpoints@checkpoints
```

## Commands

### `/branch <description>`

Create a new git branch from a natural language description.

```
/branch add user authentication
→ creates branch: add-user-authentication

/branch fix header alignment bug
→ creates branch: fix-header-alignment-bug
```

### `/commit [message]`

Smart commit with optional auto-generated conventional commit messages.

```
/commit                          # auto-generates message from diff
/commit feat: add login form     # uses provided message
```

Handles staging interactively — asks before including untracked files.

### `/checkpoint`

Quick snapshot. Stages everything and commits instantly with an auto-generated message. No questions asked.

```
/checkpoint
→ checkpoint: add user model and migration
```

### `/pull [--draft] [title]`

Push the current branch and create a pull request.

```
/pull                            # auto-generates title and body
/pull --draft                    # creates a draft PR
/pull Add authentication flow    # uses provided title
```

Uses `gh` CLI if available, otherwise prints a manual GitHub URL.

## Auto-Checkpointing

The plugin includes a checkpoint skill that automatically creates commits when significant milestones are reached (completing a feature, fixing a bug, finishing a refactor). Unlike `/checkpoint`, this skill stages files selectively and generates proper conventional commit messages by analyzing the diff.

To use it, tell the AI to use the checkpoint skill — for example, add something like **"use the checkpoint skill after completing tasks"** to your `CLAUDE.md` or project instructions.

## Git Identity

All commits use your own git identity. The plugin never sets `user.name` or `user.email` — it only reads them. If they're not configured, you'll be prompted to set them up.

## Requirements

- **git** — required
- **gh CLI** — optional, enables automatic PR creation. Install from https://cli.github.com
