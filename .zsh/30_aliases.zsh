if ! vitalize 2>/dev/null; then
  echo "cannot run as shell script" 1>&2
  return 1
fi

alias ls='ls -GF'
alias l='ls'
alias la='ls -laGF'
alias mv='mv -i'
alias -g cp='cp -i'
alias -g grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'
alias -g mkdir='mkdir -p'
alias -g vimconfig='vim ~/.vimrc'
alias -g zshconfig='vim ~/.zshrc'
alias -g L='| less'
alias -g G='| grep'
alias -g v='vim'
alias -g vi='vim'

if is_osx; then
    alias -g CP='| pbcopy'
    alias -g CC='| tee /dev/tty | pbcopy'
fi

if has "nvim"; then
  alias -g vim='nvim'
fi

if has "git"; then
  alias g='git'
  alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
  alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
fi

alias -g N=" >/dev/null 2>&1"
alias -g N1=" >/dev/null"
alias -g N2=" 2>/dev/null"

if has "git-now"; then
  alias gn='git-now'
fi
alias cdd="cd $GOPATH/src/github.com/$USER"

if has "docker"; then
  alias -g d='docker'
fi

if has "emojify"; then
  alias -g E='| emojify'
fi

# finder
alias f='fzf \
    --bind="ctrl-l:execute(less {})" \
    --bind="ctrl-h:execute(ls -l {} | less)" \
    --bind="ctrl-v:execute(vim {})"'
alias -g F='$(f)'

