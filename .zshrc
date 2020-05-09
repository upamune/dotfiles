# 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=vim
export GOPATH=$HOME/go
export GHQ_ROOT=$GOPATH/src
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export N_PREFIX=$HOME

# PATH
path=(
  $N_PREFIX/n/bin(N-/) # n tools
  $GOPATH/bin(N-/) # Go tools
  $HOME/.local/bin(N-/)
  $HOME/.cargo/bin(N-/) # Rust (Cargo) tools

  $HOME/.local/google-cloud-sdk/bin(N-/)
  $HOME/.local/bin(N-/)
 
  /usr/local/sbin(N-/)
  /usr/local/bin(N-/)
  /usr/sbin(N-/)
  /usr/bin(N-/)
  /sbin(N-/)
  /bin(N-/)
  /usr/games(N-/)
  /usr/local/games(N-/)
  /snap/bin(N-/)
  /usr/sbin(N-/)
  /usr/bin(N-/)
  /sbin(N-/)
  /bin(N-/)
  /usr/games(N-/)
  /usr/local/games(N-/)
  /snap/bin(N-/)
)

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=$HOME/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

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
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

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

# git エイリアス
alias -g gpush='git push origin HEAD'
alias -g gpull='git pull'
alias -g gmaster='git checkout master'
alias -g gcheck='git checkout -b '
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

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

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

# ZPlug
source $HOME/.zplug/init.zsh
zplug BurntSushi/ripgrep, as:command, from:gh-r, rename-to:"rg", frozen:1
zplug Valodim/zsh-curl-completion
zplug b4b4r07/enhancd, use:init.sh
zplug b4b4r07/gomi, as:command, from:gh-r, rename-to:"gomi", frozen:1
zplug git/git, use:contrib/completion/git-completion.zsh
zplug glidenote/hub-zsh-completion
zplug junegunn/fzf-bin, as:command, from:gh-r, rename-to:"fzf", frozen:1
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug zplug/zplug, hook-build:'zplug --self-manage'
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-syntax-highlighting, defer:2
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# vim:set ft=zsh:
