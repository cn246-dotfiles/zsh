# ZSH
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$ZDOTDIR/cache"
export ZCOMPDUMP="$ZSH_CACHE_DIR/completions/zcompdump"
export SHELL_SESSIONS_DISABLE=1

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR

# LESS
export PAGER=less
export LESS='--mouse -F -i -R -Q -J -M -W -X -x4 -z-4'
export LESSOPEN="|$HOME/.local/bin/lesspipe.sh %s"

# PYTHON
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONUSERBASE
export PYTHONPATH="$HOME/Projects/python/modules"
export PYTHONUSERBASE="$HOME/.local"
export UV_NO_MODIFY_PATH=1

# RIPGREP
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# YAMLFIX
if [[ -f "$HOME/.config/yamlfix/yamlfix" ]]; then
  source "$HOME/.config/yamlfix/yamlfix"
fi

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
