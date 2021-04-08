Write-Output "
============================
Docker PS1 Functions Loaded
============================
"
function reload_functions_docker {
  . ${HOME}/code/dotfiles/powershell/functions/docker.ps1
}

function help_docker_list {
  docker ps
}

function help_docker_logs ($container) {
  docker logs $container
}

function help_docker_start {
  docker up -d
}

function help_docker_stop {
  docker down
}

