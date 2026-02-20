# Checkpoints

Git checkpoints for AI coding agents. Auto-commits at milestones, smart branching, and open pull requests without leaving your terminal.

## Installation

### Claude Code plugin

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

### Any AI agent (Codex, Cursor, Aider, etc.)

Use this repo directly and point your agent instructions to `AGENTS.md`.

1. Clone this repo somewhere on disk.
2. Set `CHECKPOINTS_ROOT` to the clone path.
3. Tell your agent to follow `<CHECKPOINTS_ROOT>/AGENTS.md` for git workflows.

Example shell setup:

```sh
export CHECKPOINTS_ROOT="/Users/meszmate/checkpoints"
```

Most agents support a project instruction file. If yours does not, paste the key workflow rules from `AGENTS.md` into its system/project prompt.

To hard-enforce no AI attribution trailers even for direct `git commit`, set commit hooks for the current repo:

```sh
git config core.hooksPath "$CHECKPOINTS_ROOT/githooks"
```

### App-specific setup guides

For step-by-step setup in Codex, Cursor, Claude Code, Aider, Cline, and Copilot:

- See `docs/agent-setup.md`

## Commands

### `/branch <description>`

Create a new git branch from a natural language description.

```
/branch add user authentication
→ creates branch: add-user-authentication

/branch fix header alignment bug
→ creates branch: fix-header-alignment-bug
```

### `/commit [instructions]`

Smart commit with auto-generated conventional commit messages.

```
/commit                              # auto-generates message from diff
/commit only the auth changes        # follows your instructions
```

Always generates the commit message from the actual diff. If you provide arguments, they're treated as instructions (what to focus on, which files to include) — not as the literal message. Handles staging interactively — asks before including untracked files.

### `/checkpoint`

Quick snapshot. Stages everything and commits instantly with an auto-generated conventional single-line subject. No questions asked.

```
/checkpoint
→ feat: add user model and migration
```

### `/push`

Push the current branch to the remote. Warns if there are uncommitted changes.

```
/push
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

The repo includes a checkpoint skill that automatically creates commits when significant milestones are reached (completing a feature, fixing a bug, finishing a refactor). Unlike `/checkpoint`, this skill stages files selectively and generates proper conventional commit messages by analyzing the diff.

To use it, tell your AI agent to use the checkpoint skill after completing meaningful tasks.

## Git Identity

All commits use your own git identity. The plugin never sets `user.name` or `user.email` — it only reads them. If they're not configured, you'll be prompted to set them up.

## Requirements

- **git** — required
- **gh CLI** — optional, enables automatic PR creation. Install from https://cli.github.com
