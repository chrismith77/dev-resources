# Git Commands Cheat sheet
Git is the backbone version control system for many popular code repository hosting services. Understanding how to work with Git through the terminal can be overwhelming at first. This cheat sheet will help aid you with some of the most common commands that you'll find yourself using with Git.

Keep in mind, this is a very small sample of Git commands. Besides googling "how do I do *'this'* with Git?", a great resource for everything Git is their [website](https://git-scm.com/).

&nbsp;  
## General Git info

### Getting a list of available branches
Checks the repository for all available branches (local and remote). All existing repositories should contain at least a **main** branch.
```bash
git branch -a
```

### Listing a log of commits
Shows a log of all the previous commits.
```bash
git log
```
You can also limit the number of commits to show.
```bash
git log --max-count=<number>
```

### Show merged branches
Show branches that have been merged into the specified branch `<branch_name>`. Ideal for checking to see if your `<feature_branch>` has been merged into the main branch.
```bash
git branch --merged <branch_name>
```

### Show branches that have not been merged
Show branches that have not been merged into the specified branch `<branch_name>`.
```bash
git branch --no-merged <branch_name>
```

&nbsp;  
## Working with existing branches

### Checking out a specific branch
To check out a branch that is present in the branch list (accessed from the `git branch -a` command).
```bash
git checkout <branch_name>
```

### Get the latest code
To ensure you are working off of the latest code you will need to pull the most recent updates from the repository.
```bash
git pull
```

### Creating a new local feature branch
The code base for a new branch starts from where you are branching from, so make sure the branch you are currently on has the code you want to start with before creating the new branch.
```bash
git checkout -b <feature_branch_name>
```
 
### Adding your newly created local branch to the remote repository
Before doing any work, you will want to sync your new local branch with the remote repository so that you can start tracking the changes between the local and remote branches. -u tells git to push the changes upstream.
```bash
git push -u origin <feature_branch_name>
```

&nbsp;  
## Applying code changes to the repo

### Staging changes
Files that have been changed must be staged before committing. This allows you to control which files will get pushed with each commit. To add files to staging, use one of the commands below.

Using `.` tells git to add all new and modified files in the current directory. This is dependent on the terminal's directory path when the command was executed, so only the directory and it's subdirectories will be added. In most cases, you should already be at the root level of the project to run the build tool, so this command will likely be your go-to.
```bash
git add .
```

Alternatively, you can ensure that all new and modified files that are located anywhere within the repository are added.
```bash
git add -A
```

You may also find it useful to add files one at a time by name.
```bash
git add file.astro
```

### Commit all staged files
Only staged files will be committed. The `-m` tells git to attach a message to the commit. It is best practice to add a short descriptive message about the commit on every commit. Each commit should start with the ticket number (if available) for referencing later.
```bash
git commit -m "Ticket# - <add_your_commit_message>"
```

### Amend your last commit message
OK, sometimes you make a mistake in your commit message and you need to fix it. Luckily, it's not hard to fix the last commit message. It's a bit more involved when you need to fix messages beyond the last one. So unless you are super comfortable with Git I would cut your losses if the one you need to fix is not the last commit.
```bash
git commit --amend
```

This will pull up a VIM editor in your terminal with the last commit message. If you've never encountered VIM before, it's a little confusing, so here's a [cheat sheet](https://vim.rtorr.com/) that I would recommend bookmarking.

To edit the commit message, type:
```bash
i
# hit enter/return to execute
```
This tells VIM you want to **insert** something. The cursor will be placed at the start of your commit message and you can use the keyboard to update your message.

Once you are done editing the message you can hit the esc key to exit the insert mode. Once you're out of the insert mode you can save the message and exit VIM by typing:
```bash
:wq
# hit enter/return to execute
```

Not a fan of VIM? You can make VS Code your default Git editor by running this command in your terminal.
```bash
git config --global core.editor "code -- wait"
```

If your last commit hadn't been pushed to the remote repository yet, then you can push your commit up normally. However, if you're commit was already pushed up to the remote repository then, regardless of what editor you used, you'll need to push your amended commit with:
```bash
git push -f origin <branch_name>
```

### Push all commits up to the remote repository
Until you have pushed your commits to the remote repository, your committed changes are only stored locally and not accessible to anyone else. Using the push command syncs the remote repo with your local changes so that everyone can access it.
```bash
git push
```

&nbsp;  
## Stashing

### Stashing changes
Let's face it, sometimes you need to switch branches but you're not ready to commit your current changes. Or worse, you've made some changes on the wrong branch but you don't want to start over on the correct branch. Let me introduce you to your new best friend ...
```bash
git stash -u
```

This will take all of your current uncommitted changes and stash them away. Now you can checkout a different branch to work on and come back to your stashed changes later, or you can apply those stashed changes to a different branch. The `-u` ensures that all untracked files are also included in the stash.

### Applying stashed changes
Stashed changes can be applied to any existing branch. Just checkout the branch you want to apply the stashed files to, and pop'em in there.
```bash
git stash pop
```

### Creating a branch from your stash
Did you forget to make your feature branch before making some changes? No worries, you can easily create a new branch and apply all your stashed changes at the same time!
```bash
git stash branch <feature_branch_name>
```

You can learn more about stashing in this [tutorial](https://www.atlassian.com/git/tutorials/saving-changes/git-stash).

&nbsp;  
## Removing feature branches

### Delete a local feature branch
Once the branch has gone through a merge request and is merged into the **main** branch, the feature branch can be removed from both local and remote repositories.
```bash
git branch -d <branch_name>
```
  
The `-d` command tells git to delete the local branch as long as the branch has been merged. If you've squashed your merge you will likely get a warning saying the branch has not been fully merged. If you receive this warning use `-D` to force the deletion. I would run a `git branch -- merged main` first to ensure your feature branch has been properly merged.

### Delete a remote feature branch
This is only needed if you didn't choose to close the source branch when submitting your merge request. The `--delete origin` command is used to tell the remote repo to remove that specific feature branch name.
```bash
git push --delete origin <feature_branch_name>
```

### Stop tracking the remote branch locally
This is only needed if you choose to close the source branch when submitting your merge request. If you don't do this you will still see the remote branch listed when you check to see what branches are available. The remote prune command will look at the remote branches available and sync them up in your local repo.
```bash
git remote prune origin
```