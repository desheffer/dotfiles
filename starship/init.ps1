
  $Env:STARSHIP_CONFIG = "${HOME}/.config/starship.toml"
  $ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
  Invoke-Expression (&starship init powershell)


