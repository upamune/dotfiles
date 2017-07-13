# Copyright (C) 2017 Yu SERIZAWA(@upamune)
# figlet: isometric1

#      ___           ___           ___           ___     
#     /\  \         /\  \         /\  \         /\  \    
#    /::\  \       /::\  \       /::\  \       /::\  \   
#   /:/\:\  \     /:/\:\  \     /:/\ \  \     /:/\:\  \  
#  /::\~\:\__\   /::\~\:\  \   _\:\~\ \  \   /::\~\:\  \ 
# /:/\:\ \:|__| /:/\:\ \:\__\ /\ \:\ \ \__\ /:/\:\ \:\__\
# \:\~\:\/:/  / \/__\:\/:/  / \:\ \:\ \/__/ \:\~\:\ \/__/
#  \:\ \::/  /       \::/  /   \:\ \:\__\    \:\ \:\__\  
#   \:\/:/  /        /:/  /     \:\/:/  /     \:\ \/__/  
#    \::/__/        /:/  /       \::/  /       \:\__\    
#     ~~            \/__/         \/__/         \/__/    
                        
export PLATFORM=$(uname -s)

## タイポしてもディレクトリ移動する
shopt -s cdspell

## パターンマッチングを強力にする
shopt -s extglob

## 複数のbash間でヒストリを共有する
function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

## ヒストリサイズを無限にする
export HISTSIZE=
export HISTFILESIZE=

## 先頭がスペースで始まるコマンドと重複するコマンドはヒストリに残さない
## 重複しているヒストリを削除する
export HISTCONTROL=ignoreboth:erasedups

## ウィンドウサイズを反映する
shopt -s checkwinsize

## ヒストリに日時を記録する
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

[ -z "$TMPDIR" ] && TMPDIR=/tmp

## ターミナルロックを無効にする
[[ $- =~ i ]] && stty -ixoff -ixon

## 補完を読み込む
[ -f /etc/bash_completion ] && . /etc/bash_completion

## Docker 補完
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

export GOPATH=~
if [ -z "$PATH_EXPANED" ]; then
  export PATH=$GOPATH/bin:$PATH
  # 読み込みフラグを立てる
  export PATH_EXPANED=1
fi

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

## macOSでtar作成時にメタ情報ファイルを踏めない
export COPYFILE_DISABLE=1

## ls に色を付ける

if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
elif [ "$PLATFORM" = Darwin ]; then
  alias ls='ls -G'
fi

## Ctrl-w をパスごとに削除するようにする
stty werase undef
bind '\C-w:unix-filename-rubout'

## Ctrl-f/b で単語単位で移動
bind '\C-f:shell-forward-word'
bind '\C-b:shell-backward-word'


#      ___           ___     
#     /\  \         /\  \    
#    /::\  \       /::\  \   
#   /:/\:\  \     /:/\ \  \  
#  /::\~\:\  \   _\:\~\ \  \ 
# /:/\:\ \:\__\ /\ \:\ \ \__\
# \/__\:\/:/  / \:\ \:\ \/__/
#      \::/  /   \:\ \:\__\  
#       \/__/     \:\/:/  /  
#                  \::/  /   
#                   \/__/    

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  ### git-prompt
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PROMPT_COMMAND='history -a; printf "\[\e[38;5;59m\]%$(($COLUMNS - 4))s\r" "$(__git_ps1) ($(date +%m/%d\ %H:%M:%S))"'
  PS1="\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:"
  PS1="$PS1\[\e[m\]\w\[\e[1;31m\]> \[\e[0m\]"
fi

#      ___                       ___     
#     /\  \          ___        /\  \    
#    /::\  \        /\  \       \:\  \   
#   /:/\:\  \       \:\  \       \:\  \  
#  /:/  \:\  \      /::\__\      /::\  \ 
# /:/__/_\:\__\  __/:/\/__/     /:/\:\__\
# \:\  /\ \/__/ /\/:/  /       /:/  \/__/
#  \:\ \:\__\   \::/__/       /:/  /     
#   \:\/:/  /    \:\__\       \/__/      
#    \::/  /      \/__/                  
#     \/__/                              


git config --global user.email "github@serizawa.me"
git config --global user.name "Yu SERIZAWA (@upamune)"

alias gv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
alias gc='git commit'
alias gs='git status'

[ -f /usr/local/opt/git/etc/bash_completion.d/git-completion.bash ] && source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash

#      ___           ___           ___     
#     /\  \         /\  \         /\  \    
#    /::\  \        \:\  \       /::\  \   
#   /:/\:\  \        \:\  \     /:/\:\  \  
#  /::\~\:\  \        \:\  \   /::\~\:\  \ 
# /:/\:\ \:\__\ _______\:\__\ /:/\:\ \:\__\
# \/__\:\ \/__/ \::::::::/__/ \/__\:\ \/__/
#      \:\__\    \:\~~\~~          \:\__\  
#       \/__/     \:\  \            \/__/  
#                  \:\__\                  
#                   \/__/                  

csi() {
  echo -en "\x1b[$@"
}

fzf-down() {
  fzf --height 50% "$@" --border
}

export FZF_DEFAULT_COMMAND='pt --hidden --ignore .git -g ""'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fgl - Figlet font selector => copy to clipboard
fgl() (
  [ $# -eq 0 ] && return
  cd /usr/local/Cellar/figlet/*/share/figlet/fonts
  local font=$(ls *.flf | sort | fzf --no-multi --reverse --preview "figlet -f {} $@") &&
  figlet -f "$font" "$@" | pbcopy
)

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
    fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fo - open or edit a file
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' read -d '' -r -a out < <(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=${out[0]}
  file=${out[1]}
  if [ -n "$file" ]; then
    if [ "$key" = ctrl-o ]; then
      open "$file"
    else
      ${EDITOR:-vim} "$file"
    fi
  fi
}

# c - browse chrome history
c() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

__fzf_select__() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    printf '%q ' "$item"
  done
  echo
}

if [[ $- =~ i ]]; then

__fzf_use_tmux__() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

__fzfcmd() {
  __fzf_use_tmux__ &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

__fzf_select_tmux__() {
  local height
  height=${FZF_TMUX_HEIGHT:-40%}
  if [[ $height =~ %$ ]]; then
    height="-p ${height%\%}"
  else
    height="-l $height"
  fi

  tmux split-window $height "cd $(printf %q "$PWD"); FZF_DEFAULT_OPTS=$(printf %q "$FZF_DEFAULT_OPTS") PATH=$(printf %q "$PATH") FZF_CTRL_T_COMMAND=$(printf %q "$FZF_CTRL_T_COMMAND") FZF_CTRL_T_OPTS=$(printf %q "$FZF_CTRL_T_OPTS") bash -c 'source \"${BASH_SOURCE[0]}\"; RESULT=\"\$(__fzf_select__ --no-height)\"; tmux setb -b fzf \"\$RESULT\" \\; pasteb -b fzf -t $TMUX_PANE \\; deleteb -b fzf || tmux send-keys -t $TMUX_PANE \"\$RESULT\"'"
}

fzf-file-widget() {
  if __fzf_use_tmux__; then
    __fzf_select_tmux__
  else
    local selected="$(__fzf_select__)"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
  fi
}

__fzf_cd__() {
  local cmd dir
  cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m) && printf 'cd %q' "$dir"
}

__fzf_history__() (
  local line
  shopt -u nocaseglob nocasematch
  line=$(
    HISTTIMEFORMAT= history |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
    command grep '^ *[0-9]') &&
    if [[ $- =~ H ]]; then
      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
    else
      sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
    fi
)

if [[ ! -o vi ]]; then
  # Required to refresh the prompt after fzf
  bind '"\er": redraw-current-line'
  bind '"\e^": history-expand-line'

  # CTRL-T - Paste the selected file path into the command line
  if [ $BASH_VERSINFO -gt 3 ]; then
    bind -x '"\C-t": "fzf-file-widget"'
  elif __fzf_use_tmux__; then
    bind '"\C-t": " \C-u \C-a\C-k`__fzf_select_tmux__`\e\C-e\C-y\C-a\C-d\C-y\ey\C-h"'
  else
    bind '"\C-t": " \C-u \C-a\C-k`__fzf_select__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
  fi

  # CTRL-R - Paste the selected command from history into the command line
  bind '"\C-r": " \C-e\C-u`__fzf_history__`\e\C-e\e^\er"'

  # ALT-C - cd into the selected directory
  bind '"\ec": " \C-e\C-u`__fzf_cd__`\e\C-e\er\C-m"'
else
  # We'd usually use "\e" to enter vi-movement-mode so we can do our magic,
  # but this incurs a very noticeable delay of a half second or so,
  # because many other commands start with "\e".
  # Instead, we bind an unused key, "\C-x\C-a",
  # to also enter vi-movement-mode,
  # and then use that thereafter.
  # (We imagine that "\C-x\C-a" is relatively unlikely to be in use.)
  bind '"\C-x\C-a": vi-movement-mode'

  bind '"\C-x\C-e": shell-expand-line'
  bind '"\C-x\C-r": redraw-current-line'
  bind '"\C-x^": history-expand-line'

  # CTRL-T - Paste the selected file path into the command line
  # - FIXME: Selected items are attached to the end regardless of cursor position
  if [ $BASH_VERSINFO -gt 3 ]; then
    bind -x '"\C-t": "fzf-file-widget"'
  elif __fzf_use_tmux__; then
    bind '"\C-t": "\C-x\C-a$a \C-x\C-addi`__fzf_select_tmux__`\C-x\C-e\C-x\C-a0P$xa"'
  else
    bind '"\C-t": "\C-x\C-a$a \C-x\C-addi`__fzf_select__`\C-x\C-e\C-x\C-a0Px$a \C-x\C-r\C-x\C-axa "'
  fi
  bind -m vi-command '"\C-t": "i\C-t"'

  # CTRL-R - Paste the selected command from history into the command line
  bind '"\C-r": "\C-x\C-addi`__fzf_history__`\C-x\C-e\C-x^\C-x\C-a$a\C-x\C-r"'
  bind -m vi-command '"\C-r": "i\C-r"'

  # ALT-C - cd into the selected directory
  bind '"\ec": "\C-x\C-addi`__fzf_cd__`\C-x\C-e\C-x\C-r\C-m"'
  bind -m vi-command '"\ec": "ddi`__fzf_cd__`\C-x\C-e\C-x\C-r\C-m"'
fi

fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#      ___           ___           ___     
#     /\  \         /\__\         /\  \    
#    /::\  \       /::|  |       /::\  \   
#   /:/\:\  \     /:|:|  |      /:/\:\  \  
#  /:/  \:\  \   /:/|:|__|__   /:/  \:\__\ 
# /:/__/ \:\__\ /:/ |::::\__\ /:/__/ \:|__|
# \:\  \  \/__/ \/__/~~/:/  / \:\  \ /:/  /
#  \:\  \             /:/  /   \:\  /:/  / 
#   \:\  \           /:/  /     \:\/:/  /  
#    \:\__\         /:/  /       \::/__/   
#     \/__/         \/__/         ~~       
#

[ -f ~/.enhancd/init.sh ] && source ~/.enhancd/init.sh
export ENHANCD_FILTER=fzf

function ghq-fzf() {
  local repo_path="$(ghq list --full-path |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '[ -e {-1}/README.md ] && cat {-1}/README.md | head -500')"
  if [ ! -z $repo_path ]; then
    READLINE_LINE="builtin cd $repo_path"
    READLINE_POINT=${#READLINE_LINE}
  fi
}
bind -x '"\C-g": ghq-fzf'

#      ___           ___           ___           ___     
#     /\  \         /\__\         /\__\         |\__\    
#     \:\  \       /::|  |       /:/  /         |:|  |   
#      \:\  \     /:|:|  |      /:/  /          |:|  |   
#      /::\  \   /:/|:|__|__   /:/  /  ___      |:|__|__ 
#     /:/\:\__\ /:/ |::::\__\ /:/__/  /\__\ ____/::::\__\
#    /:/  \/__/ \/__/~~/:/  / \:\  \ /:/  / \::::/~~/~   
#   /:/  /            /:/  /   \:\  /:/  /   ~~|:|~~|    
#   \/__/            /:/  /     \:\/:/  /      |:|  |    
#                   /:/  /       \::/  /       |:|  |    
#                   \/__/         \/__/         \|__|    
if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi
