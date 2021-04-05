# Starship Settings
# ================================================================
# If we want to specify default starship.toml file location
# $ENV:STARSHIP_CONFIG = "$HOME\.starship"
# $Env:STARSHIP_CONFIG = "${HOME}./starship/config.toml"
$Env:STARSHIP_CONFIG = "${HOME}/.config/starship.toml"

# Where do we want to store Default Logs
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"

Invoke-Expression (&starship init powershell)


function update_starship {
  scoop update starship
}

function start_starship {
  Invoke-Expression (&starship init powershell)
}
