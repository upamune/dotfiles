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

# TOMLファイルを .vim/ に配置
mkdir -p $HOME/.vim
if [[ -f $HOME/.vim/neobundle.toml ]] ; then
  mv $HOME/.vim/neobundle.toml $CURRENT_PATH/old/neobundle.toml
  echo "Move your neobundle.toml to old dir"
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
else
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
fi

# nvimrcをoldディレクトリに移動する
if [[ -f $HOME/.nvimrc ]] ; then
  mv $HOME/.nvimrc $CURRENT_PATH/old/_vimrc
  echo "Move your nvimrc to old dir"
  ln -s $CURRENT_PATH/_vimrc $HOME/.nvimrc
  echo "Replaced your nvimrc"
else
  ln -s $CURRENT_PATH/_vimrc $HOME/.nvimrc
  echo "Replaced your nvimrc"
fi

# TOMLファイルを .nvim/ に配置
mkdir -p $HOME/.nvim
if [[ -f $HOME/.nvim/neobundle.toml ]] ; then
  mv $HOME/.nvim/neobundle.toml $CURRENT_PATH/old/neobundle.toml
  echo "Move your neobundle.toml to old dir"
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.nvim/neobundle.toml
  echo "Replaced your neobundle.toml"
else
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.nvim/neobundle.toml
  echo "Replaced your neobundle.toml"
fi

if [[ -f $HOME/.vim/neobundlelazy.toml ]] ; then
  mv $HOME/.vim/neobundlelazy.toml $CURRENT_PATH/old/neobundlelazy.toml
  echo "Move your neobundlelazy.toml to old dir"
  ln -s $CURRENT_PATH/neobundlelazy.toml $HOME/.vim/neobundlelazy.toml
  echo "Replaced your neobundlelazy.toml"
else
  ln -s $CURRENT_PATH/neobundlelazy.toml $HOME/.vim/neobundlelazy.toml
  echo "Replaced your neobundlelazy.toml"
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

# .ideavimrcをoldディレクトリに移動する
if [[ -f $HOME/.ideavimrc ]] ; then
  mv $HOME/.ideavimrc $CURRENT_PATH/old/_ideavimrc
  echo "Move your .ideavimrc to old dir"
  ln -s $CURRENT_PATH/_ideavimrc $HOME/.ideavimrc
  echo "Replaced your .ideavimrc"
else
  ln -s $CURRENT_PATH/_ideavimrc $HOME/.ideavimrc
  echo "Replaced your .ideavimrc"
fi

# .agignoreをoldディレクトリに移動する
if [[ -f $HOME/.agignore ]] ; then
  mv $HOME/.agignore $CURRENT_PATH/old/_agignore
  echo "Move your .agignore to old dir"
  ln -s $CURRENT_PATH/_agignore $HOME/.agignore
  echo "Replaced your .agignore"
else
  ln -s $CURRENT_PATH/_agignore $HOME/.agignore
  echo "Replaced your .agignore"
fi

# Neobundleを導入する
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]] ; then
  mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Antigenを導入する
if [[ ! -d $HOME/.zsh/antigen ]] ; then
  mkdir -p ~/.zsh/ && cd ~/.zsh && git clone https://github.com/zsh-users/antigen.git
fi

# tpm を導入する
if [[ ! -d $HOME/.tmux/plugins/tpm ]] ; then
  mkdir -p $HOME/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
