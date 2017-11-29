set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

alias e='emacsclient -c'
alias E='emacsclient -nw'
alias gs='git status'
alias gc='git commit'

if test -d $HOME/.rbenv/bin
  set -x PATH $HOME/.rbenv/bin $PATH
end

if which rbenv > /dev/null
  rbenv init - | source
end
