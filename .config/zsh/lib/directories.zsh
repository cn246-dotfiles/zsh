setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

d() {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

alias cp='cp -i'

case "$(uname -s)" in
  Darwin)
    if command -v gls >/dev/null; then
      alias ls='gls -h --group-directories-first --color=auto'
    else
      alias ls='ls -h --color=auto'
    fi
    ;;
  Linux)
    alias ls='ls -h --group-directories-first --color=auto'
    ;;
  *)
    alias ls='ls -h --color=auto'
    ;;
esac

alias mkdir='mkdir -p'
alias mv='mv -i'
alias rm='rm -i'
