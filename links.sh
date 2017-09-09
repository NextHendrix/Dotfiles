#!/bin/bash

mkdir -p ~/{.config/{ncmpcpp,bspwm,sxhkd,termite,compton},.emacs.d/lisp/,.terminfo/{t,x},.xmonad/}
ln -sf ~/Dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/Dotfiles/termite/config ~/.config/termite/
ln -sf ~/Dotfiles/bspwm/bspwmrc ~/.config/bspwm/
ln -sf ~/Dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/
ln -sf ~/Dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/Dotfiles/zsh/zprofile ~/.zprofile 
ln -sf ~/Dotfiles/X/xinitrc ~/.xinitrc
ln -sf ~/Dotfiles/X/Xmodmap ~/.Xmodmap
ln -sf ~/Dotfiles/emacs/init.el ~/.emacs.d/
ln -sf ~/Dotfiles/compton/compton.conf ~/.config/compton/
ln -sf ~/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/Dotfiles/ncmpcpp/{bindings,config} ~/.config/ncmpcpp/
ln -sf ~/Dotfiles/tmux/tmux-256color ~/.terminfo/t/
ln -sf ~/Dotfiles/termite/xterm-termite ~/.terminfo/x/
ln -sf ~/Dotfiles/XMonad/xmonad.hs ~/.xmonad/
ln -sf ~/Dotfiles/XMonad/xmobarrc ~/.xmobarrc
ln -sf ~/Dotfiles/emacs/erc-tex.el ~/.emacs.d/lisp/
ln -sf ~/Dotfiles/vimperator/vimperatorrc ~/.vimperatorrc
ln -sf ~/Dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/Dotfiles/ghci/ghci ~/.ghci
