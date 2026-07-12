# macOS dotfiles

Personal shell, terminal, Git, editor, and tmux configuration for macOS.

The setup uses four package sources:

- [Homebrew](https://brew.sh/) installs command-line tools and applications from `Brewfile`.
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
2. Install everything in `Brewfile`, including tmux and Gitleaks.
3. Link the tracked configuration files into your home directory.
4. Clone znap and run `znap pull` to install or update Zsh plugins.
5. Clone TPM and install the plugins from `.tmux.conf`.

Existing files are moved to `~/.dotfiles-backup/<timestamp>/` before links are
created. The command is safe to run again; links that already point at this
repository are left unchanged.

After setup, start a new login shell:

```sh
exec zsh -l
```

## Useful targets

```sh
make help       # list available targets
make setup      # complete macOS setup
make brew       # install or reconcile Brewfile packages
make link       # link configuration into $HOME
make znap       # install/update znap and Zsh plugins
make tmux       # install/update TPM plugins
make check      # scan Git history and the working tree for secrets
```

## Sensitive-value checks

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
