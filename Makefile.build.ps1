
task hello_world {
  Write-Output "Hello World"
}

task make_link_vimrc {

  # New-Item -Path $_link -ItemType SymbolicLink -Target $_source
  $link = "${env:USERPROFILE}\_vimrc"
  $source = "${PWD}\windows_shell\vimrc"
  New-Item -Path $link -ItemType SymbolicLink -Target $source
}

task replace_powershell_profile_with_symlink {
  Write-Output "Replace Powershell with Symlink"
  # New-Item -Path $_link -ItemType SymbolicLink -Target $_source
  $link = "${env:USERPROFILE}\Documents\WindowsPowerShell\Microsoft.PowerShell_Profile.ps1"
  $source = "${PWD}\powershell\Microsoft.PowerShell_profile.ps1"
  New-Item -Path $link -ItemType SymbolicLink -Target $source
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
