dotfiles
========

We all need them!

# Recovery

* `git clone git@github.com:schumacher-m/dotfiles.git`
* `cp -r dotfiles/.[^.]* ~/`
* `git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.znap`
* `git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch HEAD`
* `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
* `asdf plugin-add python`
* `asdf install`
* `asdf reshim`
* `pip install pipenv`

# NPM

Export
`npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' > path/to/npmfile`

Import
`xargs npm install --global < path/to/npmfile`

https://stackoverflow.com/a/41199625

# PIP

Export
`pip freeze > ~/workspace/dotfiles/requirements.txt`

Import
`pip install -r ~/workspace/dotfiles/requirements.txt`

Might want to upgrade also
`pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U`

# Spacemacs

* `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
* `cp -r .emacs.d/private/* ~/.emacs.d/private/`

# Emacs

```
git clone --depth=1 https://github.com/emacs-mirror/emacs.git
cd emacs/
git checkout feature/native-comp
git pull
sudo apt install -y autoconf make gcc texinfo libgtk-3-dev libxpm-dev \
      libjpeg-dev libgif-dev libtiff5-dev libgnutls28-dev libncurses5-dev \
      libjansson-dev libharfbuzz-dev libharfbuzz-bin gcc-10 g++-10 libgccjit0 libgccjit-10-dev
export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./autogen.sh
./configure --with-nativecomp --with-json CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer"
make -j$(nproc)
sudo make install
```

# Alacritty

* https://github.com/alacritty/alacritty

# Fonts

* https://github.com/ryanoasis/nerd-fonts

# Toggl CLI

* https://github.com/meeDamian/toggl-cli
