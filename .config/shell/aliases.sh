# General
alias reload="source ~/.zshrc"
alias ll="ls -latr"
alias workspace="cd ~/dev/repos"
alias notes="cd ~/Documents/notes"

# Git
alias gs="git status -uall"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"
alias ga="git add --all"
alias gc="git commit -m"
alias gb="git branch"
alias gm="git checkout main"
alias gu="git branch -u main"
alias gac="git add --all && git commit --amend"
alias gundo="git restore ."

# Yadm
alias ys="yadm status"
alias yl="yadm log"
alias yp="yadm push"
alias ypl="yadm pull"
alias ya="yadm add -u"
alias yc="yadm commit -m"
alias yls="yadm ls-files ~"
alias yd="yadm diff"

# Pass
alias pas="pass git status"
alias pal="pass git log"
alias pap="pass git push"
alias papl="pass git pull"

# Advent
alias a_setup="./scripts/advent.py setup"
alias a_run="./scripts/advent.py run"
alias a_gen="./scripts/advent.py generate"
alias a_graph="./scripts/advent.py graph"
