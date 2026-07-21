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
2. Install the shared and selected-profile Homebrew packages, including tmux and Gitleaks.
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

## Codex models and agents

Start Codex with the personal pair-programming profile:

```sh
codex --profile personal
```

The profile uses `gpt-5.6-sol` with `medium` reasoning. This keeps the main
pair-programming thread capable enough for design and implementation without
paying the latency and token cost of maximum reasoning on every turn. Plan mode
keeps the same model and raises reasoning to `high` for architecture and
consequential design work. Approval remains `on-request` with a
`workspace-write` sandbox.

Use the maximum-reasoning profile only for exceptional quality-first work:

```sh
codex --profile max
```

This selects `gpt-5.6-sol` with `max` reasoning for both normal and plan mode.

Delegated work uses model-specific agents:

| Agent | Model | Reasoning | Responsibility |
| --- | --- | --- | --- |
| Built-in `worker` | `gpt-5.6-sol` | `medium` | TDD implementation and focused fixes |
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
[GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model.md)
and [Codex subagent guidance](https://learn.chatgpt.com/docs/agent-configuration/subagents#choosing-models-and-reasoning).

### LM Studio profile

Run Codex against the LAN-hosted LM Studio model with:

```sh
codex --profile lmstudio
```

The profile uses `qwen/qwen3.6-35b-a3b` through the OpenAI-compatible LM Studio
server at `http://192.168.178.122:1234/v1` and does not require authentication.

## Personal Codex guidance and skills

The repository versions personal Codex behavior separately from reusable
workflows:

- `.codex/*.config.toml` contains explicit profiles without tracking Codex's
  mutable user config.
- `.codex/agents/` defines delegated models and roles.
- `.codex/AGENTS.md` contains concise development preferences that apply across repositories.
- `AGENTS.md` contains setup and configuration rules specific to this repository.
- `.agents/skills/` contains personal skills for repeatable workflows.

`make setup` includes these through `make link`. The global guidance is linked
to `~/.codex/AGENTS.md`, profiles are linked as `~/.codex/*.config.toml`, each
custom agent is linked under `~/.codex/agents/`, and each skill is linked
individually under `~/.agents/skills/`. The mutable `~/.codex/config.toml`
remains a regular machine-local file owned by Codex. Linking agents and skills
individually preserves installations not managed by this repository.

The starter skills are:

- `$design-together` challenges ideas and converges on a design before implementation.
- `$diagnose-runtime` finds evidence-backed root causes without changing the system.
- `$develop-with-tdd` implements behavior through small red-green-refactor iterations.
- `$conventional-commit` reviews and commits only the intended local changes.
- `$verify-change` validates changes with project-native checks and runtime evidence.
- `$bootstrap-repository` builds reproducible setup automation and onboarding documentation.

The global guidance limits the unmanaged Graphify skill to explicit knowledge-graph
requests so ordinary repository questions stay lightweight.

Edit the tracked guidance or skills in this repository and rerun `make link` to
install them on another machine.

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

The `git cma` alias generates a conventional commit message for the staged
changes and commits them. The default Zsh profile uses Codex CLI with
`gpt-5.6-terra`; the work profile uses Copilot CLI with `claude-haiku-4.5`.
Override either choice for one command with environment variables:

```sh
GIT_CMA_CLI=codex GIT_CMA_MODEL=gpt-5.6-terra git cma
GIT_CMA_CLI=copilot GIT_CMA_MODEL=claude-haiku-4.5 git cma
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
