# Initialize

```
chmod u+x init.sh
./init.sh
```


## Vim 

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

### For Ruby
- コード補完のためにRSense  ```brew install rsense``` *JREをインストールする必要あり ```rsenseHome``` にRSenseのインストールフォルダを指定する必要がある。
- 静的解析ツールのrubocop ```gem install rubocop```
- リファレンス用のrefe2 ```gem install refe2 && bitclust setup``` *リファレンスのセットアップ
- メソッド定義元へのジャンプ機能のctags ```brew install ctags```

## Zsh

### 主なプラグイン

### 使用テーマ

### エイリアス

### キーバインド

