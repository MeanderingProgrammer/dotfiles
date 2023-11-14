# General
alias reload="source ~/.zshrc"
alias ll="ls -latr"
alias workspace="cd ~/dev/repos"
alias notes="cd ~/Documents/notes"

# Git
alias gs="git status -uall"
alias gl="git log"
alias gb="git branch"
alias ga="git add --all"
alias gc="git commit -m"
alias gp="git push"
alias gm="git checkout main"
alias gu="git branch -u main"
alias gac="git add --all && git commit --amend"

# Yadm
alias yls="yadm ls-files ~"
alias ys="yadm status"
alias yd="yadm diff"
alias yl="yadm l"
alias ya="yadm add -u"
alias yc="yadm com"
alias yp="yadm push"

# Advent
alias a_run="./scripts/advent.py run"
alias a_gen="./scripts/advent.py generate"
