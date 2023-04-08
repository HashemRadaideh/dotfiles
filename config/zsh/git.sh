
# aliases
alias g='git'
alias g-search='git ls-files | grep'

alias add='git add'
alias add-all='git add --all'
alias add-patch='git add --patch'
alias add-update='git add --update'
alias add-verbose='git add --verbose'

alias apply='git apply'
alias apply-3='git apply --3way'

alias bisect='git bisect'
alias bisect-bad='git bisect bad'
alias bisect-good='git bisect good'
alias bisect-reset='git bisect reset'
alias bisect-start='git bisect start'

alias blame='git blame -b -w'

alias branch='git branch'
alias branch-a='git branch -a'
alias branch-d='git branch -d'
alias branch-D='git branch -D'
alias branch-m='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias branch-no-merge='git branch --no-merged'
alias branch-remote='git branch --remote'

alias clone='git clone'
alias clone-rs='git clone --recurse-submodules'

alias commit='git commit -m'
alias commit-v='git commit -v'
alias amend='git commit -v --amend'
alias amend-ne='git commit -v --no-edit --amend'
alias commit-v-a='git commit -v -a'
alias amend-a='git commit -v -a --amend'
alias amend-ne-a='git commit -v -a --no-edit --amend'
alias amend-ne-s-a='git commit -v -a -s --no-edit --amend'
alias commit-a='git commit -a -m'
alias commit-s='git commit -s -m'
alias commit-as='git commit -a -s'
alias commit-a-s='git commit -a -s -m'
alias commit-S='git commit -S'
alias commit-Ss='git commit -S -s'
alias commit-S-s='git commit -S -s -m'

alias checkout='git checkout'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcor='git checkout --recurse-submodules'

alias cherry-pick='git cherry-pick'
alias cp-cancel='git cherry-pick --abort'
alias cp-continue='git cherry-pick --continue'

alias describe='git describe --tags $(git rev-list --tags --max-count=1)'

alias diff='git diff'
alias diff-cached='git diff --cached'
alias diff-cached-wd='git diff --cached --word-diff'
alias diff-s='git diff --staged'
alias diff-tree='git diff-tree --no-commit-id --name-only -r'
alias diff-up='git diff @{upstream}'
alias diff-wd='git diff --word-diff'

alias fetch='git fetch'
alias fetch-all='git fetch --all'
alias fetch-pr='git fetch --prune'
alias fetch-tags='git fetch --tags'
alias fetch-all-tags='git fetch --all --tags'
alias fetch-all-pr='git fetch --all --prune'
alias fetch-all-pr-tags='git fetch --all --prune --tags'

alias stash='git stash'
alias stash-apply='git stash apply'
alias stash-pop='git stash pop'
alias stash-list='git stash list'

alias merge='git merge'
alias rebase='git rebase'
alias gfo='git fetch origin'

alias gclean='git clean -id'

alias remote='git remote'
alias reset='git reset --hard && git clean -dffx'

alias log='git log'
alias short-log='git shortlog -sn'

alias push='git push'
alias pull='git pull'
alias status='git status'


#
# Aliases
# (sorted alphabetically)
#

function gccd() {
  command git clone --recurse-submodules "$@"
  [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}

function gdv() { git diff -w "$@" | view - }

# --jobs=<n> was added in git 2.8


function ggf() {
  git push --force origin "${b:=$1}"
}
function ggfl() {
  git push --force-with-lease origin "${b:=$1}"
}

function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    git pull origin "${b:=$1}"
  fi
}

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    git push origin "${b:=$1}"
  fi
}

function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}

function ggu() {
  git pull --rebase origin "${b:=$1}"
}

alias ggpur='ggu'


alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'

alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log -g --pretty=%h) &!'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'

# use the default stash push on git 2.13 and newer

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gstall='git stash --all'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias gupom='git pull --rebase origin $(git_main_branch)'
alias gupomi='git pull --rebase=interactive origin $(git_main_branch)'
alias glum='git pull upstream $(git_main_branch)'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'

alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

unset git_version
