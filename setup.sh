#!/bin/bash

set -eux
# Save old vimrc file
if [ -f ~/.vimrc ]; then
  cp ~/.vimrc ~/.vimrc.old
fi

if [ -f ~/.tmux.conf ]; then
  cp ~/.tmux.conf ~/.tmux.conf.old
fi
TMUX_PANE_SELECTION=" # Vim style pane selection bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R"

MAC="set -g mouse on"
LINUX="
setw -g mode-mouse on
set -g mouse-select-window on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-utf on"


read -n1 -p "Are you on Linux [L/l] or Mac [M/m] ? " doit
echo
case $doit in
  L|l)
    echo "Copying Linux configurations for Vim and Tmux.."
    echo $LINUX > ~/.tmux.conf
    cp vimrc-linux ~/.vimrc 
    ;;
  M|m)
    echo "Copying Mac configurations for Vim and Tmux.."
    echo $MAC > ~/.tmux.conf
    cp vimrc-mac ~/.vimrc
    ;;
  *)
    echo "Sorry, there are only configs for Linux and Mac."
    exit -1
    ;;
esac

echo $TMUX_PANE_SELECTION >> ~/.tmux.conf

if [ ! -d ~/.vim/bundle/Vundle.vim/ ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "Vundle.vim already installed."
fi

vim +PluginInstall +qall
echo "Updated ~/.vimrc ~/.tmux.conf, previous versions stored in [FILENAME].old"
