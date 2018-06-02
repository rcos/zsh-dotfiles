# ~/.zshenv
#
# Global Order: zshenv > [zprofile] > zshrc > [zlogin]

# Use Vim as VISUAL and EDITOR
export PAGER='less -m'
export EDITOR='vim'
export VISUAL=$EDITOR

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
