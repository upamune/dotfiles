if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# vim:filetype=zsh
stty stop undef

# fpath
fpath=($HOME/.zsh/zsh-completions/src(N-/) $fpath)
fpath=($HOME/.zsh/complention $fpath)

# 環境変数
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="mm/dd/yyyy"
export LANG=ja_JP.UTF-8
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GOPATH=~/
export ENHANCD_FILTER=peco

# Keybind
bindkey -e

# zplug
if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh
  zplug "b4b4r07/zplug"
  zplug "b4b4r07/enhancd", use:enhancd.sh
  zplug "mollifier/cd-gitroot"
  zplug "mollifier/anyframe"
  zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf
  zplug "b4b4r07/zsh-gomi", if:"which fzf"
  zplug "tarruda/zsh-autosuggestions"

  # after executing compinit command
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "zsh-users/zsh-completions", nice:10

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
  fi

  zplug load
fi


# alias
alias l='\ls'
alias mv='mv -i'
alias -g cp='cp -i'
alias -g grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'
alias -g mkdir='mkdir -p'
alias -g vimconfig='vim ~/.vimrc'
alias -g zshconfig='vim ~/.zshrc'
alias -g C='| xsel --input --clipboard'
alias -g L='| less'
alias -g G='| grep'
alias -g N='&& notify'
alias -g v='vim'
alias -g vi='vim'
alias -g vim='nvim'
alias g='git'
alias gn='git-now'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias cdu='cd-gitroot'
alias cdd="cd $GOPATH/src/github.com/$USER"
alias gd="godic search "

if which gomi > /dev/null 2>&1 ; then
  alias rm='gomi'
fi

# git settings
git config --global alias.a 'add'
git config --global alias.b 'checkout -b'
git config --global alias.c 'commit -v'
git config --global alias.d 'diff'
git config --global alias.o 'checkout'
git config --global alias.p 'pull'
git config --global alias.pu 'push'
git config --global alias.puu 'push -u'
git config --global ghq.root "$HOME/src"
git config --global core.editor vim
git config --global user.email "jajkeqos@gmail.com"
git config --global user.name "upamune"
git config --global github.user upamune
git config --global diff.algorithm histogram

# rbenv があったら初期化処理を追加する
if which rbenv > /dev/null 2>&1 ; then
  eval "$(rbenv init -)"
fi

# vitualenvwrapperのスクリプトを実行する
if which virtualenvwrapper.sh > /dev/null 2>&1 ; then
  export WORKON_HOME=$HOME/.virtualenvs
  source `which virtualenvwrapper.sh`
fi

#OS 別設定
case ${OSTYPE} in
  # For MacOS
  darwin*)
  # Brew Cask 用の設定
  export HOMEBREW_CASK_OPTS="—appdir=/Applications"
  # Cでクリップボードにコピーできるようにする
  if which pbcopy > /dev/null 2>&1 ; then
    alias -g C='| pbcopy'
  fi

  if [[ -d $HOME/.nvm ]] ; then
    export NVM_DIR=$HOME/.nvm
    source $(brew --prefix nvm)/nvm.sh
  fi

  # pyenvのパスを通す
  export PYENV_ROOT=/usr/local/var/pyenv
  # To enable shims and autocompletion add to your profile:
  if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

  ;;
  # For Linux
  linux*)

  export PATH=$ANDROID_HOME/tools:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH

  if [[ -d $HOME/.nvm ]] ; then
    export NVM_DIR=$HOME/.nvm
    source /usr/share/nvm/init-nvm.sh
  fi
  # systemctl のエイリアスを設定する
  if which systemctl > /dev/null 2>&1 ; then
    alias -g sctl='systemctl'
  fi

  # machinectl のエイリアスを設定する
  if which machinectl > /dev/null 2>&1 ; then
    alias -g mctl='machinectl'
  fi

  # CapsをCtrlに置換する
  if [[ -f $HOME/.xmodmap ]]; then
    xmodmap .xmodmap > /dev/null 2>&1
  fi

  # xdg-open を openにエイリアス
  alias open='xdg-open'

  # fcitxが存在したら環境変数を設定する
  if which fcitx > /dev/null 2>&1 ; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
  fi

  # javaws が存在したらtopcoderにエイリアス
  if which javaws > /dev/null 2>&1 ; then
    alias topcoder='javaws /usr/local/bin/ContestAppletProd.jnlp&'
  fi

  # Ruby2.2 がインストールされてたらPATHを通す
  if [ -d $HOME/.gem/ruby/2.2.0/bin ]; then
    export PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin
    export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin
  fi

  # herokuが存在したらPATHを通す
  if [ -d /usr/local/heroku ]; then
    PATH=/usr/local/heroku/bin:$PATH
  fi

  # xselが存在したらCでクリップボードにコピーできるようにする
  if which xsel > /dev/null 2>&1 ; then
    alias -g C='| xsel --input --clipboard'
  fi

  # addon-sdk が存在したらエイリアス
  if [ -d /opt/addon-sdk ] ; then
    alias addon-sdk='cd /opt/addon-sdk && source bin/activate; cd -'
  fi

  if which docker > /dev/null 2>&1 ; then
    alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
  fi

  ;;
esac

# oh-my-zsh が R を指定しているので、それより後に書く必要がある
# 検索時に大文字小文字を区別しないが、大文字で検索すると大文字だけヒットする
# ファイル名、現在位置を表示
# ANSI Color Escape Sequenceを色表示
# 1行を折り返さない
export LESS='-iMRS'

# Functions
# anyframe の設定
if zplug check mollifier/anyframe; then
  bindkey '^x^p' anyframe-widget-put-history
  bindkey '^x^g' anyframe-widget-cd-ghq-repository
  bindkey '^x^k' anyframe-widget-kill
  bindkey '^x^e' anyframe-widget-insert-git-branch
fi
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

chpwd() {
    ls_abbrev
}
ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
