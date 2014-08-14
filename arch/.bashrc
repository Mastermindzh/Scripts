#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias aur='yaourt'
screenfetch -A 'UBUNTU'
PS1='[\u@\h \W]\$ '
