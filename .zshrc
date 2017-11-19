# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

ZSH_TMUX_AUTOSTART=true
plugins=(pass git autojump bundler compleat dircycle gem rbenv tmux docker docker-compose sbt thefuck zsh-iterm-touchbar)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/Cellar/ctags/5.8/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin:/Users/m/.cargo/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
export NVM_BREW_DIR="/usr/local/opt/nvm"
[ -s "$NVM_BREW_DIR/nvm.sh"  ] && . "$NVM_BREW_DIR/nvm.sh" # This loads nvm

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval $(thefuck --alias)
eval "$(rbenv init -)"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: } # display it
  echo ${output#*session: } | pbcopy # and copy it to clipboard

}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
