ZSH_TMUX_AUTOSTART=true
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

source ~/.znap/zsh-snap/znap.zsh

znap source ohmyzsh/ohmyzsh
znap source ohmyzsh/ohmyzsh plugins/{tmux,aws,gh,git,thefuck,direnv,fzf,1password,aliases,jj,mise}
znap source zsh-users/zsh-autosuggestions
znap source DarrinTisdale/zsh-aliases-exa
znap source ajeetdsouza/zoxide
znap source wintermi/zsh-mise
znap source atuinsh/atuin

export HISTSIZE=1000000000
export SAVEHIST=1000000000
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
export ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=1
export ZSH_FZF_HISTORY_SEARCH_FZF_ARGS="-i -x --preview-window=hidden --height=20% --layout=reverse"

alias ee='emacs -nw'
alias e='emacsclient -t'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

eval "$(starship init zsh)"
