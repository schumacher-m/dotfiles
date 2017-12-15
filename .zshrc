export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_TMUX_AUTOSTART="true"

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle autojump
antigen bundle tmux
antigen bundle thefuck
antigen bundle rbenv
antigen bundle docker
antigen bundle docker-compose
antigen bundle bundler
antigen bundle ruby
antigen bundle rust
antigen bundle rake-fast
antigen bundle brew

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle fcambus/ansiweather

antigen theme robbyrussell

antigen apply

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.chefdk/gem/ruby/2.4.0/bin:$PATH"
export PATH="$HOME/.cargo/RustDT/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

eval "$(rbenv init -)"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

tmateip () {
  output=$(tmate show-message | grep -m 1 "ssh session:")
  echo ${output#*session: }
  echo ${output#*session: } | pbcopy
}

stty icrnl
