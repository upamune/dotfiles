---
name: nix-update
description: >-
  dotfiles (Nix / nix-darwin / home-manager) の環境を最新化する手順。flake inputs の更新、
  検証 (flake check / ビルドの dry-run)、更新起因の警告・assertion への対処、コミット、
  Determinate Nix 本体の更新、make switch での反映までを安全に行う。ユーザーが
  「nix を更新」「flake update」「依存を最新化」「環境をアップデート」「flake.lock を上げて」
  と言ったとき、renovate の flake.lock 更新 PR を検証するとき、nixpkgs や home-manager の
  更新で設定が壊れたときは必ずこのスキルを使うこと。
---

# Nix 環境のアップデート

このリポジトリの flake inputs と Nix 本体を最新化し、検証して反映するまでの手順。
ユーザー名とホスト名は環境変数から読む設計のため、**すべての nix コマンドに
`--impure` と `NIX_USER` / `NIX_HOST` の export が必要**なことに注意する。

## 手順

### 1. 準備

```sh
export NIX_USER=$(whoami) NIX_HOST=$(hostname -s)
```

flake は git 管理下のファイルしか見ない。新規ファイルを追加した場合は
`git add` してから評価しないと "path does not exist" エラーになる。

### 2. inputs の更新

```sh
nix flake update            # 全部
nix flake update <input>    # 特定の input だけ
```

`nixpkgs-colima` は colima を 0.7.6 に固定するための pin なので、更新されなくて正常。

### 3. 検証

darwin / WSL 両方の評価と、実際に使う darwin システムのビルド評価を通す。
時間がかかるのでバックグラウンド実行が向いている。

```sh
nix flake check --impure
nix build .#darwinConfigurations.$NIX_HOST.system --impure --dry-run
make lint && make fmt
```

### 4. 警告・assertion への対処

inputs 更新では home-manager / nix-darwin / NixOS-WSL のオプション廃止や
新しい警告がよく出る。警告でも放置せず、その場で設定側を直すこと
(次回以降の更新で assertion に昇格して壊れることが多い)。過去の実例:

- `wsl.nativeSystemd` が廃止 → `machines/wsl.nix` から削除して解消
- fzf と atuin の Ctrl-R 競合警告 → atuin を優先し `programs.fzf.historyWidget.command = ""`
  を `users/upamune/cli.nix` に設定して解消

対処したら手順 3 の検証をやり直し、警告が消えたことを確認する。

### 5. コミット

flake.lock と修正をコミットする。コミットメッセージは日本語で、
何をどのバージョンに上げたか・警告対処の内容を書く。**push はユーザーの指示なしに行わない。**

### 6. Determinate Nix 本体の更新

```sh
determinate-nixd version
```

新バージョンがある場合、更新には sudo のパスワードが必要で Claude からは実行できない。
ユーザーにプロンプトで次を打ってもらう:

```
! sudo determinate-nixd upgrade
```

### 7. 反映

`make switch` も sudo が必要。ユーザーに実行してもらうか、`! make switch` を案内する。
反映後に `colima version` など pin したツールが意図したバージョンかを確認できるとなおよい。

## トラブルシューティング

- **評価エラーの原因調査**: `--show-trace` を付けて再実行する
- **CI (`make test`) との差異**: CI は Linux なので darwinConfigurations は評価されない。
  darwin 側はローカルの dry-run ビルドでしか検証できない
- **切り戻し**: `git checkout HEAD~1 -- flake.lock` で lock だけ戻して再検証する
