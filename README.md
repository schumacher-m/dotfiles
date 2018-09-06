dotfiles
========

We all need them!

# Recovery

* `git clone git@github.com:schumacher-m/dotfiles.git`
* `cp -r dotfiles/.[^.]* ~/`
* `xargs brew install < brew-list`
* `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
* `git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k`

# Recovery: Optional
* `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* `rbenv install 2.5.0`

# Spacemacs

* `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
* `cp -r .emacs.d/private/* ~/.emacs.d/private/`
* `brew services start emacs`

# Vim (Deprecated)

* `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
* `vim +PluginInstall +qall`
* `~/.vim/bundle/YouCompleteMe/install.py --clang-completer --go-completer --rust-completer --js-completer`
* `gem install neovim`
* `npm update -f neovim`
* `pip install --upgrade neovim`
* `pip3 install --upgrade neovim`
