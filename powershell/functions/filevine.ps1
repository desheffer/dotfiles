Write-Output "
============================
Filevine PS1 Functions Loaded
============================
"
function helpFilevine {
  Write-Output "Things you were working on last ..."
  # get-content "~/code/personal/abby-todo-list.md" | bat
  bat "${HOME}/code/filevine/abby-todo-list.md"
}

function addTodoFilevine ($todo) {
  Add-Content -Path "~/code/filevine/abby-todo-list.md" -Value "* ${todo}"
  bat "${HOME}/code/filevine/abby-todo-list.md"
}

function set-sshkeys-filevine {
  copy ~/.ssh/id_rsa.filevine ~/.ssh/id_rsa -force
  copy ~/.ssh/id_rsa.pub.filevine ~/.ssh/id_rsa.pub -force
}


function GoGitWork { Set-Location -Path ~/code/filevine }

set-alias _gcw -value GoGitWork
