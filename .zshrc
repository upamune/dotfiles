# create file 0644
umask 022
limit coredumpsize 0

# like emacs
bindkey -e

if [[ -f ~/.path ]]; then
  source ~/.path
else
  export DOTPATH="$HOME/dotfiles"
fi

export ENHANCD_FILTER="fzy:$ENHANCD_FILTER"

# load vital.sh
export VITAL_PATH="$DOTPATH/etc/lib/vital.sh"
if [[ -f $VITAL_PATH ]]; then
  source "$VITAL_PATH"
fi

# check vaital is loaded
if ! vitalize 2>/dev/null; then
  echo "$fg[red]cannot vitalize$reset_color" 1>&2
  return 1
fi

# tmux_automatically_attach attachs tmux session
$DOTPATH/bin/tmuxx

if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh
  export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zsh"

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    else
      echo
    fi
  fi
  zplug load --verbose
fi

export PATH=/usr/local/bin:$PATH

eval "$(direnv hook zsh)"
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"


eval "$(rbenv init -)"
# vim:fdm=marker fdc=3 ft=zsh ts=4 sw=4 sts=4:
