#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
# alias ls='exa --icons'
# alias la='exa -a --icons'
# alias ll='exa -la --icons --git'
# alias lt='exa -laT --icons --git'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -la --color=auto'

alias cat='bat'
alias grep='grep --color=auto'
alias up='cd ..'

# old PS1='[\u@\h \W]\$ '
PS1='
\W -> '

# rust
. "$HOME/.cargo/env"
