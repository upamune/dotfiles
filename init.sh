#!/bin/zsh

NVIM_CONF_DIR=$HOME/.config/nvim
mkdir -p $HOME/.nvim
mkdir -p $NVIM_CONF_DIR
ln -sfnv $HOME/.nvimrc $NVIM_CONF_DIR/init.vim
ln -sfnv $HOME/.nvimfiles $NVIM_CONF_DIR/nvimfiles

# zplugを導入する
if [[ ! -f ~/.zplug/init.zsh ]]; then

    git clone \
        https://github.com/b4b4r07/zplug \
        ~/.zplug

fi

if [[ ! -f ~/.zplug/init.zsh ]]; then
    echo "zplug: not found" >&2
    exit 1
fi
# load zplug
source ~/.zplug/init.zsh

if which tmux > /dev/null 2>&1 ; then
  if [ -z $TMUX ] ; then
    if [ -z `tmux ls` ] ; then
      tmux -2
    else
      tmux -2 attach
    fi
  fi
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
git config --global core.editor vim
git config --global user.email "jajkeqos@gmail.com"
git config --global user.name "upamune"
git config --global diff.algorithm histogram

echo """

    _    _ _   ____                     _
   / \  | | | |  _ \  ___  _ __   ___  | |
  / _ \ | | | | | | |/ _ \| '_ \ / _ \ | |
 / ___ \| | | | |_| | (_) | | | |  __/ |_|
/_/   \_\_|_| |____/ \___/|_| |_|\___| (_)

"""
