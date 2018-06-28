export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_TMUX_AUTOSTART=true
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

source <(antibody init)
antibody bundle < ~/.zsh_plugins

eval "$(rbenv init --no-rehash -)"

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.chefdk/gem/ruby/2.4.0/bin:$PATH"
export PATH="$HOME/.cargo/RustDT/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/Library/Python/3.6/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="/usr/local/opt/python@2/bin:$PATH"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

function tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: }
  echo ${output#*session: } | pbcopy
}

function vim() {
  if test $# -gt 0; then
    env nvim "$@"
  else
    env nvim -c "Prosession $(pwd)"
  fi
}

stty icrnl
