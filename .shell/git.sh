# Aliases

alias gs="git s"
alias gb="git b"
alias gl="git l"

alias gac="git aa && git coa"

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
