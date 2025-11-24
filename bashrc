# shell options
shopt -s histappend cmdhist checkwinsize autocd

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace

# resolve dotfiles directory, even when sourced via symlink
_dotfiles_source="${BASH_SOURCE[0]}"
while [ -L "$_dotfiles_source" ]; do
  _dir="$(cd -P "$(dirname "$_dotfiles_source")" && pwd)"
  _dotfiles_source="$(readlink "$_dotfiles_source")"
  case "$_dotfiles_source" in
    /*) ;;
    *) _dotfiles_source="$_dir/$_dotfiles_source" ;;
  esac
done
export DOTFILES_DIR="${DOTFILES_DIR:-$(cd -P "$(dirname "$_dotfiles_source")" && pwd)}"
unset _dotfiles_source _dir

# history file
export HISTFILE="$HOME/.bash_history"

# key bindings
set -o emacs

# aliases
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '

# common ls settings
case "$(uname)" in
  Darwin)
    export CLICOLOR=1
    alias ls='ls -G -F'
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    ;;
esac

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons'
  alias l='ls'
  alias la='eza -a --icons'
  alias ll='eza -l --icons'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

# git helpers
alias gpush='git push origin HEAD'
alias gpull='git pull'
alias gmaster='git checkout master'
alias gs='git status'
alias gc='git commit'

gcheck() {
  if [ -z "${1-}" ]; then
    echo "Usage: gcheck <branch-name>" >&2
    return 1
  fi

  local branch_name="$1"
  local remote_branch="origin/$branch_name"

  if git show-ref --verify --quiet "refs/heads/$branch_name"; then
    echo "Switching to existing local branch '$branch_name'."
    git checkout "$branch_name"
  elif git rev-parse --verify --quiet "$remote_branch" >/dev/null; then
    echo "Creating new local branch '$branch_name' to track '$remote_branch'."
    git checkout --track "$remote_branch"
  else
    echo "Creating new local branch '$branch_name'."
    git checkout -b "$branch_name"
  fi
}

gr() {
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -eq 0 ]; then
    cd "$git_root" || return
  else
    echo "cdg: not a git repository" >&2
    return 1
  fi
}

# ghq + fzf
fzf_ghq() {
  command -v ghq >/dev/null 2>&1 || return
  command -v fzf >/dev/null 2>&1 || return

  local loc fullloc
  loc="$(ghq list | fzf --cycle)"
  if [ -n "$loc" ]; then
    fullloc="$(ghq root)/$loc"
    cd "$fullloc" || return
  fi
}

case "$-" in
  *i*)
    if command -v ghq >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
      bind -x '"\C-g":fzf_ghq'
    fi
    ;;
esac

# exit helper for tmux
exit() {
  if [ -z "${TMUX-}" ]; then
    builtin exit
    return
  fi

  panes=$(tmux list-panes | wc -l)
  wins=$(tmux list-windows | wc -l)
  count=$((panes + wins - 1))
  if [ $count -eq 1 ]; then
    tmux detach
  else
    builtin exit
  fi
}

# aqua
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG="${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml"
if command -v aqua >/dev/null 2>&1; then
  export PATH="$(aqua root-dir)/bin:$PATH"
fi

# aqua with Node.js
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm-global"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# mise
if [ ! -x "$HOME/.local/bin/mise" ] && [ -x "$DOTFILES_DIR/setup-mise.sh" ]; then
  echo "mise not found. Running setup-mise.sh..."
  (cd "$DOTFILES_DIR" && ./setup-mise.sh)
fi

if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi

# direnv / zoxide
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# starship prompt
_starship_config="$DOTFILES_DIR/config/starship.toml"
if [ -f "$_starship_config" ]; then
  export STARSHIP_CONFIG="$_starship_config"
  if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
  fi
fi
unset _starship_config

# git commit helper using claude CLI
gca() {
  local staged_diff commit_message prompt
  staged_diff=$(git diff --staged)

  if [ -z "$staged_diff" ]; then
    echo "ステージされている変更がありません。"
    return 1
  fi

  prompt="ステージされたgitの差分を要約したコミットタイトルを作成してください。タイトルのみを返信し、肯定の言葉やその他の説明は不要です。"
  commit_message=$(echo "$staged_diff" | claude -p "$prompt")

  if [ -z "$commit_message" ]; then
    echo "エラー: Claudeからのコミットメッセージ生成に失敗しました。"
    return 1
  fi

  git commit -m "$commit_message"
  echo "Executed: git commit -m \"$commit_message\""
}

yo() {
  local model_flag=""
  if [ -n "${CLAUDE_CODE_MODEL-}" ]; then
    model_flag="--model $CLAUDE_CODE_MODEL"
  fi

  local add_dir_flag=""
  if [ -n "${OBSIDIAN_VAULT_DIR-}" ]; then
    add_dir_flag="--add-dir=$OBSIDIAN_VAULT_DIR"
  fi

  local cmd="claude --dangerously-skip-permissions $add_dir_flag $model_flag $*"
  echo "$cmd"
  eval "$cmd"
}

oo() {
  if [ -z "${OBSIDIAN_VAULT_DIR-}" ]; then
    echo "エラー: OBSIDIAN_VAULT_DIR環境変数が設定されていません。"
    return 1
  fi
  cd "$OBSIDIAN_VAULT_DIR" || return
}

export EDITOR="nvim"

# local overrides
if [ -f "$HOME/.bashrc.local" ]; then
  # shellcheck source=/dev/null
  . "$HOME/.bashrc.local"
fi
