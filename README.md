dotfiles
========

We all need them!

# Recovery

```
mkdir -p ~/.znap

git clone git@github.com:marlonrichert/zsh-snap.git ~/.znap/zsh-snap
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl https://mise.run | sh

```

# Emacs

* `brew tap d12frosted/emacs-plus`
* `brew install emacs-plus@29 --with-native-comp`

# Alacritty

* `brew install alacritty`

# Fonts

* `brew tap homebrew/cask-fonts`
* `brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true`
