if ! vitalize 2>/dev/null; then
  echo "cannot run as shell script" 1>&2
  return 1
fi

if is_linux; then
  export EMOJI_CLI_FILTER=peco
fi

export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'
