export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"
ZSH_TMUX_AUTOSTART=false
[[ $TMUX == "" ]] && tmux new-session -A -s 0
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

zstyle ':znap:*' git-dir ~/.znap
source ~/.znap/zsh-snap/znap.zsh

znap source ohmyzsh/ohmyzsh
znap source ohmyzsh/ohmyzsh plugins/{git,autojump,thefuck,direnv}
znap source kiurchv/asdf.plugin.zsh
znap source romkatv/powerlevel10k
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source zdharma/fast-syntax-highlighting

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

alias e='emacsclient -t'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



function tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: }
  echo ${output#*session: } | pbcopy
}
