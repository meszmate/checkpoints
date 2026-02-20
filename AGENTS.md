# Checkpoints Agent Guide

Use this file as the source of truth for git checkpoint workflows in this repository.
For app-specific setup steps (Codex, Cursor, Claude Code, Aider, Cline, Copilot), see `docs/agent-setup.md`.

## Compatibility

These rules are written to be agent-agnostic and work with Claude Code, Codex, Cursor, Aider, Gemini CLI, and similar agents that can run shell commands.

## Root path

- Prefer `CHECKPOINTS_ROOT` when it is set.
- Otherwise use `CLAUDE_PLUGIN_ROOT` if available.
- Otherwise, if working inside this repo, use `$(git rev-parse --show-toplevel)`.

## Hard enforcement

- Configure repo hooks once: `git config core.hooksPath "$CHECKPOINTS_ROOT/githooks"`.
- This strips `Co-Authored-By` and similar AI attribution lines at commit-message time, even if an agent injects them.

## Commands

- Branch: create branch names from natural language (kebab-case, max 50 chars).
- Commit: generate conventional commit messages from actual staged diff, then run `scripts/commit-safe.sh`.
- Checkpoint: run `scripts/checkpoint.sh` with a conventional subject like `<type>: <concise description>`.
- Push: push current branch with upstream tracking.
- Pull request: push branch and create PR (`gh pr create` when available).
- Amend: stage current changes, regenerate message, then run `scripts/commit-safe.sh --amend`.

## Commit and PR rules

- Never add `Co-Authored-By` trailers.
- Never add AI attribution text like `Generated with ...`.
- Use a single-line commit subject only (no body).
- Keep commit subject concise (target <= 72 chars).
- Prefer conventional commit types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`, `style`, `perf`, `ci`, `build`.

## Safety

- Verify git identity before commit/amend:
  - `git config user.name`
  - `git config user.email`
- Do not set git identity automatically.
- Do not run destructive git commands unless the user explicitly asks.
