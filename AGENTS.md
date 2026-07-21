# Dotfiles repository guidance

## Workflow

- Inspect `git status` before changing files and preserve unrelated user work.
- Use the existing `Makefile` targets instead of duplicating setup commands in prose or scripts.
- Run `make check` after changes that affect tracked configuration or setup behavior.
- Run the official Codex skill validator after changing anything under `.agents/skills/`.

## Configuration boundaries

- Keep shared Homebrew packages in `Brewfile` and profile-specific packages in `Brewfile.default` or `Brewfile.work`.
- Keep `~/.codex/config.toml` machine-owned and untracked. Version reusable profiles under `.codex/*.config.toml` instead.
- Keep cross-repository personal guidance in `.codex/AGENTS.md`; keep rules specific to this repository in this file.
- Install tracked dotfiles, Codex profiles, agents, and skills with `make link`; preserve unmanaged skills and local state.
- Never add secrets, authentication tokens, or machine-generated Codex state to the repository.

