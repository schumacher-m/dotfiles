dotfiles
========

We all need them!

# Recovery

* `git clone git@github.com:schumacher-m/dotfiles.git`
* `cp -r dotfiles/.[^.]* ~/`
* `git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.znap`
* `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
* `git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch HEAD`
* `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
* `asdf plugin-add python`
* `asdf plugin-add nodejs`
* `asdf plugin-add rust`
* `asdf install`
* `pip install pipenv`

# PIP

## Export
`pip freeze > ~/workspace/dotfiles/requirements.txt`

## Import
`pip install -r ~/workspace/dotfiles/requirements.txt`

## Upgrade
`pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U`

# Spacemacs

* `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`

# Emacs

* `brew tap d12frosted/emacs-plus`
* `brew install emacs-plus@29 --with-native-comp`

# Alacritty

* `brew install alacritty`

# Fonts

* `brew tap homebrew/cask-fonts`
* `brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true`
