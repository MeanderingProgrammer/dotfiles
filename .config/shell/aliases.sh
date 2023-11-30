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
alias gpl="git pull"
alias gm="git checkout main"
alias gu="git branch -u main"
alias gac="git add --all && git commit --amend"

# Yadm
alias yls="yadm ls-files ~"
alias ys="yadm status"
alias yd="yadm diff"
alias yl="yadm log"
alias ya="yadm add -u"
alias yc="yadm commit -m"
alias yp="yadm push"
alias ypl="yadm pull"

# Pass
alias pas="pass git status"
alias pal="pass git log"
alias pap="pass git push"
alias papl="pass git pull"

# Advent
alias a_run="./scripts/advent.py run"
alias a_gen="./scripts/advent.py generate"
alias a_graph="./scripts/advent.py graph"
