function fzf_setup_using_base_dir() {
  local fzf_base fzf_shell

  test -d "${FZF_BASE}" && fzf_base="${FZF_BASE}"

  if [[ ! -d "${fzf_base}" ]]; then
    return 1
  fi

  fzf_shell="${fzf_base}/shell"

  # Auto-completion
  if [[ -o interactive && "$DISABLE_FZF_AUTO_COMPLETION" != "true" ]]; then
    source "${fzf_shell}/completion.zsh" 2> /dev/null
  fi

  # Key bindings
  if [[ "$DISABLE_FZF_KEY_BINDINGS" != "true" ]]; then
    source "${fzf_shell}/key-bindings.zsh"
  fi
}

fzf_setup_using_base_dir

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  elif (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  elif (( $+commands[ag] )); then
    export FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore .git'
  fi
fi

# vim: ft=zsh ts=2 sts=2 sw=2 sr et
