# dotfiles
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/jajkeqos/dotfiles?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Hateblo
環境変数を設定する必要があります
- $HATENA_USER_NAME
- $HATENA_API_KEY
- $HATENA_API_ENDPOINT

:HatebloCreate
新しいブログエントリを投稿します． 1行目にTITLE:から始まる文を記述すると，その行はタイトルとして扱われます． もしも1行目でタイトルを指定しなかった場合は，インタラクティブにタイトルが要求されます．

また，タイトル入力後にカテゴリを入力を要求されます (もちろん入力しなくても大丈夫です．その場合はカテゴリは空として扱われます)． カテゴリは半角カンマ (,) で区切ることにより複数個指定することが出来ます． 2行目にCATEGORY:から始まるを記述するとその行はカテゴリとして扱われます． 半角カンマで区切れる点も同様です．

:HatebloCreateDraft
新しいブログエントリを 「下書き」として 投稿します．
それ以外の機能は :HatebloCreate と同等の機能を提供しています． 本機能を利用する場合は 22261e094ad01faa433fe2c7219c6be14ce127cd 以降の (つまり新しい) webapi-vimがインストールされている必要があります。

:HatebloList
ブログエントリのリストを unite source 形式で表示します． エントリを選択すると，そのエントリを編集することができます．

:edit hateblo:
ブログエントリのリストをmetarw形式で表示します．(optional) 使用するにはvim-metarwが必要になります． エントリを選択すると，そのエントリを編集することができます． :HatebloListの場合と異なり,現在のディレクトリに記事のタイトルのファイルが生成されません． editはsplit等のファイルを開くコマンドや:e等の省略形が使用できます．

:HatebloUpdate [new_entry_title]
現在のバッファのエントリを更新します． 引数のnew_entry_titleはオプショナルです．もしもタイトルを変更したい場合は指定してください． 引数が指定されなかった場合，タイトルは変更されません． TITLE:, CATEGORY:により指定はここでも有効です． 上述の方法で開いたバッファでしか実行できません．

:HatebloDelete
現在のバッファのエントリを削除します． 上述の方法で開いたバッファでしか実行できません．


## Vim for Ruby
- コード補完のためにRSense  ```brew install rsense``` *JREをインストールする必要あり ```rsenseHome``` にRSenseのインストールフォルダを指定する必要がある。
- 静的解析ツールのrubocop ```gem install rubocop```
- リファレンス用のrefe2 ```gem install refe2 && bitclust setup``` *リファレンスのセットアップ
- メソッド定義元へのジャンプ機能のctags ```brew install ctags```

