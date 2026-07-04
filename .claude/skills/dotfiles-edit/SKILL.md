---
name: dotfiles-edit
description: >-
  この dotfiles (Nix / nix-darwin / home-manager) へ変更を加えるときの手順。
  パッケージの追加・削除、エイリアスやシェル設定の変更、ツールのバージョン pin、
  マシンの追加、home-manager のプログラム設定の追加・変更を行うときは必ず使うこと。
  「〜をインストールして」「〜を追加して」「エイリアスを足して」「〜を pin して」
  「新しいマシンを追加」「Dock/Finder の設定を変えて」のような依頼はすべて該当する。
  inputs の更新やアップデート作業は nix-update スキルを使う。
---

# dotfiles への変更手順

## どこに何を書くか

変更の種類ごとに置き場所が決まっている。迷ったら既存ファイルの書き方に合わせる。

| やりたいこと | 場所 |
| --- | --- |
| CLI ツールのインストール | `users/upamune/packages.nix` (カテゴリコメントの下に追加) |
| home-manager モジュールがあるツールの設定 | `users/upamune/cli.nix` の `programs.*` |
| git / delta / gh の設定 | `users/upamune/git.nix` |
| zsh の宣言的設定 (履歴・キーマップ・補完初期化) | `users/upamune/zsh.nix` |
| zsh のエイリアス・関数・PATH | `users/upamune/zshrc` |
| プロンプト | `users/upamune/starship.nix` |
| 全マシン共通のシステムパッケージ | `modules/common.nix` |
| macOS システム設定 (Finder / Dock / キーボード) | `machines/darwin.nix` |
| WSL (NixOS) の設定 | `machines/wsl.nix` |
| パッケージのバージョン pin・差し替え | `overlays/` に1ファイル追加 + `overlays/default.nix` に登録 |
| マシンの追加 | `machines/<name>.nix` を作成 + `flake.nix` で `mkSystem` を1回呼ぶ |
| ユーザー設定ファイルの追加 | `users/upamune/` にファイル追加 + `home.nix` の `imports` に登録 |

`lib/mksystem.nix` は全マシン共通の組み立てロジック。個別の設定は入れない。

## 設計判断 (変更時に守ること)

- **公開リポジトリ**。API キー・仕事関連の情報・マシン固有の非公開設定は絶対に
  コミットしない。非公開のシェル設定は `~/.zshrc.local` に置く (リポジトリ管理外、
  zshrc の末尾で読み込まれる)。pre-commit で gitleaks が走るが、頼り切らないこと。
- home-manager にモジュールがあるツールは `home.packages` に生で足すより
  `programs.<tool>.enable = true` を優先する (設定も宣言的に管理できるため)。
- zsh の設定は、宣言的に書けるものは zshrc ではなく `zsh.nix` に書く。
  compinit / キーマップ / 履歴は home-manager が管理しているので zshrc で重複させない。
- コメントは日本語、識別子は英語。コミットメッセージは日本語。

## 検証

変更したら必ず以下を通す。**新規ファイルは `git add` しないと flake から見えない**
(untracked のままだと "path does not exist" になる)。

```sh
git add -A
export NIX_USER=$(whoami) NIX_HOST=$(hostname -s)
nix flake check --impure
nix build .#darwinConfigurations.$NIX_HOST.system --impure --dry-run
make lint && make fmt
```

パッケージ追加が本当に反映されるかは nix eval でも確認できる:

```sh
nix eval --impure ".#darwinConfigurations.\"$NIX_HOST\".config.home-manager.users.\"$NIX_USER\".home.packages" \
  --apply 'ps: builtins.filter (n: builtins.match ".*<パッケージ名>.*" n != null) (map (p: p.name) ps)'
```

## 反映とコミット

- コミットメッセージは日本語で、何をなぜ変えたかを書く。**push はユーザーの指示なしに行わない。**
- 実機への反映は `make switch` (sudo が必要)。Claude からは実行できないので、
  ユーザーに `! make switch` を案内する。
