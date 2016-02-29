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

ZSH_TMUX_AUTOSTART=false
plugins=(pass git autojump brew bundler coffee compleat dircycle gem node npm osx redis-cli rbenv tmux docker docker-compose)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/Cellar/ctags/5.8/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias bower='noglob bower'
alias gg='noglob gg'

export DOCKER_CERT_PATH=/Users/m/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
#export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem
export HIVE_HOME=/usr/local/Cellar/hive/1.2.1/libexec
export HCAT_HOME=/usr/local/Cellar/hive/1.2.1/libexec/hcatalog
export JAVA_HOME="$(/usr/libexec/java_home)"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

echo "Getting status of docker-machine:crealytics ..."
DOCKER_CREALYTICS_STATUS="$(docker-machine status crealytics)"

if [ $DOCKER_CREALYTICS_STATUS != "Running" ]
then
  echo "docker-machine not running. Starting ..."
  docker-machine start crealytics
fi

eval "$(docker-machine env crealytics)"
eval $(thefuck --alias)
eval "$(rbenv init -)"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='%T ${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

schedprompt() {
  emulate -L zsh
  zmodload -i zsh/sched

  # Remove existing event, so that multiple calls to
  # "schedprompt" work OK.  (You could put one in precmd to push
  # the timer 30 seconds into the future, for example.)
  integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
  (( i )) && sched -$i

  # Test that zle is running before calling the widget (recommended
  # to avoid error messages).
  # Otherwise it updates on entry to zle, so there's no loss.
  zle && zle reset-prompt

  # This ensures we're not too far off the start of the minute
  sched +30 schedprompt
}

schedprompt

source ~/.nvm/nvm.sh

PATH="/Users/m/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/Users/m/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/m/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/m/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/m/perl5"; export PERL_MM_OPT;
