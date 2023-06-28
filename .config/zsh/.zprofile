eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1

typeset -U path
path=(
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$HOME/.local/bin"
  $path
)
export PATH

typeset -U fpath
fpath=(
    "$HOMEBREW_PREFIX/share/zsh/site-functions"
    "$ZDOTDIR/functions"
    "$ZDOTDIR/completions"
    $fpath
)
export FPATH

#typeset -gxU manpath MANPATH
#manpath=(
#    $manpath "$HOMEBREW_PREFIX/share/man"
#)
#manpath=($^manpath(N-/))

#typeset -gxU infopath INFOPATH
#infopath=($infopath "$HOMEBREW_PREFIX/share/info")
#infopath=($^infopath(N-/))

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
