# Agent App Setup

Use this guide to wire Checkpoints into different AI coding agents.

## 1) One-time setup

```sh
# clone checkpoints
git clone https://github.com/meszmate/checkpoints.git ~/checkpoints

# set installation root for this shell/session
export CHECKPOINTS_ROOT="$HOME/checkpoints"
```

For direct `git commit` protection (recommended in every repo you work in):

```sh
git config core.hooksPath "$CHECKPOINTS_ROOT/githooks"
```

## 2) Standard instruction snippet

Add this to your agent's project instructions:

```text
Follow <CHECKPOINTS_ROOT>/AGENTS.md for git workflows.
Use single-line conventional commit subjects only.
Never include Co-Authored-By or AI attribution text in commits/PRs.
For commit and amend operations, prefer:
  sh <CHECKPOINTS_ROOT>/scripts/commit-safe.sh "<type>: <concise description>"
  sh <CHECKPOINTS_ROOT>/scripts/commit-safe.sh --amend "<type>: <concise description>"
For checkpoints, prefer:
  sh <CHECKPOINTS_ROOT>/scripts/run-checkpoint.sh "<type>: <concise description>"
```

## 3) App-specific examples

### Codex (Desktop/CLI)

Codex supports `AGENTS.md` instructions in the workspace.

1. In your project repo, add an `AGENTS.md` that references Checkpoints:
   ```text
   Follow /absolute/path/to/checkpoints/AGENTS.md for git workflows.
   ```
2. Keep `CHECKPOINTS_ROOT` available in your shell/environment:
   ```sh
   export CHECKPOINTS_ROOT="/absolute/path/to/checkpoints"
   ```

### Cursor

Use a project rule file, for example `.cursor/rules/checkpoints.mdc`:

```text
Follow /absolute/path/to/checkpoints/AGENTS.md for all git workflows.
Use single-line conventional commit subjects only.
Never add Co-Authored-By or AI attribution lines.
```

### Claude Code

Add to `CLAUDE.md` in your project:

```text
Follow /absolute/path/to/checkpoints/AGENTS.md for git workflows.
```

Or install this repo as a Claude plugin (see `README.md`).

### Aider

Pass the instructions file when starting sessions:

```sh
aider --read "$CHECKPOINTS_ROOT/AGENTS.md"
```

If you use an aider config file, add this file to its startup read list.

### Cline

Add the standard instruction snippet to Cline's project custom instructions
or your repository instruction file.

### GitHub Copilot (Chat/Agent modes)

Add a project instruction file at `.github/copilot-instructions.md`:

```text
Follow /absolute/path/to/checkpoints/AGENTS.md for git workflows.
Use single-line conventional commit subjects only.
Never add Co-Authored-By or AI attribution lines.
```

## 4) Verification

Run from any repo:

```sh
git config --get core.hooksPath
```

Expected value:

```text
/absolute/path/to/checkpoints/githooks
```
