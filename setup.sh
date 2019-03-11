#!/bin/bash

set -eux
# Save old vimrc file
if [ -f ~/.vimrc ]; then
  cp ~/.vimrc ~/.vimrc.old
fi

if [ -f ~/.tmux.conf ]; then
  cp ~/.tmux.conf ~/.tmux.conf.old
fi

if [ -f ~/.gitconfig ]; then
  cp ~/.gitconfig ~/.gitconfig.old
fi

if [ -f ~/.zshrc ]; then
  cp ~/.zshrc ~/.zshrc.old
fi

read -n1 -p "Are you on Linux [L/l] or Mac [M/m] ? " doit
echo

case $doit in
  L|l)
    echo "Copying Linux configurations for Vim and Tmux.."
cat >~/.tmux.conf <<EOL
setw -g mode-mouse on
set -g mouse-select-window on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-utf on
EOL
    cp vimrc-linux ~/.vimrc 
    cp zshrc-linux ~/.zhsrc
    ;;
  M|m)
    echo "Copying Mac configurations for Vim and Tmux.."
    echo "set -g mouse on" > ~/.tmux.conf
    cp vimrc-mac ~/.vimrc
    cp zshrc-mac ~/.zshrc
    ;;
  *)
    echo "Sorry, there are only configs for Linux and Mac."
    exit -1
    ;;
esac
cat >>~/.tmux.conf <<EOL
# Vim style pane selection bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
EOL

# Install Vundle, Vim package manager
if [ ! -d ~/.vim/bundle/Vundle.vim/ ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "Vundle.vim already installed."
fi
vim +PluginInstall +qall

# Update .gitconfig
cp gitconfig ~/.gitconfig

echo "Updated ~/.vimrc ~/.tmux.conf ~/.gitconfig, previous versions stored in [FILENAME].old"
