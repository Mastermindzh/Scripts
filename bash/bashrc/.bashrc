#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ./.alias

bash .greeter.sh
PS1='[\u@\h \W]\$ '
