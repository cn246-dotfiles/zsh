brew_binary=''
[ -x "/opt/homebrew/bin/brew" ] && brew_binary="/opt/homebrew/bin/brew"
[ -x "$HOME/.local/homebrew/bin/brew" ] && brew_binary="$HOME/.local/homebrew/bin/brew"

if [ -n "${brew_binary}" ]; then
  eval "$(${brew_binary} shellenv)"
  export HOMEBREW_NO_ANALYTICS=1

  typeset -U path
  path=(
    "$HOME/.local/bin"
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    $path
  )

  typeset -U fpath
  fpath=(
      "$ZDOTDIR/functions"
      "$ZDOTDIR/completions"
      "$HOMEBREW_PREFIX/share/zsh/site-functions"
      $fpath
  )
else
  typeset -U path
  path=(
    "$HOME/.local/bin"
    $path
  )

  typeset -U fpath
  fpath=(
      "$ZDOTDIR/functions"
      "$ZDOTDIR/completions"
      $fpath
  )
fi

export FPATH PATH

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
