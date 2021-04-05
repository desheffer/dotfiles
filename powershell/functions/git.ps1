Write-Output "
============================
Git PS1 Functions Loaded
============================
"

function git_log_one_line {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

function clean-git {
  git remote prune origin
  git branch -vv | where {$_ -match '\[origin/.*: gone\]'} | foreach {git branch -D ($_.split(" ",[StringSplitOptions]'RemoveEmptyEntries')[0])}
}

function git_fp {
  git fetch;
  git pull;
}
