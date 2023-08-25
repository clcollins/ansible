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

function git_delmerged(){
  # Make sure this is a git repo
  _repo_check || return

  git branch --merged | grep -v -E 'master|main' |xargs --no-run-if-empty git branch -D
}

function git_remain(){
  # Make sure this is a git repo
  _repo_check || return

  local gh_url=$(git remote get-url origin |awk -F\: '{gsub(".git$", "");print "https://github.com/"$2"/settings/branches"}')

  git branch -m master main && \
  git push -u origin main && \
  git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main && \
  read -d "" <<- EOF

  echo "Updated local branch to main and pushed to origin"
  echo "Next step: change the default branch in Github's UI:"
  echo ""
  echo $gh_url
  echo ""
  echo "Then run:"
  echo "git push push origin --delete master"
EOF
}

function git_rebase_upstream(){
  # Make sure this is a git repo
  _repo_check || return

  local startbranch="$(git describe --contains --all HEAD)"
  local branch="master"

  if ! [[ -z "{$1}" ]]
  then
    branch="${1}"
  fi

  git checkout $branch || return
  git fetch upstream && \
  git fetch upstream --tags && \
  git rebase upstream/${branch} && \
  git push origin ${branch} && \
  git push origin --tags && \
  git checkout ${startbranch}
}

