zstyle ':omz:update' mode disabled

source "$HOME/.znap/zsh-snap/znap.zsh"

znap source ohmyzsh/ohmyzsh
znap source ohmyzsh/ohmyzsh plugins/{tmux,gh,git,thefuck,direnv,fzf,1password,aliases,jj,mise}
znap source zsh-users/zsh-autosuggestions
znap source DarrinTisdale/zsh-aliases-exa
znap eval zoxide 'zoxide init zsh'
znap eval atuin 'atuin init zsh'

HISTSIZE=100000
SAVEHIST=100000

alias ee='emacs -nw'
alias e='emacsclient -t'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
[[ -r "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"

[[ -r "$HOME/.zshrc.profile" ]] && source "$HOME/.zshrc.profile"

znap eval starship 'starship init zsh'
