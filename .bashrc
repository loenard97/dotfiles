#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# options
bind 'set completion-ignore-case on'
bind 'set bell-style none'
bind 'set show-all-if-ambiguous on'

# shell
shopt -s autocd             # cd to dir name
shopt -s cdspell            # infer correct cd spelling
shopt -s xpg_echo           # echo obey escape characters
shopt -s histverify         # verify hist cmd before executing
shopt -s histappend         # append to hist
shopt -s cmdhist
shopt -s checkwinsize       # redraw on resize
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups
HISTCONTROL=ignoreboth
HISTCONTROL=ignorespace
export HISTIGNORE="&:ls:clear:[bf]g:exit"

# ----- aliases -----
# colors
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

## ls
alias els='exa --icons'
alias ela='exa -a --icons'
alias ell='exa -la --icons --git'
alias elt='exa -laT --icons --git'
alias ols='ls --color'
alias ola='ls -a --color'
alias oll='ls -l --color'
alias ls='minils'
alias la='minils -a'
alias ll='minils -la'
alias lt='minils -ta'

## cat
alias cat='minicat'
alias ocat='cat'

## git
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
# alias gc='git commit -m'
alias gl='git log --oneline'
alias gb='git switch -c'
alias gd='git diff'
function gc()
{
    git commit -m $1
}

## other
alias nv="nvim ."
alias sv="source venv/bin/activate"
alias md='mkdir -p -v'
alias grep='grep --color=auto'
alias dirs='du -h -d 1 | sort -h -r'

# functions
function up()
{
    # default parameter to 1 if non provided
    declare -i d=${@:-1}
    # ensure given parameter is non-negative. Print error and return if it is
    (( $d < 0 )) && (>&2 echo "up: Error: negative value provided") && return 1;
    # remove last d directories from pwd, append "/" in case result is empty
    cd "$(pwd | sed -E 's;(/[^/]*){0,'$d'}$;;')/";
}

function setwal()
{
    # set wallpaper
    sh /home/dennis/.config/scripts/wallpaper.sh $1
}

function bm()
{
    # bookmark
    BMPATH=$(bookmark $1)
    if [[ -n "$BMPATH" ]]; then
        cd $BMPATH
    fi
}

function extract()
{
    # extract files
	if [ -f $1 ] ; then
    	case $1 in
        	*.tar.bz2)   tar xvjf $1    ;;
          	*.tar.gz)    tar xvzf $1    ;;
          	*.bz2)       bunzip2 $1     ;;
          	*.rar)       unrar x $1     ;;
          	*.gz)        gunzip $1      ;;
          	*.tar)       tar xvf $1     ;;
          	*.tbz2)      tar xvjf $1    ;;
          	*.tgz)       tar xvzf $1    ;;
          	*.zip)       unzip $1       ;;
          	*.Z)         uncompress $1  ;;
          	*.7z)        7z x $1        ;;
          	*)           echo "Unknown file type: '$1'" ;;
      	esac
  	else
      	echo "Not a valid file: '$1'"
  	fi
}

function colors()
{
    # print color scheme
    # credit to manjaro: https://gitlab.manjaro.org/packages/core/bash/-/blob/master/dot.bashrc
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black
            
            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

# PS
function exitstatus()
{
    # print exit status
	if [[ $? == 0 ]]; then
		echo ''
	else
		echo '   '
	fi
}

function git_branch()
{
    if [ -d .git ]; then
        printf "%s" "($(git branch 2> /dev/null | awk '/\*/{print $2}'))";
    fi
}

function __prompt_bash_set()
{
    # Create a string like:  "[ Apr 25 16:06 ]" with time in RED.
    printf -v PS1RHS "\e[0m[ \e[0;1;31m%(%b %d %H:%M)T \e[0m]" -1 # -1 is current time
    # if [ -d .git ]; then
    #     printf -v PS1RHS "$(git_diff)"
    # else
    #     printf -v PS1RHS "no git thingy here"
    # fi
    
    # Strip ANSI commands before counting length
    # From: https://www.commandlinefu.com/commands/view/12043/remove-color-special-escape-ansi-codes-from-text-with-sed
    PS1RHS_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$PS1RHS")
    
    # Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
    local Save='\e[s' # Save cursor position
    local Rest='\e[u' # Restore cursor to save point
    
    # Save cursor position, jump to right hand edge, then go left N columns where
    # N is the length of the printable RHS string. Print the RHS string, then
    # return to the saved position and print the LHS prompt.
    
    # Note: "\[" and "\]" are used so that bash can calculate the number of
    # printed characters so that the prompt doesn't do strange things when
    # editing the entered text.
    
    PS1="\[${Save}\e[${COLUMNS:-$(tput cols)}C\e[${#PS1RHS_stripped}D${PS1RHS}${Rest}\]${PS1}"
}
# PROMPT_COMMAND='__prompt_bash_set'

function git_diff()
{
    git diff --shortstat | sed 's/, /  /g' | sed 's/[[:alpha:]]//g'
}

function rightprompt()
{
    # nerd font cheat sheet
    # https://www.nerdfonts.com/cheat-sheet
    if [ -d .git ]; then
        if git_status=$(git status --porcelain) && [ -z "$git_status" ]; then
            printf "%*s" $COLUMNS "  $(git_branch)  "
        else
            printf "%*s" $COLUMNS "  $(git_branch)     $(git_diff)  "
        fi
    fi
}

# PS1='
#   \[\e[31m\]$(exitstatus)\[\e[1;34m\]\W\[\e[0m\]    '
if [ $(echo $TERM) == 'xterm-kitty' ]; then
    PS1='
\[$(tput sc; rightprompt; tput rc)\]  \[\e[31m\]$(exitstatus)\[\e[1;34m\]\W\[\e[0m\]    '
else
    PS1='[\u@\h \W]\$ '
fi


# rust
. "$HOME/.cargo/env"


# ----- old scripts -----
# if [ $(echo $TERM) == 'xterm-kitty' ]; then
#     bash_prompt
# else
#     PS1='[\u@\h \W]\$ '
# fi

# if [ $(echo $TERM) == 'xterm-kitty' ]; then
#     PS1='
#     \[\e[31m\]$(exitstatus)\[\e[1;34m\] $(git_branch) \W\[\e[0m\]    '
# else
#     PS1='[\u@\h \W]\$ '
# fi
