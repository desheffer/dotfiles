Write-Output "
============================
Abby PS1 Functions Loaded
============================
"
function GoGitPersonal {
  Set-Location -Path ~/code/personal
}
function GoGitPersonalDotfiles {
  Set-Location -Path ~/code/dotfiles
}
set-alias _gcp -value GoGitPersonal

function helpAbby {
  Write-Output "Things you were working on last ..."
  # get-content "~/code/personal/abby-todo-list.md" | bat
  bat "${HOME}/code/personal/abby-todo-list.md"
}

function helpAbbyTodo {
  Set-Location -Path ~/code/personal/general_todo
}

function addTodoAbby ($todo) {
  Add-Content -Path "~/code/personal/abby-todo-list.md" -Value "* ${todo}"
  bat "${HOME}/code/personal/abby-todo-list.md"
}

function set-sshkeys-abby {
  copy ~/.ssh/id_rsa.abby ~/.ssh/id_rsa -force
  copy ~/.ssh/id_rsa.pub.abby ~/.ssh/id_rsa.pub -force
}


function todo_local_items {
  Invoke-Build todo
}

function reload_functions_abby {
  . ${HOME}/code/dotfiles/powershell/functions/abby.ps1
  Write-Output "
  . `${HOME}/code/dotfiles/powershell/functions/abby.ps1
  "
}

function help_abby_tasks_dotFiles {
  Set-Location -Path ~/code/dotfiles/
}
function help_abby_tasks_dotFilesPowershell {
  Set-Location -Path ~/code/dotfiles/powershell
}

function help_abby_tasks_loadTesting {
  Set-Location -Path ~/code/personal/load_testing
}

set-alias _gcp_tasks_loadTesting -value help_abby_GoLoadTesting10
