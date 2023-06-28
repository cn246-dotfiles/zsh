# ZSH
if [[ "$OSTYPE" = darwin* ]]; then
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST="${HOST/.*/}"
else
  SHORT_HOST="${HOST/.*/}"
fi

export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$ZDOTDIR/cache"
export ZCOMPDUMP="$ZSH_CACHE_DIR/.zcompdump-${SHORT_HOST}"

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# LESS
export PAGER=less
export LESS='--mouse -F -i -R -Q -J -M -W -X -x4 -z-4'
export LESSOPEN="|$HOME/.local/bin/lesspipe.sh %s"

# PYTHON
export PYTHONPATH="$HOME/Projects/python/modules"
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
