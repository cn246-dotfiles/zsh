# ZSH
export ZDOTDIR="$HOME/.config/zsh"
export HIST_STAMPS="mm/dd/yyyy"
export HISTFILE="$ZDOTDIR/log/zsh_history"

# PATH
typeset -U path
path=("$HOME/.local/bin" $path)
export PATH

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# HOMEBREW
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export HOMEBREW_NO_ANALYTICS=1

# LESS
export PAGER=less
export LESS='--mouse -F -i -R -Q -J -M -W -X -x4 -z-4'
export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

# PYTHON
export PYTHONUSERBASE="$HOME/.local"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# SSH Keys
if ! [[ ( -v SSH_CONNECTION || -v SSH_TTY ) ]]; then
  if ! ssh-add -q -L >/dev/null; then
    ssh-add --apple-load-keychain
  fi
fi

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
