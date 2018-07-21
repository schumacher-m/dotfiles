dotfiles
========

We all need them!

# Recovery

* `git clone git@github.com:schumacher-m/dotfiles.git`
* `cp -r dotfiles/.[^.]* ~/`
* `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* `xargs brew install < brew-list`
* `rbenv install 2.5.0`
* `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
* `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
* `vim +PluginInstall +qall`
* `~/.vim/bundle/YouCompleteMe/install.py --clang-completer --go-completer --rust-completer --js-completer`
* `gem install neovim`
* `npm update -f neovim`
* `pip install --upgrade neovim`
* `pip3 install --upgrade neovim`
