# dotfiles

1. Nix のインストール
https://github.com/DeterminateSystems/nix-installer

```zsh
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. 設定の反映

```zsh
$ source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
$ make switch
```

## omarchy (bash / non-Nix)

```
$ make omarchy
```

- `mise` が未インストールの場合は自動でセットアップします
- `_mise.toml`、`bashrc`、`config/starship.toml` をホームディレクトリへsymlinkします
- `~/.bashrc` に symlink 経由で dotfiles を読み込むよう追記します
