# PATH
typeset -U path
path=(~/.local/bin $path)
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
if ! ssh-add -q -L >/dev/null; then
  ssh-add --apple-load-keychain
fi

# ZSH Aliases
if [ -d ~/.zshrc.d/aliases ]; then
  for file in ~/.zshrc.d/aliases/*; do
    if [ -r "$file" ]; then
      . "$file"
    fi
  done
fi

# ZSH Functions
if [ -d ~/.zshrc.d/functions ]; then
  fpath=(~/.zshrc.d/functions $fpath)
  for file in ~/.zshrc.d/functions/*; do
    if [ -r "$file" ]; then
      autoload -U "$file"
    fi
  done
fi
