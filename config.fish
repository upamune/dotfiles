set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

alias e='emacsclient -c'
alias E='emacsclient -nw'
alias gs='git status'
alias gc='git commit'

if which xsel > /dev/null ^&1
  alias pbcopy='xsel --clipboard --input'
end

if which rbenv > /dev/null ^&1
  rbenv init - | source
end

if test -d $HOME/.rbenv/bin
  set -x PATH $HOME/.rbenv/bin $PATH
end

if test -d $HOME/n
  set -x N_PREFIX $HOME/n
  set -x PATH $N_PREFIX/bin $PATH
end

if test -d $HOME/miniconda3
  set -x PATH $HOME/miniconda3/bin $PATH
end
