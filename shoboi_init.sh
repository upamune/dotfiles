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
  # mv コマンドでやらないのは mv だとシンボリックリンクを持ってきてしまうため
  cp $HOME/.vimrc $CURRENT_PATH/old/_vimrc && rm $HOME/.vimrc
  echo "Move your vimrc to old dir"
  ln -s $CURRENT_PATH/_shoboi_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
else
  ln -s $CURRENT_PATH/_shoboi_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
fi

# TOMLファイルを .vim/ に配置
mkdir -p $HOME/.vim
if [[ -f $HOME/.vim/neobundle.toml ]] ; then
  cp $HOME/.vim/neobundle.toml $CURRENT_PATH/old/neobundle.toml && rm $HOME/.vim/neobundle.toml
  echo "Move your neobundle.toml to old dir"
  ln -s $CURRENT_PATH/shoboi_neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
else
  ln -s $CURRENT_PATH/shoboi_neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
fi

# bashrcをoldディレクトリに移動する
if [[ -f $HOME/.bashrc ]] ; then
  cp $HOME/.bashrc $CURRENT_PATH/old/_bashrc && rm $HOME/.bashrc
  echo "Move your bashrc to old dir"
  ln -s $CURRENT_PATH/_bashrc $HOME/.bashrc
  echo "Replaced your bashrc"
else
  ln -s $CURRENT_PATH/_bashrc $HOME/.bashrc
  echo "Replaced your bashrc"
fi

# shoboi_tmux.confをoldディレクトリに移動する
if [[ -f $HOME/.tmux.conf ]] ; then
  cp $HOME/.tmux.conf $CURRENT_PATH/old/_tmux.conf && rm $HOME/.tmux.conf
  echo "Move your shoboi_tmux.conf to old dir"
  ln -s $CURRENT_PATH/_shoboi_tmux.conf $HOME/.tmux.conf
  echo "Replaced your shoboi_tmux.conf"
else
  ln -s $CURRENT_PATH/_shoboi_tmux.conf $HOME/.tmux.conf
  echo "Replaced your shoboi_tmux.conf"
fi

# Neobundleを導入する
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]] ; then
  mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Git の設定
git config --global alias.a 'add'
git config --global alias.b 'checkout -b'
git config --global alias.c 'commit -v'
git config --global alias.d 'diff'
git config --global alias.p 'pull'
git config --global alias.pu 'push'
git config --global alias.puu 'push -u'
git config --global ghq.root "$HOME/src"
git config --global user.email "jajkeqos@gmail.com"
git config --global user.name "upamune"

# Go ツールのインストール
#
#if which go > /dev/null 2>&1; then
#  go get -v code.google.com/p/rog-go/exp/cmd/godef
#  go get -v github.com/golang/lint/golint
#  go get -v github.com/jstemmer/gotags
#  go get -v github.com/motemen/ghq
#  go get -v github.com/nsf/gocode
#  go get -v github.com/peco/peco
#  go get -v github.com/upamune/tw
#  go get -v golang.org/x/tools/cmd/goimports
#  # go get -v golang.org/x/tools/cmd/cover
#  # go get -v golang.org/x/tools/cmd/godoc
#  # go get -v golang.org/x/tools/cmd/vet
#fi
#
#if which pip > /dev/null 2>&1; then
#  sudo pip install virtualenv
#  sudo pip install virtualenvwrapper
#  sudo pip install flake8
#fi

echo """

    _    _ _   ____                     _
   / \  | | | |  _ \  ___  _ __   ___  | |
  / _ \ | | | | | | |/ _ \| '_ \ / _ \ | |
 / ___ \| | | | |_| | (_) | | | |  __/ |_|
/_/   \_\_|_| |____/ \___/|_| |_|\___| (_)


But some gems and PATH is not good.
Please install manually yourself by reading README !

SHOBOI !!!!!!!!!

"""
