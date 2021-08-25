Write-Output "
============================
Docker PS1 Functions Loaded
============================
"
function reload_functions_docker {
  . ${HOME}/code/dotfiles/powershell/functions/docker.ps1
  Write-Output "
  . `${HOME}/code/dotfiles/powershell/functions/docker.ps1
  "
}

function help_docker_list {
  docker ps
}

function help_docker_setup_docker_registry {
  docker run -d `
    -p 5000:5000 `
    --restart=always `
    --name=docker_registry `
    registry:2.7
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

function help_docker_images {
  docker images
}

function help_docker_remove_image ($image) {
  docker rmi $image
}

function help_docker_pull_image ($image) {
  $DOCKER_REPO_HOSTNAME = "localhost:5000"
  docker pull $DOCKER_REPO_HOSTNAME/$image
}
function help_docker_logs_registry () {
  docker logs -f docker_registry
}

function help_docker_install_lazydocker {
  Write-Output "https://github.com/jesseduffield/lazydocker"
  scoop install lazydocker
}
