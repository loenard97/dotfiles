#
# ~/.bash_aliases
#

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
alias gaa='git add --all && git status'
alias gl='git log --oneline'
alias gb='git switch -c'
alias gd='git diff'
alias gls='git ls-files'
alias gu='git push && git status'
alias gd='git pull && git status'
function gc()
{
    if [ "$#" -ne 1 ]; then
        echo "commit message required" >&2
    fi
    git commit -m "$1"
}

## other
alias nv="nvim ."
alias sv="source venv/bin/activate"
alias md='mkdir -p -v'
alias grep='grep --color=auto'
alias dirs='du -h -d 1 | sort -h -r'
