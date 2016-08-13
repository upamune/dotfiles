# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
  echo "cannot run as shell script" 1>&2
  return 1
fi

# PROMPT
#
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
  print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})${HOST}%{${reset_color}%}]%# "

# Right PROMPT
#
setopt prompt_subst
# Automatically hidden rprompt
# however, 
setopt transient_rprompt

r-prompt() {
  if has '__git_ps1'; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_DESCRIBE_STYLE="branch"
    export GIT_PS1_SHOWCOLORHINTS=0
    RPROMPT='%{'${fg[red]}'%}'`echo $(__git_ps1 "(%s)")|sed -e s/%/%%/|sed -e s/%%%/%%/|sed -e 's/\\$/\\\\$/'`'%{'${reset_color}'%}'
    RPROMPT+=$' at %{${fg[blue]}%}[%~]%{${reset_color}%}'
    RPROMPT+='${p_buffer_stack}'
  else
    RPROMPT='[%{$fg[blue]%}%~%{$reset_color%}]'
  fi
}
add-zsh-hook precmd r-prompt

# Other PROMPT
#
SPROMPT="%{${fg[red]}%}Did you mean?: %R -> %r [nyae]? %{${reset_color}%}"

