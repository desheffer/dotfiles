Write-Output "
============================
Docker PS1 Functions Loaded
============================
"

function docker_list {
  docker ps
}

function docker_logs ($container) {
  docker logs $container
}

function docker_start {
  docker up -d
}

function docker_stop {
  docker down
}

