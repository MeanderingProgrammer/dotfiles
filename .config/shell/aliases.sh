# general
alias reload='source ~/.zshrc'
alias update-sys='yadm pull && yadm bootstrap'
alias ll='ls -latrh --color=auto'
alias workspace='cd ~/dev/repos/personal'
alias notes='cd ~/Documents/notes'
alias wget='wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts'

# git
alias gs='git status -uall'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias ga='git add --all'
alias gc='git commit -m'
alias gb='git branch'
alias gac='git add --all && git commit --amend'
alias gm='git checkout main'
alias gu='git branch -u main'
alias gr='git rebase -i'
alias gundo='git restore .'

# tmux
alias tmux-exit='tmux kill-server'
alias tmux-switch='tmux switch-client -t "$(tmux ls -F "#S" | fzf)"'

# yadm
alias yb='bash ~/.config/yadm/bootstrap'
alias ys='yadm status'
alias yl='yadm log'
alias yp='yadm push'
alias ypl='yadm pull'
alias ya='yadm add -u'
alias yc='yadm commit -m'
alias yac='yadm add ~/.config/alacritty/ ~/.config/ghostty/ ~/.config/git/ ~/.config/helix/ ~/.config/kitty/ ~/.config/lang/ ~/.config/lazygit/ ~/.config/mise/ ~/.config/npm/ ~/.config/nvim/ ~/.config/shell/ ~/.config/shellcheckrc ~/.config/tmux/ ~/.config/vim/ ~/.config/wezterm/ ~/.config/yadm/ ~/.ssh/config ~/docs/ ~/.zshenv ~/.zshrc'
alias yls='yadm list -a'
alias yd='yadm diff'
alias ydp='yadm diff HEAD'

# pass
alias pas='pass git status'
alias pal='pass git log'
alias pap='pass git push'
alias papl='pass git pull'

# advent
alias a-build='./scripts/advent.py build'
alias a-run='./scripts/advent.py run'
alias a-gen='./scripts/advent.py generate'
alias a-graph='./scripts/advent.py graph'
