Write-Output "
============================
Abby PS1 Functions Loaded
============================
"
function GoGitPersonal { Set-Location -Path ~/code/personal }
set-alias _gcp -value GoGitPersonal
function helpAbby {
  Write-Output "Things you were working on last ..."
  # get-content "~/code/personal/abby-todo-list.md" | bat
  bat "${HOME}/code/personal/abby-todo-list.md"
}

function addTodoAbby ($todo) {
  Add-Content -Path "~/code/personal/abby-todo-list.md" -Value "* ${todo}"
  bat "${HOME}/code/personal/abby-todo-list.md"
}

function set-sshkeys-abby {
  copy ~/.ssh/id_rsa.abby ~/.ssh/id_rsa -force
  copy ~/.ssh/id_rsa.pub.abby ~/.ssh/id_rsa.pub -force
}


