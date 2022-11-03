# My custom theme:
#   - single line
#   - quite simple by default: [user@host:$PWD]
#   - blue for local shell as non root
#   - magenta for ssh shell as non root
#   - red for root sessions
#   - prefix with remote address for ssh shells
#   - prefix to detect docker containers or chroot
#   - git plugin to display current branch and status

# git plugin 
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

function zsh_chaz_gitstatus {
        ref=$(git symbolic-ref HEAD 2> /dev/null) || return
        GIT_STATUS=$(git_prompt_status)
        if [[ -n $GIT_STATUS ]]; then
                GIT_STATUS=" $GIT_STATUS"
        fi
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# by default, use blue for user@host
local ZSH_CHAZ_PREFIX="["
local ZSH_CHAZ_USER_COLOR="blue"
local ZSH_CHAZ_HOST_COLOR="blue"
local ZSH_CHAZ_DIR_COLOR="green"
local ZSH_CHAZ_USER="%{%B$fg[$ZSH_CHAZ_USER_COLOR]%}%n%{$reset_color%b%}"
local ZSH_CHAZ_HOST="%{%B$fg[$ZSH_CHAZ_HOST_COLOR]%}%m%{$reset_color%b%}"
local ZSH_CHAZ_CWD="%{$fg[$ZSH_CHAZ_DIR_COLOR]%}%1~%{$reset_color%}"
local ZSH_CHAZ_SUFFIX="]"

if [[ -n "$SSH_CONNECTION" ]]; then
        # display the source address if connected via ssh
        ZSH_CHAZ_PREFIX="(%{$fg[orange]%}[$(echo $SSH_CONNECTION | cut -d' ' -f1)]%{$reset_color%})["
        # use orange to highlight a remote connection
        ZSH_CHAZ_HOST_COLOR="orange"
elif [[ -r /etc/debian_chroot ]]; then 
        # prefix prompt in case of chroot
        ZSH_CHAZ_PREFIX="(%{$fg[yellow]%}chroot:$(cat /etc/debian_chroot)]%{$reset_color%})["
elif [[ -r /.dockerenv ]]; then
        # also prefix prompt inside a docker container
        ZSH_CHAZ_PREFIX="(%{$fg[yellow]%}docker%{$reset_color%})["
fi
if [[ $UID = 0 ]]; then
        # always use red for root sessions, even in ssh
        ZSH_CHAZ_USER_COLOR="red"
fi

PROMPT='${ZSH_CHAZ_PREFIX}${ZSH_CHAZ_USER}@${ZSH_CHAZ_HOST}:${ZSH_CHAZ_CWD}${ZSH_CHAZ_SUFFIX}$(zsh_chaz_gitstatus)%(!.#.$) '
RPROMPT="%(?..%{$fg[red]%}%?%{$reset_color%})"
#RPROMPT="%t"
