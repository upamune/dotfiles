# dotfiles

Nix / [nix-darwin](https://github.com/LnL7/nix-darwin) / [home-manager](https://github.com/nix-community/home-manager) で macOS と WSL2 (NixOS) を宣言的に管理する dotfiles。

## 構成

```
.
├── flake.nix          # 入口。inputs の定義と mkSystem の呼び出しのみ
├── lib/
│   └── mksystem.nix   # NixOS / nix-darwin / home-manager を組み立てる共通関数
├── machines/          # マシン (ホスト種別) ごとのシステム設定
│   ├── darwin.nix     #   macOS (Finder / Dock / キーボードなど)
│   └── wsl.nix        #   WSL2 (NixOS)
├── modules/
│   └── common.nix     # 全マシン共通のシステム設定
├── overlays/          # パッケージの pin・差し替え
│   └── colima.nix
└── users/
    └── upamune/       # home-manager によるユーザー設定
        ├── home.nix   #   入口 (imports で以下を読み込む)
        ├── packages.nix
        ├── cli.nix    #   fzf / eza / bat / neovim など
        ├── git.nix
        ├── starship.nix
        ├── zsh.nix
        └── zshrc      #   zsh.nix から initContent として読み込まれる
```

### 設計

- ユーザー名とホスト名は環境変数 `NIX_USER` / `NIX_HOST` から読む (`--impure` が必要)。
  Makefile が自動で設定するので、通常は意識しなくてよい。
- **マシンを追加する**: `machines/<name>.nix` を作り、`flake.nix` で `mkSystem` を1回呼ぶ。
- **パッケージを pin する**: `overlays/` にオーバーレイを追加し、`overlays/default.nix` の一覧に足す。
- **ユーザー設定を足す**: `users/upamune/` にファイルを追加し、`home.nix` の `imports` に足す。
- マシン固有・非公開の shell 設定は `~/.zshrc.local` に置く (リポジトリ管理外)。

## セットアップ

1. [Determinate Nix](https://github.com/DeterminateSystems/nix-installer) のインストール

```zsh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. 設定の反映

```zsh
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
make switch
```

## コマンド

| コマンド | 説明 |
| --- | --- |
| `make switch` | 設定を反映 (macOS / WSL2 共通) |
| `make darwin-rebuild` | `darwin-rebuild` で直接反映 (macOS のみ) |
| `make update` | Flake inputs を更新 |
| `make lint` | statix による lint |
| `make fmt` | nixfmt-rfc-style でフォーマット |
| `make test` | `nix flake check` |
| `make clean` | Nix のガベージコレクション |
| `make info` | システム情報を表示 |
