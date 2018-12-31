export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
ZSH_TMUX_AUTOSTART=false
[[ $TMUX == "" ]] && tmux new-session -A -s 0
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# P9K Config: https://github.com/bhilburn/powerlevel9k/issues/501
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

source <(antibody init)
antibody bundle < ~/.zsh_plugins

eval "$(direnv hook zsh)"

alias vim='emacsclient -nw '
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

function tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: }
  echo ${output#*session: } | pbcopy
}
