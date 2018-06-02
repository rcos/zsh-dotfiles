autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*:*' stagedstr '%F{green}S%f' # default 'S'
zstyle ':vcs_info:git*:*' unstagedstr '%F{red}U%f' # default 'U'
zstyle ':vcs_info:git*:*' formats "%c%u%F{green}[%f%F{yellow}%b%f%F{green}]%f"                    # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats "%c%u|%F{cyan}%a%f%F{green}[%f%F{yellow}%b%f%F{green}]%f" # default ' (%s)-[%b|%a]%c%u-'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

function +vi-git-untracked() {
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+='%F{blue}+%f'
  fi
}

precmd () { vcs_info }

# AVAILABLE COLORS
# black red green yellow blue magenta cyan white

# Check the UID
if [[ $UID -eq 0 ]]; then
  eval PR_USER='%F{red}%n%f'
  eval PR_USER_OP='%F{red}%#%f'
else
  eval PR_USER='%F{blue}%n%f'
  eval PR_USER_OP='%F{blue}%#%f'
fi

# Set Directory Color
eval PR_DIR='%F{green}%.%f'

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  eval PR_HOST='%F{yellow}%m%f' # SSH
else
  eval PR_HOST='%F{cyan}%m%f'   # NO SSH
fi

RPROMPT='${vcs_info_msg_0_}'
PROMPT=$'[${PR_USER}@${PR_HOST}][${PR_DIR}]${PR_USER_OP} '
