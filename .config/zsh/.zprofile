# FZF
if [[ -d "$HOME/.local/src/fzf" ]]; then
  export DISABLE_FZF_AUTO_COMPLETION="false"
  export DISABLE_FZF_KEY_BINDINGS="false"
  export FZF_BASE="$HOME/.local/src/fzf/"
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
fi

# HOMEBREW
brew_binary=''
[[ -x "/opt/homebrew/bin/brew" ]] && brew_binary="/opt/homebrew/bin/brew"
[[ -x "$HOME/.local/homebrew/bin/brew" ]] && brew_binary="$HOME/.local/homebrew/bin/brew"

# PATH
if [[ -n "${brew_binary}" ]]; then
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

# LS
LS_COLORS=${LS_COLORS:-'no=00:fi=00:di=01;34:ln=36:su=01;04;37:sg=01;04;37:bd=01;33:pi=04;01;36:so=04;33:cd=33:or=31:mi=01;37;41:ex=01;36:su=01;04;37:sg=01;04;37:'}

# ORBSTACK
[[ -x "$HOME/.orbstack/shell/init.zsh" ]] && source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null

# SSH Keys
if [[ ! -v SSH_CONNECTION ]] || [[ ! -v SSH_TTY ]]; then
  if ! ssh-add -q -L >/dev/null; then
    case $(uname -s) in
      "Darwin")
        ssh-add --apple-load-keychain
        ;;
      "Linux")
        if grep -qslR "PRIVATE" "$HOME/.ssh/"; then
          ssh-add -l >/dev/null || ( grep -slR "PRIVATE" "$HOME/.ssh/" | xargs ssh-add )
        fi
        ;;
    esac
  fi
fi

# VIM
# Make sure virtualenv is accesible from Vim: https://vi.stackexchange.com/a/7654
# NOTE: seems to work without this -- is it b/c of the ale option?
# if [ -v VIRTUAL_ENV ] && [ -e "${VIRTUAL_ENV}/bin/activate" ]; then
#   source "${VIRTUAL_ENV}/bin/activate"
# fi

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
