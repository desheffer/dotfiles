
task hello_world {
  Write-Output "Hello World"
}

task replace_powershell_profile_with_symlink {
  Write-Output "Replace Powershell with Symlink"
  # move-item ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1.old
  New-Item -Path ~/Documents/WindowsPowerShell/Microsoft.PowerShell_Profile.ps1 -ItemType SymbolicLink -Target ${PWD}/powershell/Microsoft.PowerShell_profile.ps1
}

#task link_windows_zshrc {
#  # ln_s_directory -_link $
#  move-item ~/.zshrc ~/.zshrc.old
#New-Item -Path ~/.zshrc -ItemType SymbolicLink -Target ${PWD}/zsh/zshrc
#}

task todo {
  Write-Output "
* [ ] Type up Readme.md
* [ ] What commands do we need to run with scoop?
* [ ] Vim configuration/installation
* [ ] 
"
}
