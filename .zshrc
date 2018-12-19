export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"

ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
ZSH_TMUX_AUTOSTART=false
[[ $TMUX == "" ]] && tmux new-session -A -s 0
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# P9K Config: https://github.com/bhilburn/powerlevel9k/issues/501
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

eval "$(direnv hook zsh)"

source <(antibody init)
antibody bundle < ~/.zsh_plugins

alias vim='emacsclient -nw '
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

function tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: }
  echo ${output#*session: } | pbcopy
}
