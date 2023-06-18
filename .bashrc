#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases

alias nv="nvim ."

# alias ls='exa --icons'
# alias la='exa -a --icons'
# alias ll='exa -la --icons --git'
# alias lt='exa -laT --icons --git'
alias ols='ls'
alias ls='minils'
alias la='minils -a'
alias ll='minils -la'
alias lt='minils -ta'

alias cat='minicat'
alias grep='grep --color=auto'
alias up='cd ..'

setwal ()
{
    sh /home/dennis/.config/scripts/wallpaper.sh $1
}

bm ()
{
    BMPATH=$(bookmark $1)
    if [[ -n "$BMPATH" ]]; then
        cd $BMPATH
    fi
}

exitstatus()
{
	if [[ $? == 0 ]]; then
		echo ''
	else
		echo '   '
	fi
}

# old PS1='[\u@\h \W]\$ '
# PS1='
#  \W -> '

if [ $(echo $TERM) == 'xterm-kitty' ]; then
PS1='
  \[\e[31m\]$(exitstatus)\[\e[1;34m\]\W\[\e[0m\]    '
else
PS1='[\u@\h \W]\$ '
fi

# PS2='    '

# rust
. "$HOME/.cargo/env"

