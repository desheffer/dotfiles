Write-Output "
============================
Help PS1 Functions Loaded
============================
"

function help_filevine_powershell_piping_commands {
  Write-Output "====================================="
  Write-Output "You can pipe commands together"
  Write-Output "get_environment_variables | Select-String 'google'"
  Write-Output "get_environment_variables | sls 'google'"
  Write-Output "get_environment_variables | findstr 'google'"
  Write-Output "====================================="
}

