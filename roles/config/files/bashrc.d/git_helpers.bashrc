# This file is managed by Ansible
# Do not make local modifications directly

#!/usr/bin/env bash

GIT_PROMPT="$HOME/.local/bin/git-prompt"
if [[ -f $GIT_PROMPT ]]
then
  PROMPT_COMMAND=${GIT_PROMPT}
fi

function _repo_check() {
  # Will still print git warning to STDERR, but then exit
  if ! git status >> /dev/null
  then
    return 1
  fi
  return 0
}

function _git_delmerged(){
  # Make sure this is a git repo
  _repo_check || return

  git branch --merged | grep -v -E 'master|main' |xargs --no-run-if-empty git branch -D
}

function _git_rebase_upstream(){
  # Make sure this is a git repo
  _repo_check || return

  local upstream_remote=$(git remote get-url upstream |awk -F\: '{gsub(".git$", "");print $2}')
  if [ -z $upstream_remote ]
  then
    echo "No \"upstream\" remote found"
    return 1
  fi

  local origin_remote=$(git remote get-url origin |awk -F\: '{gsub(".git$", "");print $2}')
  if [ -z $origin_remote ]
  then
    echo "No \"origin\" remote found"
    return 1
  fi

  gh repo sync $origin_remote
  git pull -r
}

git() {
  if [[ "$@" =~ "delete-merged" ]]
  then
    shift 1
    _git_delmerged
  elif [[ "$@" =~ "rebase-upstream" ]]
  then
    shift 2
    _git_rebase_upstream
  else
    command git "$@"
  fi
}

