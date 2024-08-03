dotfiles
========

We all need them!

# Recovery

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


yay -Syu mise
sudo pacman -Syu fzf zoxide eza thefuck ttf-hack-nerd emacs-nativecomp alacritty  


git clone git@github.com:marlonrichert/zsh-snap.git ~/.znap/zsh-snap
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
