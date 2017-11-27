#!/usr/bin/env bash -eu

if [[ ! -d $HOME/.tmux/plugins/tpm ]] ; then
  mkdir -p $HOME/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

mkdir -p $HOME/.config/fish
ln -sfnv $HOME/.config.fish $HOME/.config/fish/config.fish

git config --global alias.a 'add'
git config --global alias.b 'checkout -b'
git config --global alias.c 'commit -v'
git config --global alias.d 'diff'
git config --global alias.p 'pull'
git config --global alias.pu 'push'
git config --global alias.puu 'push -u'
git config --global ghq.root "$HOME/src"
git config --global core.editor vim
git config --global user.email "info@serizawa.me"
git config --global user.name "upamune"
git config --global diff.algorithm histogram

echo """

    _    _ _   ____                     _
   / \  | | | |  _ \  ___  _ __   ___  | |
  / _ \ | | | | | | |/ _ \| '_ \ / _ \ | |
 / ___ \| | | | |_| | (_) | | | |  __/ |_|
/_/   \_\_|_| |____/ \___/|_| |_|\___| (_)

"""
