# dotfiles

1. Nix のインストール
https://github.com/DeterminateSystems/nix-installer

```zsh
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. 設定の反映

```zsh
$ source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
$ make update
```