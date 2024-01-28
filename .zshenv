# ZSH
if [[ "$OSTYPE" = darwin* ]]; then
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST="${HOST/.*/}"
else
  SHORT_HOST="${HOST/.*/}"
fi

export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$ZDOTDIR/cache"
export ZCOMPDUMP="$ZSH_CACHE_DIR/.zcompdump-${SHORT_HOST}"
export SHELL_SESSIONS_DISABLE=1

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# FZF
if [[ -d "$HOME/.local/src/fzf" ]]; then
  export FZF_BASE="$HOME/.local/src/fzf/"
  export DISABLE_FZF_AUTO_COMPLETION="false"
  export DISABLE_FZF_KEY_BINDINGS="false"
fi

# LESS
export PAGER=less
export LESS='--mouse -F -i -R -Q -J -M -W -X -x4 -z-4'
export LESSOPEN="|$HOME/.local/bin/lesspipe.sh %s"

# PYTHON
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONUSERBASE
export PYTHONPATH="$HOME/Projects/python/modules"
export PYTHONUSERBASE="$HOME/.local"

# RIPGREP
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# SSH Keys
if ! [ -v SSH_CONNECTION ] || ! [ -v SSH_TTY ]; then
  if ! ssh-add -q -L >/dev/null; then
    ssh-add --apple-load-keychain
  fi
fi

# VIM
# Make sure virtualenv is accesible from Vim: https://vi.stackexchange.com/a/7654
# NOTE: seems to work without this -- is it b/c of the ale option?
# if [ -v VIRTUAL_ENV ] && [ -e "${VIRTUAL_ENV}/bin/activate" ]; then
#   source "${VIRTUAL_ENV}/bin/activate"
# fi

# YAMLFIX
if [[ -f "$HOME/.config/yamlfix/yamlfix" ]]; then
  source "$HOME/.config/yamlfix/yamlfix"
fi

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
