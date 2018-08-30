# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, only update PATH
case $- in
    *i*) ;;
      *) source $HOME/.path; return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[]*:exit:ls:bg:fg:history:clear"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# 1.   directory - Bold Cyan
# 2.   symbolic link - Magenta
# 3.   socket - Green
# 4.   pipe - Brown
# 5.   executable - Red
# 6.   block special - Blue Cyan
# 7.   character special - Blue Brown
# 8.   executable with setuid bit set - Black Red
# 9.   executable with setgid bit set - Black Cyan
# 10.  directory writable to others, with sticky bit - Black Green
# 11.  directory writable to others, without sticky bit - Black Brown

export LSCOLORS="Gxfxcxdxbxegedabagacad"

if command -v dircolors >/dev/null 2>&1; then
  eval $(dircolors -b $HOME/dotfiles/bash/dir_colors)
fi

source $HOME/dotfiles/bash/path
source $HOME/dotfiles/bash/aliases
source $HOME/dotfiles/bash/prompt
source $HOME/dotfiles/bash/env

for bashcmp in $HOME/dotfiles/completions/*.bash-completion; do
  source $bashcmp
done

if [[ $(which micro) ]]; then
  export EDITOR=micro
else
  export EDITOR=nano
fi

