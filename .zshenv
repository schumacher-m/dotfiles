typeset -U path PATH

if [[ -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
elif [[ -d /usr/local/bin ]]; then
  path=(/usr/local/bin /usr/local/sbin $path)
fi

[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
path=(
  "$HOME/.local/bin"
  "$HOME/.config/emacs/bin"
  $path
)

[[ -r "$HOME/.zshenv.profile" ]] && source "$HOME/.zshenv.profile"
[[ -r "$HOME/.zshenv.secrets" ]] && source "$HOME/.zshenv.secrets"
