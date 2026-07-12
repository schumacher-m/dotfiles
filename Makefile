SHELL := /bin/bash

DOTFILES := $(CURDIR)
BACKUP_ROOT := $(HOME)/.dotfiles-backup
BREW_PREFIX := $(if $(filter arm64,$(shell uname -m)),/opt/homebrew,/usr/local)
export PATH := $(BREW_PREFIX)/bin:$(BREW_PREFIX)/sbin:$(PATH)

ROOT_FILES := \
	.alacritty.toml \
	.gitconfig \
	.mise.toml \
	.tmux.conf \
	.zshenv \
	.zshrc

CONFIG_FILES := \
	.config/doom/config.el \
	.config/doom/init.el \
	.config/doom/packages.el \
	.config/helix/config.toml \
	.config/starship.toml

.DEFAULT_GOAL := help
.PHONY: help setup homebrew brew link znap tmux check

help: ## Show the available targets
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*## / {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Install packages, link dotfiles, and install shell/tmux plugins
	@$(MAKE) homebrew
	@$(MAKE) brew
	@$(MAKE) link
	@$(MAKE) znap
	@$(MAKE) tmux
	@printf '\nSetup complete. Start a new login shell with: exec zsh -l\n'

homebrew: ## Install Homebrew if it is missing
	@if command -v brew >/dev/null 2>&1; then \
		printf 'Homebrew is already installed.\n'; \
	else \
		printf 'Installing Homebrew...\n'; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi

brew: ## Install or reconcile packages from Brewfile
	@brew_cmd="$$(command -v brew 2>/dev/null || true)"; \
	if [[ -z "$$brew_cmd" && -x /opt/homebrew/bin/brew ]]; then brew_cmd=/opt/homebrew/bin/brew; fi; \
	if [[ -z "$$brew_cmd" && -x /usr/local/bin/brew ]]; then brew_cmd=/usr/local/bin/brew; fi; \
	if [[ -z "$$brew_cmd" ]]; then printf 'Homebrew is missing; run make homebrew first.\n' >&2; exit 1; fi; \
	"$$brew_cmd" bundle --file="$(DOTFILES)/Brewfile"

link: ## Link tracked configuration files into the home directory
	@set -euo pipefail; \
	backup_dir="$(BACKUP_ROOT)/$$(date +%Y%m%d-%H%M%S)"; \
	link_one() { \
		rel="$$1"; src="$(DOTFILES)/$$rel"; dest="$(HOME)/$$rel"; \
		if [[ -L "$$dest" && "$$(readlink "$$dest")" == "$$src" ]]; then \
			printf 'linked  %s\n' "$$rel"; return; \
		fi; \
		if [[ -e "$$dest" || -L "$$dest" ]]; then \
			mkdir -p "$$backup_dir/$$(dirname "$$rel")"; \
			mv "$$dest" "$$backup_dir/$$rel"; \
			printf 'backup  %s -> %s\n' "$$rel" "$$backup_dir/$$rel"; \
		fi; \
		mkdir -p "$$(dirname "$$dest")"; \
		ln -s "$$src" "$$dest"; \
		printf 'linked  %s\n' "$$rel"; \
	}; \
	for rel in $(ROOT_FILES) $(CONFIG_FILES); do link_one "$$rel"; done

znap: ## Install znap and install/update Zsh plugins
	@set -euo pipefail; \
	if [[ ! -r "$(HOME)/.znap/zsh-snap/znap.zsh" ]]; then \
		mkdir -p "$(HOME)/.znap"; \
		git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git "$(HOME)/.znap/zsh-snap"; \
	fi; \
	DOTFILES="$(DOTFILES)" zsh -dfi -c 'source "$$DOTFILES/.zshrc" && znap pull'

tmux: ## Install TPM and install/update tmux plugins
	@set -euo pipefail; \
	if [[ ! -x "$(HOME)/.tmux/plugins/tpm/bin/install_plugins" ]]; then \
		mkdir -p "$(HOME)/.tmux/plugins"; \
		git clone --depth 1 https://github.com/tmux-plugins/tpm "$(HOME)/.tmux/plugins/tpm"; \
	fi; \
	"$(HOME)/.tmux/plugins/tpm/bin/install_plugins"; \
	"$(HOME)/.tmux/plugins/tpm/bin/update_plugins" all; \
	"$(HOME)/.tmux/plugins/tpm/bin/clean_plugins"

check: ## Scan Git history and the working tree for credentials and secrets
	@command -v gitleaks >/dev/null 2>&1 || { \
		printf 'Gitleaks is missing. Install it with: brew install gitleaks\n' >&2; \
		exit 1; \
	}
	gitleaks git --redact --verbose .
	gitleaks dir --redact --verbose .
