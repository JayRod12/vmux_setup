#!/bin/bash

set -x
if [ -f "~/.vimrc" ]; then
  cp ~/.vimrc ~/.vimrc.old
fi

cp vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "setw -g mode-mouse on" > ~/.tmux.conf
