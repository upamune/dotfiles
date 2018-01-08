set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

alias e='emacsclient -c'
alias E='emacsclient -nw'
alias gs='git status'
alias gc='git commit'
alias t='todoist'
alias tt='__todoist_actions'

# ~Theme~ #
# omf install bobthefish
set -g theme_display_date yes
set -g theme_date_format "+%H:%M:%S"
set -g theme_nerd_fonts yes
set -g theme_display_cmd_duration yes
set -g theme_color_scheme zenburn
# ~Theme~ #

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
end

if test -d $HOME/n/bin
  set -x PATH $N_PREFIX/bin $PATH
end

if test -d $HOME/miniconda3
  set -x PATH $HOME/miniconda3/bin $PATH
  source (conda info --root)/etc/fish/conf.d/conda.fish
end

