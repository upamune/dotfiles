# Initialize

```
chmod u+x init.sh
./init.sh
```


## Vim

- 行末の無駄な空白を削除する
  - ```:FixWhiteSpace```

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


## Zsh

### プラグイン
- zsh-completions
- zsh-syntax-highlighting
- anyframe
- cdd

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
  - vim => gvim

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



