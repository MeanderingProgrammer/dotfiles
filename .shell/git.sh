# Aliases

alias gs="git status -uall"
alias gb="git branch"
alias gl="git log"

alias gr="git rebase -i"
alias gr-a="git rebase --abort"
alias gr-c="git rebase --continue"

alias gc="git checkout"
alias gmsg="git commit -m"
alias gac="git add . && git commit --amend"

alias git-reset="git checkout HEAD^"
alias git-hard-reset="git reset --hard HEAD~1"

alias gu="git branch -u main"
alias gm="git checkout main"

# Commands

gsw() {
  branches=($(git branch))
  if [[ "${#branches[@]}" == "3" ]]
  then
    if [[ "${branches[1]}" == "*" ]]
    then
      switch_to="${branches[3]}"
    else
      switch_to="${branches[1]}"
    fi
    git checkout "${switch_to}"
  fi
}
