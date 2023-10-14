#
# ~/.bash_aliases
#

## ls
alias ls='exa --icons'
alias la='exa -a --icons'
alias ll='exa -la --icons --git'
alias lt='exa -laT --icons --git'
alias mls='minils'
alias mla='minils -a'
alias mll='minils -la'
alias mlt='minils -ta'

## cat
alias cat='bat'
alias mcat='minicat'

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

## datatools
alias h5="~/Projects/python/datatools/venv/bin/python ~/Projects/python/datatools/main.py"
alias plot="~/Projects/python/plot-cli/venv/bin/python ~/Projects/python/plot-cli/main.py"

## other
# alias nv="nvim ."
# alias nv='sh -e ~/.config/scripts/launch_nvim.sh'
alias sv="source venv/bin/activate"
alias md='mkdir -p -v'
alias grep='grep --color=auto'
alias dirs='du -h -d 1 | sort -h -r'
