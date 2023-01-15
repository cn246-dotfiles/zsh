# If ZDOTDIR is not defined, use the current script's directory.
[[ -z "$ZDOTDIR" ]] && export ZDOTDIR="${${(%):-%x}:a:h}"


###################
# Cache
###################
# Set ZSH_CACHE_DIR to the path where cache files should be created
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZDOTDIR/cache"
fi

# Make sure $ZSH_CACHE_DIR is writable, otherwise use a directory in $HOME
if [[ ! -w "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi

# Figure out the SHORT hostname
if [[ "$OSTYPE" = darwin* ]]; then
  # macOS's $HOST changes with dhcp, etc. Use ComputerName if possible.
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST="${HOST/.*/}"
else
  SHORT_HOST="${HOST/.*/}"
fi

if [[ -z "$ZCOMPDUMP" ]]; then
  ZCOMPDUMP="$ZSH_CACHE_DIR/.zcompdump-${SHORT_HOST}"
fi

# Create cache and completions dir and add to $fpath
mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

fpath=("$ZDOTDIR/functions" "$ZDOTDIR/completions" $fpath)

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit zrecompile

###################
# Plugins
###################
plugins=(gpg-agent vi-mode)

is_plugin() {
  local base_dir=$1
  local name=$2
  builtin test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || builtin test -f $base_dir/plugins/$name/_$name
}

for plugin ($plugins); do
  if is_plugin "$ZDOTDIR" "$plugin"; then
    fpath=("$ZDOTDIR/plugins/$plugin" $fpath)
  else
    echo "Plugin '$plugin' not found"
  fi
done


###################
# Load config files
###################
for config_file ("$ZDOTDIR"/lib/*.zsh); do
  source "$config_file"
done


###################
# Load plugins
###################
for plugin ($plugins); do
  if [[ -f "$ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh" ]]; then
    source "$ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh"
  fi
done
unset plugin

# Input/Output
setopt interactive_comments

# Job Control
setopt long_list_jobs

# Shell State
#setopt interactive
#setopt login
#setopt shinstdin

# ZLE
setopt combining_chars

# Safe paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic


###################
# Functions
###################
if [ -d "$ZDOTDIR"/functions ]; then
  for file ("$ZDOTDIR"/functions/*); do
    autoload -U "$file"
  done
fi


###################
# Prompt
###################
setopt prompt_subst

if [ -d "$ZDOTDIR"/prompts ]; then
  fpath=("$ZDOTDIR"/prompts $fpath)
  for file ("$ZDOTDIR"/prompts/*); do
    autoload -U "$file"
  done
fi

autoload -U promptinit && promptinit
prompt chaz


###################
# Extras
###################
umask 077
