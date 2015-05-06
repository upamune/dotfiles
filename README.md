# Initialize

```
chmod u+x init.sh
./init.sh
```


## Vim

### キーバインド

#### ノーマルモード

上矢印キー => バッファのリサイズ
右矢印キー => バッファのリサイズ
下矢印キー => バッファのリサイズ
左矢印キー => バッファのリサイズ

### インサートモード

上矢印キー => Gundoのトグルj
右矢印キー => QuickRun実行
下矢印キー => ファイル保存
左矢印キー => VimFilerを開く

### 便利コマンド
- 行末の無駄な空白を削除する
  - ```:FixWhiteSpace```
- Gistを作成する
  - :Gista
  - :Gista -l (リスト表示)
  - :Unite gista

### For C++


### For Go

```
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/vet
go get -u golang.org/x/tools/cmd/cover
go get -u github.com/nsf/gocode
go get -u github.com/golang/lint/golint
go get -u code.google.com/p/rog-go/exp/cmd/godef
go get -u github.com/jstemmer/gotags
```
まずこれらのツールとctagsがインストールされているひつようがあります。

- ドキュメント表示
  - ```:Godoc``` でドキュメント表示
- 定義にジャンプ
  - 関数名にカーソルを合わせて ```gd```
- 関数をアウトライン表示
  - ```:Unite outline```
- パッケージインポート
  - ```:Import fmt```
- 整形する
  - ```:Fmt```
- タグにジャンプできるウィンドウを出す
  - ```:Tagbar```

### For Ruby
依存関係がいくつかあるのでまずインストールしてください。あときちんとgemにPATHが通っているかどうかも確かめてください。 [参考](http://jajkeqos.com/2015/05/04/vim-ruby-env/)

```
yaourt -S jdk8-openjdk
wget http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2
bzip2 -dc rsense-0.3.tar.bz2 | tar xvf -
sudo cp -r rsense-0.3 /usr/local/lib
sudo chmod +x /usr/local/lib/rsense-0.3/bin/rsense
gem install rubocop refe2
bitclust setup
```


- RSenseを使用しての補完
  - ```RSense```依存
- 保存時にrubocopを使用してのシンタックスチェック
- ```Shift+K```でドキュメントを参照する
  - ```refe2```依存
- ```end``` を自動で挿入する
- 関数をアウトライン表示
  - ```:Unite outline```
- タグにジャンプできるウィンドウを出す
  - ```:Tagbar```

## Zsh

### プラグイン
- zsh-completions
- zsh-syntax-highlighting
- anyframe
- cdd
  - tmuxのウィンドウに移動できる
- cdr
  - 最近移動したディレクトリに移動する

### 使用テーマ
- amuse

### エイリアス
  - c => clear
  - h => history
  - l => ls --color=auto
  - ls => ls --color=auto
  - la => ls -a
  - ll => ls -l
  - cp => cp -i
  - mv => mv -i
  - mkdir => mkdir -p
  - vimconfig => 'vim ~/.vimrc'
  - zshconfig => 'vim ~/.zshrc'
  - L => | less
  - G => | grep
  - v => gvim
  - vi => vim
  - MacOS
    - rm => rmtrash
    - C => | pbcopy
  - Linux
    - C => | xsel --input --clipboard

### キーバインド
  - Ctrl-r => 履歴をインクリメンタルサーチする(後方)
  - Ctrl-s => 履歴をインクリメンタルサーチする(前方)
  - Ctrl-x + Ctrl-p => pecoを使って履歴からコマンドを挿入する
  - Ctrl-x + w => pecoでtmuxのウィンドウを切り替える
  - Ctrl-x + c => pecoでcdrを表示する


## tmux
- マウスが使える
- アクティブなウィンドウがハイライト表示される
- ペイン/ウィンドウの開始番号を1からにする
- Vimっぽいキーバインドでペイン間を移動する

###キーバインド
- 垂直分割
  - ^t %
- 水平分割
  - ^t "
- ペインの入れ替え
  - ^t o
- ペインの番号を表示する
  - ^t q
- ペイン間を移動する
  - ^t o
  - ^t (h,j,k,l) // Vim風
- ペインのサイズを変更する
  - ^t (H,J,K,L) // Vim風
- ペインをkillする
  - ^t x
- ペインの分割を全て解除する
  - ^t !
- 新しいウィンドウ
  - ^t c
- ウィンドウをkillする
  - ^t &
- 次のウインドウへ移動
  - ^t n
- 前のウインドウへ移動
  - ^t p
- 直前のウインドウへ移動
  - ^t l
- ウィンドウ番号を指定して移動
  - ^t [番号]
- ウィンドウ名を変更
  - ^t ,

