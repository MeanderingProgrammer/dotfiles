# General
alias reload="source ~/.zshrc"
alias update-sys="yadm pull && yadm bootstrap"
alias ll="ls -latrh"
alias workspace="cd ~/dev/repos/personal"
alias notes="cd ~/Documents/notes"

# Git
alias gs="git status -uall"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"
alias ga="git add --all"
alias gc="git commit -m"
alias gb="git branch"
alias gac="git add --all && git commit --amend"
alias gm="git checkout main"
alias gu="git branch -u main"
alias gr="git rebase -i"
alias gundo="git restore ."

# Yadm
alias yb="yadm bootstrap"
alias ys="yadm status"
alias yl="yadm log"
alias yp="yadm push"
alias ypl="yadm pull"
alias ya="yadm add -u"
alias yc="yadm commit -m"
alias yac="yadm add ~/docs/ ~/.config/alacritty/ ~/.config/git/ ~/.config/helix/ ~/.config/homebrew/ ~/.config/kitty/ ~/.config/lang/ ~/.config/npm/ ~/.config/nvim/ ~/.config/shell/ ~/.config/shellcheckrc ~/.config/tmux/ ~/.config/vim/ ~/.config/wezterm/ ~/.config/yadm/"
alias yls="yadm ls-files ~"
alias yd="yadm diff"

# Pass
alias pas="pass git status"
alias pal="pass git log"
alias pap="pass git push"
alias papl="pass git pull"

# Advent
alias a-build="./scripts/advent.py build"
alias a-run="./scripts/advent.py run"
alias a-gen="./scripts/advent.py generate"
alias a-graph="./scripts/advent.py graph"
