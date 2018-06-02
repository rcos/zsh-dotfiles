# ~/.zshrc
#
# Global Order: zshenv > [zprofile] > zshrc > [zlogin]

## History -------------------------------------------------------------------
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/code/dotfiles

## fpath setup ---------------------------------------------------------------
# load our own completion functions
fpath=(
  /usr/local/share/zsh/site-functions
  $fpath
)

# load custom executable functions
for function in $ZSH/zsh/functions/*; do
  source $function
done

## Modules -------------------------------------------------------------------
autoload -U zmv

zmodload zsh/stat           # Improved file stat details
zmodload zsh/zftp           # A built in FTP client to the shell, awesome!

## Options -------------------------------------------------------------------
setopt appendhistory        #
setopt sharehistory         # share history across shells
setopt histignorealldups    # Remove older duplicate history items
setopt histverify           # perform history expansion and reload the line into the editing buffer
setopt extendedhistory      # Save each command’s beginning timestamp
setopt autocd               # use 'cd x' if 'x' is run and is not a command
setopt automenu             # show completion menu on succesive tab press
setopt promptsubst          # Allow for functions in the prompt.
setopt extendedglob         # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns
setopt nomatch              #
setopt notify               #
setopt alwaystoend          # cursor is moved to the end of the word with completion
setopt clobber              # allow clobbering with >, no need to use >!
setopt interactivecomments  # allow comments, even in interactive shells
setopt completealiases      # Prevents aliases on the command line from being internally substituted
setopt ignoreeof            # Do not exit on end-of-file.

unsetopt correct correctall # Try to correct the spelling of commands.
unsetopt beep               # No beeps on error

## Key Bindings --------------------------------------------------------------
bindkey -v

## Colors --------------------------------------------------------------------
# makes color constants available
autoload -U colors zsh/terminfo
colors

## Autoload *.zsh ------------------------------------------------------------
typeset -U config_files
config_files=($ZSH/zsh/*.zsh)

for file in ${config_files}
do
  source $file
done

## Completion ----------------------------------------------------------------
zmodload zsh/complist
unset config_files

autoload -Uz compinit
compinit

# Hostname for Completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH/cache

# cd will never select the parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle :compinstall filename '${HOME}/.zshrc'

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' menu select

# Completion for Processes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

## Prompt --------------------------------------------------------------------
source $ZSH/zsh/prompt.zsh

## cdpath --------------------------------------------------------------------
cdpath=(
  $HOME/code
)

## Local config --------------------------------------------------------------
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
