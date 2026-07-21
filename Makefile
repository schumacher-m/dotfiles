SHELL := /bin/bash

DOTFILES := $(CURDIR)
BACKUP_ROOT := $(HOME)/.dotfiles-backup
PROFILE ?= default
BREWFILE := $(DOTFILES)/Brewfile.$(PROFILE)
ZSHENV_PROFILE ?= $(PROFILE)
ZSHENV_FILE := $(DOTFILES)/.zshenv.$(ZSHENV_PROFILE)
ZSHRC_FILE := $(DOTFILES)/.zshrc.$(ZSHENV_PROFILE)
BREW_PREFIX := $(if $(filter arm64,$(shell uname -m)),/opt/homebrew,/usr/local)
export PATH := $(BREW_PREFIX)/bin:$(BREW_PREFIX)/sbin:$(PATH)

ROOT_FILES := \
	.gitconfig \
	.tmux.conf \
	.zshenv \
	.zshrc

CONFIG_FILES := \
	.config/alacritty/alacritty.toml \
	.config/atuin/config.toml \
	.config/doom/config.el \
	.config/doom/init.el \
	.config/doom/packages.el \
	.config/helix/config.toml \
	.config/mise/config.toml \
	.config/starship.toml

BIN_FILES := \
	.local/bin/tmux-window-name

CODEX_FILES := \
	.codex/AGENTS.md \
	.codex/lmstudio.config.toml \
	.codex/max.config.toml \
	.codex/personal.config.toml

COPILOT_FILES := \
	.copilot/copilot-instructions.md \
	.copilot/settings.json

CODEX_AGENTS_DIR := .codex/agents
COPILOT_AGENTS_DIR := .copilot/agents
CODEX_SKILLS_DIR := .agents/skills

.DEFAULT_GOAL := help
.PHONY: help setup homebrew brew secrets link znap tmux check

help: ## Show the available targets
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*## / {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Install packages, link dotfiles, and install shell/tmux plugins
	@$(MAKE) homebrew
	@$(MAKE) brew
	@$(MAKE) secrets
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

brew: ## Install or reconcile packages (PROFILE=default|work)
	@brew_cmd="$$(command -v brew 2>/dev/null || true)"; \
	if [[ ! -f "$(BREWFILE)" ]]; then printf 'Unknown Homebrew profile: %s\n' "$(PROFILE)" >&2; exit 1; fi; \
	if [[ -z "$$brew_cmd" && -x /opt/homebrew/bin/brew ]]; then brew_cmd=/opt/homebrew/bin/brew; fi; \
	if [[ -z "$$brew_cmd" && -x /usr/local/bin/brew ]]; then brew_cmd=/usr/local/bin/brew; fi; \
	if [[ -z "$$brew_cmd" ]]; then printf 'Homebrew is missing; run make homebrew first.\n' >&2; exit 1; fi; \
	"$$brew_cmd" bundle --file="$(BREWFILE)"

secrets: ## Create the local Zsh secrets file if it is missing
	@secrets_file="$(HOME)/.zshenv.secrets"; \
	if [[ -e "$$secrets_file" || -L "$$secrets_file" ]]; then \
		printf 'exists  %s\n' "$$secrets_file"; \
	else \
		printf '%s\n' '# Add environment secrets here. This file is intentionally not tracked by Git.' > "$$secrets_file"; \
		chmod 600 "$$secrets_file"; \
		printf 'created %s\n' "$$secrets_file"; \
	fi

link: ## Link dotfiles and personal Codex/Copilot configuration
	@set -euo pipefail; \
	if [[ ! -f "$(ZSHENV_FILE)" ]]; then printf 'Unknown Zsh profile: %s\n' "$(ZSHENV_PROFILE)" >&2; exit 1; fi; \
	if [[ ! -f "$(ZSHRC_FILE)" ]]; then printf 'Unknown Zsh profile: %s\n' "$(ZSHENV_PROFILE)" >&2; exit 1; fi; \
	backup_dir="$(BACKUP_ROOT)/$$(date +%Y%m%d-%H%M%S)"; \
	link_one() { \
		rel="$$1"; dest_rel="$${2:-$$rel}"; src="$(DOTFILES)/$$rel"; dest="$(HOME)/$$dest_rel"; \
		if [[ -L "$$dest" && "$$(readlink "$$dest")" == "$$src" ]]; then \
			printf 'linked  %s -> %s\n' "$$dest_rel" "$$rel"; return; \
		fi; \
		if [[ -e "$$dest" || -L "$$dest" ]]; then \
			mkdir -p "$$backup_dir/$$(dirname "$$dest_rel")"; \
			mv "$$dest" "$$backup_dir/$$dest_rel"; \
			printf 'backup  %s -> %s\n' "$$dest_rel" "$$backup_dir/$$dest_rel"; \
		fi; \
		mkdir -p "$$(dirname "$$dest")"; \
		ln -s "$$src" "$$dest"; \
		printf 'linked  %s -> %s\n' "$$dest_rel" "$$rel"; \
	}; \
	for rel in $(ROOT_FILES) $(CONFIG_FILES) $(BIN_FILES) $(CODEX_FILES) $(COPILOT_FILES); do link_one "$$rel"; done; \
	for agent_src in "$(DOTFILES)/$(CODEX_AGENTS_DIR)"/*; do \
		[[ -f "$$agent_src" ]] || continue; \
		agent_name="$${agent_src##*/}"; \
		link_one "$(CODEX_AGENTS_DIR)/$$agent_name" ".codex/agents/$$agent_name"; \
	done; \
	for agent_src in "$(DOTFILES)/$(COPILOT_AGENTS_DIR)"/*; do \
		[[ -f "$$agent_src" ]] || continue; \
		agent_name="$${agent_src##*/}"; \
		if [[ "$$agent_name" == *.agent.md ]]; then \
			legacy_name="$${agent_name%.agent.md}.md"; \
			legacy_rel=".copilot/agents/$$legacy_name"; \
			legacy_dest="$(HOME)/$$legacy_rel"; \
			legacy_src="$(DOTFILES)/$$legacy_rel"; \
			if [[ -L "$$legacy_dest" && "$$(readlink "$$legacy_dest")" == "$$legacy_src" ]]; then \
				mkdir -p "$$backup_dir/$$(dirname "$$legacy_rel")"; \
				mv "$$legacy_dest" "$$backup_dir/$$legacy_rel"; \
				printf 'backup  %s -> %s\n' "$$legacy_rel" "$$backup_dir/$$legacy_rel"; \
			fi; \
		fi; \
		link_one "$(COPILOT_AGENTS_DIR)/$$agent_name" ".copilot/agents/$$agent_name"; \
	done; \
	for skill_src in "$(DOTFILES)/$(CODEX_SKILLS_DIR)"/*; do \
		[[ -d "$$skill_src" ]] || continue; \
		skill_name="$${skill_src##*/}"; \
		link_one "$(CODEX_SKILLS_DIR)/$$skill_name" ".agents/skills/$$skill_name"; \
	done; \
	link_one ".zshenv.$(ZSHENV_PROFILE)" ".zshenv.profile"; \
	link_one ".zshrc.$(ZSHENV_PROFILE)" ".zshrc.profile"

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
