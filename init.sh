#!/bin/bash

# git が 必要

# カレントディレクトリのパスを取得
CURRENT_PATH=`pwd`
echo $CURRENT_PATH

# カレントディレクトリ直下にoldディレクトリがなければ作成する
if [[ ! -d $CURRENT_PATH/old ]] ; then
  mkdir "$CURRENT_PATH/old"
  echo "mkdir $CURRENT_PATH/old"
else
  rm -fr $CURRENT_PATH/old
  mkdir old
fi

# vimrcをoldディレクトリに移動する
if [[ -f $HOME/.vimrc ]] ; then
  mv $HOME/.vimrc $CURRENT_PATH/old/_vimrc
  echo "Move your vimrc to old dir"
  ln -s $CURRENT_PATH/_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
else
  ln -s $CURRENT_PATH/_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
fi

# zshrcをoldディレクトリに移動する
if [[ -f $HOME/.zshrc ]] ; then
  mv $HOME/.zshrc $CURRENT_PATH/old/_zshrc
  echo "Move your zshrc to old dir"
  ln -s $CURRENT_PATH/_zshrc $HOME/.zshrc
  echo "Replaced your zshrc"
else
  ln -s $CURRENT_PATH/_zshrc $HOME/.zshrc
  echo "Replaced your zshrc"
fi

# tmux.confをoldディレクトリに移動する
if [[ -f $HOME/.tmux.conf ]] ; then
  mv $HOME/.tmux.conf $CURRENT_PATH/old/_tmux.conf
  echo "Move your tmux.conf to old dir"
  ln -s $CURRENT_PATH/_tmux.conf $HOME/.tmux.conf
  echo "Replaced your tmux.conf"
else
  ln -s $CURRENT_PATH/_tmux.conf $HOME/.tmux.conf
  echo "Replaced your tmux.conf"
fi

# .xmodmapをoldディレクトリに移動する
if [[ -f $HOME/.xmodmap ]] ; then
  mv $HOME/.xmodmap $CURRENT_PATH/old/_xmodmap
  echo "Move your .xmodmap to old dir"
  ln -s $CURRENT_PATH/_xmodmap $HOME/.xmodmap
  echo "Replaced your .xmodmap"
else
  ln -s $CURRENT_PATH/_xmodmap $HOME/.xmodmap
  echo "Replaced your .xmodmap"
fi

# Neobundleを導入する
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]] ; then
  mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Antigenを導入する
if [[ ! -d $HOME/.zsh/antigen ]] ; then
  mkdir -p ~/.zsh/ && cd ~/.zsh && git clone https://github.com/zsh-users/antigen.git
fi

echo """

    _    _ _   ____                     _
   / \  | | | |  _ \  ___  _ __   ___  | |
  / _ \ | | | | | | |/ _ \| '_ \ / _ \ | |
 / ___ \| | | | |_| | (_) | | | |  __/ |_|
/_/   \_\_|_| |____/ \___/|_| |_|\___| (_)


But some gems and PATH is not good.
Please install manually yourself by reading README !

"""
