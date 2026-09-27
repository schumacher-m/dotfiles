# macOS dotfiles

Personal shell, terminal, Git, editor, and tmux configuration for macOS.

The setup uses four package sources:

- [Homebrew](https://brew.sh/) installs shared packages from `Brewfile` plus the selected `Brewfile.default` or `Brewfile.work` profile.
- [znap](https://github.com/marlonrichert/zsh-snap) installs and updates the Zsh plugins declared in `.zshrc`.
- [tmux](https://github.com/tmux/tmux) is installed by Homebrew.
- [TPM](https://github.com/tmux-plugins/tpm) installs the tmux plugins declared in `.tmux.conf`.

## Fast setup

Clone the repository, then run:

```sh
git clone https://github.com/schumacher-m/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
make setup
```

`make setup` will:

1. Install Homebrew when it is not already available.
2. Install the shared and selected-profile Homebrew packages, including tmux, Gitleaks, and Pi.
3. Create `~/.zshenv.secrets` with restrictive permissions if it does not exist.
4. Link the tracked configuration files and local helper scripts into your home directory.
5. Clone znap and run `znap pull` to install or update Zsh plugins.
6. Clone TPM and install the plugins from `.tmux.conf`.

Existing files are moved to `~/.dotfiles-backup/<timestamp>/` before links are
created. The command is safe to run again; links that already point at this
repository are left unchanged.

After setup, start a new login shell:

```sh
exec zsh -l
```

Alacritty attaches to or creates the `main` tmux session directly. Other Zsh
shells do not start tmux automatically.

## Copilot and Pi models and agents

Start GitHub Copilot CLI with:

```sh
copilot
```

The tracked Copilot settings use `gpt-5.6-sol` with `high` reasoning and keep
the current terminal, footer, and attribution preferences. Copilot stores the
per-agent reasoning settings in `.copilot/settings.json`.

Copilot applies those reasoning settings when it dispatches an agent as a
subagent. In Copilot CLI 1.0.73, selecting a custom agent as the top-level
session agent applies its model but retains the session's reasoning effort; use
`--effort` when starting that kind of session if a different level is needed.

Delegated work uses model-specific agents:

| Agent | Model | Reasoning | Responsibility |
| --- | --- | --- | --- |
| Built-in worker/build agent | `gpt-5.6-sol` | `medium` | TDD implementation and focused fixes |
| `explorer` | `gpt-5.6-terra` | `medium` | Read-only repository mapping and evidence gathering |
| `test_runner` | `gpt-5.6-terra` | `medium` | Existing tests, builds, health checks, and condensed failure evidence without source edits |
| `reviewer` | `gpt-5.6-sol` | `high` | Correctness, security, concurrency, regression, and test review |
| `docs_researcher` | `gpt-5.6-terra` | `low` | Primary documentation and version-specific API verification |
| `batch_worker` | `gpt-5.6-luna` | `medium` | High-volume execution of an agreed, bounded plan |

Luna is intentionally not used for planning, architecture, ambiguous work, or
ordinary one-off changes. Use `batch_worker` only after the design has converged
into a clear, agreed plan and the remaining workload is large, repetitive,
well-bounded, and divisible into independently owned items. If the work still
requires material judgment or changing the plan, keep it on Sol or Terra.

Subagent fan-out is capped at three threads and one level of nesting to keep
cost and coordination predictable. The model choices follow OpenAI's current
[GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model.md).

Copilot may select the five converted custom agents automatically. Its
`git-commit` agent is manual-only because it generates message text without
creating a commit; use the shared `/conventional-commit` skill in Copilot for an actual
reviewed commit workflow.

### LM Studio

Pi has no named profiles. The LM Studio provider lives in `.pi/agent/models.json`:

```sh
pi --provider lmstudio-lan --model qwen/qwen3.8-27b
```

The model is `qwen/qwen3.8-27b` through the OpenAI-compatible LM Studio server at
`http://192.168.178.122:1234/v1` and does not require authentication.

`.lmstudio/config-presets/Qwen 3 8.preset.json` is the tracked load and sampling
preset for that model. `make link` installs it at
`~/.lmstudio/config-presets/Qwen 3 8.preset.json`. Other LM Studio state stays
machine-owned.

## Personal agent guidance and skills

The repository versions personal Copilot and Pi behavior separately from their
shared reusable workflows:

- `.copilot/settings.json` contains Copilot's user-editable preferences and subagent settings.
- `.copilot/agents/` contains Copilot versions of the delegated roles plus the manual `git-commit` agent.
- `.copilot/copilot-instructions.md` adapts the personal development guidance and skill routing for Copilot.
- `.pi/agent/settings.json` contains Pi defaults, packages, and enabled models. The work profile links `.pi/agent/settings.work.json` there instead.
- `.pi/agent/models.json` contains the LM Studio provider for Pi.
- `.lmstudio/config-presets/Qwen 3 8.preset.json` is the tracked Qwen 3.8 preset.
- `AGENTS.md` contains setup and configuration rules specific to this repository.
- `.agents/skills/` is the shared source of personal skills for Copilot and Pi.

`make setup` includes these through `make link`. Global guidance and settings
are linked to each tool's directory; each custom Copilot agent is linked
individually under `~/.copilot/agents/`; and each shared skill is linked under
`~/.agents/skills/`. Linking files individually preserves installations not
managed by this repository.

Copilot's `config.json`, Pi auth, sessions, logs, packages, and caches, and the
rest of `~/.lmstudio` remain machine-owned and untracked.

The starter skills are:

- `$design-together` challenges ideas and converges on a design before implementation.
- `$diagnose-runtime` finds evidence-backed root causes without changing the system.
- `$review-architecture` assesses architecture, preserves sound decisions, and recommends proportionate structural improvements.
- `$develop-with-tdd` implements behavior through small red-green-refactor iterations.
- `$conventional-commit` reviews and commits only the intended local changes.
- `$verify-change` validates changes with project-native checks and runtime evidence.
- `$bootstrap-repository` builds reproducible setup automation and onboarding documentation.

The global guidance limits the unmanaged Graphify skill to explicit knowledge-graph
requests so ordinary repository questions stay lightweight.

Edit the tracked guidance, agents, settings, or skills in this repository and
rerun `make link` to install them on another machine. Copilot discovers the
shared skills directly from `~/.agents/skills/`; tool-specific skill copies are
not needed.

## Useful targets

```sh
make help       # list available targets
make setup      # complete macOS setup (default profile)
make setup PROFILE=work
make brew       # install or reconcile the default Homebrew profile
make brew PROFILE=work
make secrets    # create ~/.zshenv.secrets if it is missing
make link       # link configuration into $HOME
make znap       # install/update znap and Zsh plugins
make tmux       # install/update TPM plugins
make check      # scan Git history and the working tree for secrets
```

## Sensitive-value checks

Put environment secrets in `~/.zshenv.secrets`. The file is sourced by
`.zshenv`, is not tracked by Git, and is never replaced by `make setup` when it
already exists.

The shared `.zshenv` and `.zshrc` source `~/.zshenv.profile` and
`~/.zshrc.profile`. `make link` points them at the default profiles.
`PROFILE=work` selects the work Homebrew and Zsh profiles together; use
`ZSHENV_PROFILE=work make link` to switch only Zsh.

The `git cma` alias runs `~/.local/bin/git-cma`, which asks `pi` for a
conventional commit message from the staged diff and commits it. It uses
your current `pi` model at low thinking. The personal profile starts Pi on
`xai/grok-4.7` and also selects the LM Studio model. The work profile starts
Pi on GitHub Copilot `gpt-6-sol` and also selects `gpt-6-luna`. `git cma`
still uses Luna on the work profile. Override with `GIT_CMA_MODEL`:

```sh
GIT_CMA_MODEL=xai/grok-4.7 git cma
```

`make check` uses [Gitleaks](https://github.com/gitleaks/gitleaks). It scans both
Git history and the current working tree for credentials, tokens, private keys,
and other suspicious values. Gitleaks is recommended here because it is fast,
works locally, and is available through Homebrew.

Run the check before pushing changes:

```sh
make check
```

If a finding is intentional, add the narrowest possible allowlist rule in a
repo-local `.gitleaks.toml`; do not add real credentials to the repository.

## Manual plugin controls

```sh
znap pull
~/.tmux/plugins/tpm/bin/install_plugins
~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins
```
