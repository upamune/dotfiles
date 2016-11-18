# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

has 'history-substring-search-up' &&
    bindkey '^P' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey '^N' history-substring-search-down


# functions
do-enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return
    fi

    echo
    if is_git_repo; then
        git status
    else
        ls -GF
    fi

    zle reset-prompt
}
zle -N do-enter
bindkey '^m' do-enter

_peco-select-history() {
    if true; then
        BUFFER="$(
        history 1 \
            | sort -k1,1nr \
            | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' \
            | peco --query "$LBUFFER"
        )"

        CURSOR=$#BUFFER
        #zle accept-line
        #zle clear-screen
        zle reset-prompt
    else
        if is-at-least 4.3.9; then
            zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
        else
            history-incremental-search-backward
        fi
    fi
}
zle -N _peco-select-history
bindkey '^r' _peco-select-history

# Shift + TAB back menu complete
bindkey '^[[Z' reverse-menu-complete

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^x^g' peco-src

function fzy-git-checkout () {
  git checkout `git branch | fzy | sed -e "s/\* //g" | awk "{print \$1}"`
  zle clear-screen
}
zle -N fzy-git-checkout
bindkey '^x^o' fzy-git-checkout
