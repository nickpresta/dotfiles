# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Custom prompt
PS1="[\d \t] \[\e[33;1m\]\u\[\e[37;1m\]@\[\e[32;1m\]\h\[\e[20;1m\]\[\e[34;1m\](\[\e[31;1m\]\w\[\e[34;1m\])\[\e[0m\]\$\[\e[0m\] "

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

fortune -n 1
