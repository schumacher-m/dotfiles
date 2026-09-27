# Dotfiles repository guidance

## Workflow

- Inspect `git status` before changing files and preserve unrelated user work.
- Use the existing `Makefile` targets instead of duplicating setup commands in prose or scripts.
- Run `make check` after changes that affect tracked configuration or setup behavior.

## Configuration boundaries

- Keep shared Homebrew packages in `Brewfile` and profile-specific packages in `Brewfile.default` or `Brewfile.work`.
- Keep `~/.pi/agent/auth.json`, session data, and Copilot's `config.json` machine-owned and untracked.
- Keep cross-repository personal guidance in `.copilot/copilot-instructions.md`; keep rules specific to this repository in this file.
- Install tracked dotfiles, Copilot/Pi settings, agents, skills, and the LM Studio presets with `make link`; preserve unmanaged skills and local state.
- Work profile Pi model selection lives in `.pi/agent/settings.work.json`. `ZSHENV_PROFILE=work make link` installs that file as `~/.pi/agent/settings.json`. The default profile keeps `.pi/agent/settings.json`.
- Keep LM Studio conversations, credentials, and other `~/.lmstudio` state machine-owned. Only the Qwen 3.8 and Qwen3 Coder Next presets under `.lmstudio/config-presets/` are tracked.
- Never add secrets, authentication tokens, or machine-generated agent state to the repository.
