# Load all stock functions (from $fpath files) called below.
autoload -U compaudit zmv zrecompile

# Plugins
plugins=(gpg-agent vi-mode)

is_plugin() {
  local base_dir=$1
  local name=$2
  builtin test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || builtin test -f $base_dir/plugins/$name/_$name
}

for plugin ($plugins); do
  if is_plugin "$ZDOTDIR" "$plugin"; then
    (( ${fpath[(Ie)"$ZDOTDIR/plugins/$plugin"]} )) \
      || fpath=("$ZDOTDIR/plugins/$plugin" $fpath)
    source "$ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh"
  else
    echo "Plugin '$plugin' not found"
  fi
done

unset plugin

# Config files
for config_file ("$ZDOTDIR"/lib/*.zsh); do
  source "$config_file"
done

# Functions
if [ -d "$ZDOTDIR"/functions ]; then
  for file ("$ZDOTDIR"/functions/*); do
    autoload -U "$file"
  done
fi

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

# Prompt
setopt prompt_subst

if [ -d "$ZDOTDIR"/prompts ]; then
  fpath=("$ZDOTDIR"/prompts $fpath)
  for file ("$ZDOTDIR"/prompts/*); do
    autoload -U "$file"
  done
fi

autoload -U promptinit && promptinit
prompt chaz

# Extras
umask 077

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
