# -------
# Aliases
# -------
alias c='code .' # Open in VS Code
alias ns='npm start'
alias start='npm start'
alias nr='npm run'
alias run='npm run'
alias ll="ls -al" # List all files in current directory in long list format
alias o="open ." # Mac - Open the current directory in Finder
# alias o="start ." # Windows - Open the current directory in Explorer

# -------
# GrizzlEmail Aliases
# -------
alias grizz='npm run dev'
alias grizzbuild='npm run build'

# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gb='git branch -a'
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gckd='git checkout develop'
alias gckm='git checkout main'
alias gckp='git checkout production'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gmd='git merge develop'
alias gmdconflict='git pull origin develop --no-rebase'
alias gp='git pull'
alias gpf='git push -f origin'
alias gprune='git remote prune origin'
alias gpsh='git push'
alias gpd='git push --delete origin'
alias gpu='git push -u origin'
alias grhd='git remote set-head origin -d'
alias gss='git status -s'
alias gs='echo ""; echo "*********************************************";
echo -e " DO NOT FORGET TO PULL BEFORE COMMITTING"; echo
"*********************************************"; echo ""; git status'

# -------
# Functions
# -------
function grs() {
  # Update the remote url for any local repositiories that were
  # cloned before SSH was set up
  # ======
  # Pattern: grs <lowercase_name_of_repo>
  # Example: grs asics.emailui
  # ======
  git remote set-url origin git@bitbucket.org:degdigital/$1.git
}

function mkcd() {
  # Makes a directory and changes to it
  # ======
  # Pattern: mkcd <folder_name>
  # Example: mkcd templates
  # ======
  mkdir "$1" && cd $_
}

function grizzcopy() {
  # Copies the default GrizzlEmail files to the current directory path
  # ======
  # Pattern: grizzcopy <create parent folder> <create project folder>
  # Example: grizzcopy main v1
  # Results: brand/main/v1/...GrizzlEmail files...
  # ======
  # Mac
  mkdir "$1" && cd $_ && rsync -a --exclude .git --exclude dist --exclude /node_modules/ ~/Dev/UI/@GrizzlEmail/ $2 && cd $_ && npm install
  # Windows
  # mkdir "$1" && cd $_ && cp -r --exclude=".git" --exclude="dist" --exclude="node_modules" "c:\dev\@GrizzlEmail" "$2" && cd $_ && npm install # Windows
}

function prcm() {
  # Pull request conflict merge commit
  # ======
  # Pattern: prcm <pull request number>
  # Example: prcm 48
  # ======
  git commit -m "Resolved merge conflict for PR #$1"
}