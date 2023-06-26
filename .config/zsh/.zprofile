eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1

typeset -U path
path=(
  "$(brew --prefix)/bin"
  "$(brew --prefix)/sbin"
  "$HOME/.local/bin"
  $path
)
export PATH

typeset -U fpath
fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    $fpath
)
export FPATH

#typeset -gxU manpath MANPATH
#manpath=(
#    $manpath "$(brew --prefix)/share/man"
#)
#manpath=($^manpath(N-/))

#typeset -gxU infopath INFOPATH
#infopath=($infopath "$(brew --prefix)/share/info")
#infopath=($^infopath(N-/))

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
