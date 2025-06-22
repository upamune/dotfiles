# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=$HOME/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# Shift + TABで補完を逆に辿れるようにする
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 選択している補完をハイライトする
zstyle ':completion:*' menu select

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias -g zshrc="$EDITOR $HOME/.zshrc"
if [[ $(command -v eza) ]]; then
  alias -g e='eza --icons'
  alias -g l='e'
  alias -g ls='e'
  alias -g ea='eza -a --icons'
  alias -g la=ea
fi

if [[ $(command -v bat) ]]; then
  alias -g cat='bat'
fi

# git
alias -g gpush='git push origin HEAD'
alias -g gpull='git pull'
alias -g gmaster='git checkout master'

# ブランチのチェックアウトをiikanjiに行う関数
gcheck() {
  # 引数が指定されていない場合は使い方を表示して終了
  if [[ -z "$1" ]]; then
    echo "Usage: gcheck <branch-name>" >&2
    return 1
  fi

  local branch_name="$1"
  local remote_branch="origin/$branch_name"

  # 1. ローカルに同名のブランチが存在するかチェック
  # git branch --list は、マッチするブランチがあればその名前を出力する
  # -n で文字列が空でないことを確認
  if [[ -n $(git branch --list "$branch_name") ]]; then
    echo "Switching to existing local branch '$branch_name'."
    git checkout "$branch_name"

  # 2. リモート (origin) に同名のブランチが存在するかチェック
  # git rev-parse でリモート追跡ブランチの参照が存在するか確認
  elif git rev-parse --verify --quiet "$remote_branch" >/dev/null; then
    echo "Creating new local branch '$branch_name' to track '$remote_branch'."
    git checkout --track "$remote_branch"

  # 3. ローカルにもリモートにも存在しない場合
  else
    echo "Creating new local branch '$branch_name'."
    git checkout -b "$branch_name"
  fi
}

# git rootディレクトリに移動する関数
gr() {
  # git rev-parse --show-toplevel でルートディレクトリのパスを取得
  # 2>/dev/null は、Gitリポジトリでない場合にエラーメッセージを非表示にするためのおまじないです
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)

  # git rev-parse コマンドが成功したかチェック ($? は直前のコマンドの終了ステータス)
  if [[ $? -eq 0 ]]; then
    # 成功した場合、取得したパスにcdする
    # パスにスペースが含まれる可能性を考慮し、""で囲むのが安全です
    cd "$git_root"
  else
    # 失敗した場合（Gitリポジトリではない場合）、エラーメッセージを表示して終了
    echo "cdg: not a git repository" >&2
    return 1
  fi
}
alias -g gs='git status'
alias -g gc='git commit'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'

        # For nix-darwin
        export DARWIN_USER=$(whoami)
        export DARWIN_HOST=$(hostname -s)
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# Functions
function fzf-ghq() {
  local loc="$(ghq list | fzf --cycle)"
  if [[ -n $loc ]]; then
    local fullloc="$(ghq root)/$loc"
    BUFFER="cd ${fullloc}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-ghq
bindkey '^g'  fzf-ghq

# exit - to close a tmux pane
exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
        return
    fi

    panes=$(tmux list-panes | wc -l)
    wins=$(tmux list-windows | wc -l) 
    count=$(($panes + $wins - 1))
    if [ $count -eq 1 ]; then
        tmux detach
    else
        builtin exit
    fi
}

# aqua
export PATH=${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
export PATH="$(aqua root-dir)/bin:$PATH"

# aqua with Node.js
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

gca() {
  # ステージされている変更内容を取得
  local staged_diff
  staged_diff=$(git diff --staged)

  # ステージされている変更があるか確認
  if [ -z "$staged_diff" ]; then
    echo "ステージされている変更がありません。"
    return 1
  fi

  # Claudeに渡すプロンプト (ユーザーの元のプロンプトを日本語化・調整)
  local prompt="ステージされたgitの差分を要約したコミットタイトルを作成してください。タイトルのみを返信し、肯定の言葉やその他の説明は不要です。"

  # Claudeを使ってコミットメッセージを生成
  local commit_message
  commit_message=$(echo "$staged_diff" | claude -p "$prompt")

  # メッセージが正常に生成されたか確認
  if [ -z "$commit_message" ]; then
    echo "エラー: Claudeからのコミットメッセージ生成に失敗しました。"
    return 1
  fi

  # 生成されたメッセージでgit commitを実行
  git commit -m "$commit_message"
  
  # 実行したコマンドを表示（確認用）
  echo "Executed: git commit -m \"$commit_message\""
}

yo() {
  local model_flag=""
  if [ -n "$CLAUDE_CODE_MODEL" ]; then
    model_flag="--model $CLAUDE_CODE_MODEL"
  fi
  
  # $OBSIDIAN_VAULT_DIRが設定されている場合のみ--add-dirを使用
  local add_dir_flag=""
  if [ -n "$OBSIDIAN_VAULT_DIR" ]; then
    add_dir_flag="--add-dir=$OBSIDIAN_VAULT_DIR"
  fi
  
  local cmd="claude --dangerously-skip-permissions $add_dir_flag $model_flag $@"
  echo "$cmd"
  eval "$cmd"
}

oo() {
  # $OBSIDIAN_VAULT_DIRが設定されていない場合はエラーを出す
  if [ -z "$OBSIDIAN_VAULT_DIR" ]; then
    echo "エラー: OBSIDIAN_VAULT_DIR環境変数が設定されていません。"
    return 1
  fi
  cd "$OBSIDIAN_VAULT_DIR"
}

# Load local configuration if exists
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

# vim:set ft=zsh:
