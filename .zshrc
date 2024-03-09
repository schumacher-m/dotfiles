export TERM="xterm-256color"
ZSH_TMUX_AUTOSTART=false
[[ $TMUX == "" ]] && tmux new-session -A -s 0
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

source ~/.znap/zsh-snap/znap.zsh
znap source ohmyzsh/ohmyzsh
znap source ohmyzsh/ohmyzsh plugins/{git,thefuck,direnv,fzf,1password}
znap source asdf-vm/asdf
znap source romkatv/powerlevel10k
znap source zsh-users/zsh-autosuggestions
znap source joshskidmore/zsh-fzf-history-search
znap source DarrinTisdale/zsh-aliases-exa
znap source ajeetdsouza/zoxide

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export HISTSIZE=1000000000
export SAVEHIST=1000000000
alias e='emacsclient -t'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
