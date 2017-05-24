#!/bin/sh

mkdir -p ~/{.config/{ncmpcpp,bspwm,sxhkd,termite,compton,nvim/autoload},.emacs.d,.terminfo/t,.xmonad/}
ln -sf ~/Dotfiles/nvim/init.vim ~/.config/nvim/
cp ~/Dotfiles/nvim/plug.vim ~/.config/nvim/autoload/
ln -sf ~/Dotfiles/termite/config ~/.config/termite/
ln -sf ~/Dotfiles/bspwm/bspwmrc ~/.config/bspwm/
ln -sf ~/Dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/
ln -sf ~/Dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/Dotfiles/X/xinitrc ~/.xinitrc
ln -sf ~/Dotfiles/X/Xmodmap ~/.Xmodmap
ln -sf ~/Dotfiles/emacs/init.el ~/.emacs.d/
ln -sf ~/Dotfiles/compton/compton.conf ~/.config/compton/
ln -sf ~/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/Dotfiles/ncmpcpp/{bindings,config} ~/.config/ncmpcpp/
ln -sf ~/Dotfiles/tmux/tmux-256color ~/.terminfo/t/
ln -sf ~/Dotfiles/XMonad/xmonad.hs ~/.xmonad/
ln -sf ~/Dotfiles/XMonad/xmobarrc ~/.xmobarrc
ln -sf ~/Dotfiles/spacemancs/dotspacemacs ~/.spacemacs
