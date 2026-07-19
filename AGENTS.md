# AGENTS.md

Personal dotfiles for macOS, managed with GNU Stow.

## Structure

- Repo root mirrors `$HOME` (`.stowrc` sets `--target=$HOME`)
- Files in this repo are symlinked into `$HOME` by running `stow .` from the repo root
- `.stow-local-ignore` excludes repo-only files (README.md, install.sh, AGENTS.md) and tool state

## Adding a new dotfile

1. Move the file from `$HOME` into the repo at the same relative path (e.g. `~/.config/foo/config` → `.config/foo/config`)
2. Run `stow .` from the repo root
3. Verify the `$HOME` path is now a symlink into the repo

## What belongs here

Track: hand-maintained config a human edits deliberately (shell, git, editor, terminal configs).

Do NOT track:
- Secrets or tokens (e.g. `~/.config/gh/hosts.yml` contains an OAuth token — never commit it)
- AI tooling state: `.claude/`, `.commandcode/`, `.claude.json` — excluded via `.stow-local-ignore` and `.gitignore`
- Generated caches/state: `.zcompdump*`, `.zsh_history`, etc.
- Third-party installs: `.oh-my-zsh` (installed by `install.sh`)
- App runtime data (models, logs, workspaces, e.g. `~/.omlx`, `~/.openhands`, `~/.pi`)

## Gotchas

- `gh` regenerates `~/.config/gh/config.yml` when missing and may replace the symlink when writing config. If the `co` alias breaks or config drifts, re-run `stow .`
- Stow aborts all operations on any conflict — check for real files at target paths before stowing
