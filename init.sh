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
  ln -s $CURRENT_PATH/_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
else
  ln -s $CURRENT_PATH/_vimrc $HOME/.vimrc
  echo "Replaced your vimrc"
fi

# TOMLファイルを .vim/ に配置
mkdir -p $HOME/.vim
if [[ -f $HOME/.vim/neobundle.toml ]] ; then
  cp $HOME/.vim/neobundle.toml $CURRENT_PATH/old/neobundle.toml && rm $HOME/.vim/neobundle.toml
  echo "Move your neobundle.toml to old dir"
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
else
  ln -s $CURRENT_PATH/neobundle.toml $HOME/.vim/neobundle.toml
  echo "Replaced your neobundle.toml"
fi
if [[ -f $HOME/.vim/neobundlelazy.toml ]] ; then
  cp $HOME/.vim/neobundlelazy.toml $CURRENT_PATH/old/neobundlelazy.toml && rm $HOME/.vim/neobundlelazy.toml
  echo "Move your neobundlelazy.toml to old dir"
  ln -s $CURRENT_PATH/neobundlelazy.toml $HOME/.vim/neobundlelazy.toml
  echo "Replaced your neobundlelazy.toml"
else
  ln -s $CURRENT_PATH/neobundlelazy.toml $HOME/.vim/neobundlelazy.toml
  echo "Replaced your neobundlelazy.toml"
fi

# nvimrcをoldディレクトリに移動する
mkdir -p $HOME/.nvim
if [[ -f $HOME/.nvimrc ]] ; then
  cp $HOME/.nvimrc $CURRENT_PATH/old/_nvimrc && rm $HOME/.nvimrc
  echo "Move your nvimrc to old dir"
  ln -s $CURRENT_PATH/_nvimrc $HOME/.nvimrc
  ln -s $CURRENT_PATH/nvimfiles $HOME/.nvim/
  echo "Replaced your nvimrc"
else
  ln -s $CURRENT_PATH/_nvimrc $HOME/.nvimrc
  ln -s $CURRENT_PATH/nvimfiles $HOME/.nvim/
  echo "Replaced your nvimrc"
fi


# zshrcをoldディレクトリに移動する
if [[ -f $HOME/.zshrc ]] ; then
  cp $HOME/.zshrc $CURRENT_PATH/old/_zshrc && rm $HOME/.zshrc
  echo "Move your zshrc to old dir"
  ln -s $CURRENT_PATH/_zshrc $HOME/.zshrc
  echo "Replaced your zshrc"
else
  ln -s $CURRENT_PATH/_zshrc $HOME/.zshrc
  echo "Replaced your zshrc"
fi

# tmux.confをoldディレクトリに移動する
if [[ -f $HOME/.tmux.conf ]] ; then
  cp $HOME/.tmux.conf $CURRENT_PATH/old/_tmux.conf && rm $HOME/.tmux.conf
  echo "Move your tmux.conf to old dir"
  ln -s $CURRENT_PATH/_tmux.conf $HOME/.tmux.conf
  echo "Replaced your tmux.conf"
else
  ln -s $CURRENT_PATH/_tmux.conf $HOME/.tmux.conf
  echo "Replaced your tmux.conf"
fi

# .xmodmapをoldディレクトリに移動する
if [[ -f $HOME/.xmodmap ]] ; then
  cp $HOME/.xmodmap $CURRENT_PATH/old/_xmodmap && rm $HOME/.xmodmap
  echo "Move your .xmodmap to old dir"
  ln -s $CURRENT_PATH/_xmodmap $HOME/.xmodmap
  echo "Replaced your .xmodmap"
else
  ln -s $CURRENT_PATH/_xmodmap $HOME/.xmodmap
  echo "Replaced your .xmodmap"
fi

# .ideavimrcをoldディレクトリに移動する
if [[ -f $HOME/.ideavimrc ]] ; then
  cp $HOME/.ideavimrc $CURRENT_PATH/old/_ideavimrc && rm $HOME/.ideavimrc
  echo "Move your .ideavimrc to old dir"
  ln -s $CURRENT_PATH/_ideavimrc $HOME/.ideavimrc
  echo "Replaced your .ideavimrc"
else
  ln -s $CURRENT_PATH/_ideavimrc $HOME/.ideavimrc
  echo "Replaced your .ideavimrc"
fi

# .agignoreをoldディレクトリに移動する
if [[ -f $HOME/.agignore ]] ; then
  cp $HOME/.agignore $CURRENT_PATH/old/_agignore && rm $HOME/.agignore
  echo "Move your .agignore to old dir"
  ln -s $CURRENT_PATH/_agignore $HOME/.agignore
  echo "Replaced your .agignore"
else
  ln -s $CURRENT_PATH/_agignore $HOME/.agignore
  echo "Replaced your .agignore"
fi

# Neobundleを導入する for Vim
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]] ; then
  mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Neobundleを導入する for NeoVim
if [[ ! -d $HOME/.nvim/bundle/neobundle.vim ]] ; then
  mkdir -p ~/.nvim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim
fi

# Antigenを導入する
if [[ ! -d $HOME/.zsh/antigen ]] ; then
  mkdir -p ~/.zsh/ && cd ~/.zsh && git clone https://github.com/zsh-users/antigen.git
fi

# tpm を導入する
if [[ ! -d $HOME/.tmux/plugins/tpm ]] ; then
  mkdir -p $HOME/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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

if which go > /dev/null 2>&1; then
  go get -v code.google.com/p/rog-go/exp/cmd/godef
  go get -v github.com/golang/lint/golint
  go get -v github.com/jstemmer/gotags
  go get -v github.com/motemen/ghq
  go get -v github.com/nsf/gocode
  go get -v github.com/peco/peco
  go get -v github.com/peco/peco/cmd/peco
  go get -v github.com/upamune/tw
  go get -v golang.org/x/tools/cmd/goimports
  # go get -v golang.org/x/tools/cmd/cover
  # go get -v golang.org/x/tools/cmd/godoc
  # go get -v golang.org/x/tools/cmd/vet
fi

if which pip > /dev/null 2>&1; then
  sudo pip install virtualenv
  sudo pip install virtualenvwrapper
  sudo pip install flake8
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
