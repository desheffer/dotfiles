# vim: ft=sh

function helpGeneralInfo() {
  echo "g - quick file grep command"
  echo "f - quick find command"
  echo "d - quick dev directory change"
  echo "helpTailCommands"
  echo "helpWeedmaps"
}

function helpPowerline() {
  echo "iTerm2 for Mac"
  echo "pip install --user git+git://github.com/Lokaltog/powerline --verbose"
  echo "git clone git@github.com:powerline/fonts.git"
  echo "brew install python"
  echo "edit .vimrc"
  echo "Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}"
  echo "set guifont=Inconsolata\ for\ Powerline:h15"
  echo "let g:Powerline_symbols = 'fancy'"
  echo "set encoding=utf-8"
  echo "set t_Co=256"
  echo "set fillchars+=stl:\ ,stlnc:\  "
  echo "  set term=xterm-256color"
  echo "set termencoding=utf-8"

}

function helpTailCommands() {
  echo "tailColorSaltRun \$1"
  echo "tailColorMysqlLogOut \$1"
  echo "tailColorCatalinaOut \$1"
  echo "tailColorApacheErrorLog \$1"
  echo "smartHdToolScanStatus \$1"
  echo "tailColorizedSyslog "
  echo "tailColorSaltRun \$1"

}

function helpWeedmaps() {
  echo "helpWeedmapsReleaseNotesGenProcess ionic|core"
  echo "helpWeedmapsCoreReleaseProcess"
  echo "helpWeedmapsRinseAndRepeat"
  echo "helpUpdateWeedmapsVersions"
  echo "====="
  echo "Daily things to do"
  echo "-----"
  echo "8AM"
  echo "helpWeedmapsRinseAndRepeat"
  echo "-----"
  echo "12PM"
  echo "helpWeedmapsRinseAndRepeat"
  echo "-----"
  echo "4PM"
  echo "helpWeedmapsRinseAndRepeat"
  echo "====="
  echo "If shit blows up ... Call/Text Jared - 7207256801"
}

function helpUpdateWeedmapsVersions() {
  echo "this is something that should be build out ..."
  echo "for now, update this file"
  echo "vim ~/code/weedmaps_code/weedmaps-tools/versions.sh"
}

function helpWeedmapsReleaseNotifications() {
  [ -f "$HOME/code/weedmaps_code/weedmaps-tools/versions.sh" ] && . "$HOME/code/weedmaps_code/weedmaps-tools/versions.sh"
  echo "In ops flow:"
  echo "===="
  if [ "ionic" = "$1" ]; then 
    echo "@team Ionic ${Ionic_CurrentProductionReleaseNumber} is going to production shortly."
    echo "-----"
    echo "in Release Chat Room Flow:"
    echo "===="
    echo "@Team for Ionic ${Ionic_CurrentProductionReleaseNumber} release to Prod."
    echo "We have:"
    echo "OPS Notified"
    echo "We need:"
    echo "QA sign off"
    echo "Dev sign off @Thomas, @CharlieK"
    echo "Product sign off @Thomas, @CharlieK"
  elif [ "core" = "$1" ]; then
    echo "@Team Core ${Core_CurrentProductionReleaseNumber} going to Production soon"
    echo "-----"
    echo "in Release Chat Room Flow:"
    echo "===="
    echo "@Team for Core ${Core_CurrentProductionReleaseNumber} to production."
    echo "We have:"
    echo "OPS notified"
    echo "We need:"
    echo "QA sign off"
    echo "Dev sign off"
    echo "Product sign off"
  else
    echo "You were supposed to do something"
  fi
}

function gitReleaseNotesStatus() {
  #path='GhostGroup/weedmaps_ionic' 
  # $2 == github path
  if [ "$2" != "" ]
  then
    echo "git releasenotes $1.. -a -p $2"
    releasenotes $1.. -a -p $2 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.weedmaps-git.releasenotes
  else
    echo "git releasenotes $1.. -a"
    releasenotes $1.. -a | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.weedmaps-git.releasenotes
  fi
}

#function gitReleaseNotesStatus() {
#  releasenotes $1.. -a | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.releasenotes
#}

function helpWeedmapsRinseAndRepeat() {
  echo "Check boards (Shatter, Flower Rangers, Tokemon, MMJMenu)"
  echo "git checkout (staging|develop|acceptance); git fetch; git pull"
  echo "circle token 2afc0f73c64d2b6a57d5436bbecbff8e74d88f15"
  echo "circle --watch"
  echo "helpWeedmapsReleaseNotesGenProcess"
  echo "Move things to Acceptance"
  echo "Generate Report Cards"
}

function helpCircleCliHelp() {
  echo "https://github.com/circle-cli/circle-cli"
  echo "===="
  echo "circle ci token"
  echo "----"
  echo "circle token 2afc0f73c64d2b6a57d5436bbecbff8e74d88f15"
  echo "===="
  echo "watch current branch"
  echo "----"
  echo "circle --watch "
  echo "===="
  echo "open current branch - current circle ci build"
  echo "----"
  echo "circle open"
}

function helpWeedmapsReleaseNotesGenProcess() {

  [ -f "$HOME/code/weedmaps_code/weedmaps-tools/versions.sh" ] && . "$HOME/code/weedmaps_code/weedmaps-tools/versions.sh"
    echo "Lengend"
    echo "-----"
    echo "Release Notes File # RNF"
    echo "Color Release Notes # CRN"
    echo "-----"
    if [ "ionic" = "$1" ]; then 
      echo "gitReleaseNotesStatus ${Ionic_PreviousProductionReleaseNumber} # CRN"
      echo "-----"
      echo "Generate Release Notes File"
      echo "-----"
      echo "releasenotes ${Ionic_PreviousProductionReleaseNumber}.. -a  > ~/Documents/releases/ionic/ionic-${Ionic_CurrentProductionReleaseNumber}.txt"
      echo "-----"
      echo "Type output"
      echo "-----"
      echo "releasenotes ${Ionic_PreviousProductionReleaseNumber}..  "
      echo "-----"
      echo "Release notes should be generated "
    elif [ "core" = "$1" ]; then
      echo "gitReleaseNotesStatus origin/release/${Core_PreviousProductionReleaseNumber} GhostGroup/weedmaps"
      echo "-----"
      echo "Generate Release Notes File"
      echo "-----"
      echo "releasenotes origin/release/${Core_PreviousProductionReleaseNumber}.. -a -p GhostGroup/weedmaps > ~/Documents/releases/core/core-${Core_CurrentProductionReleaseNumber}.txt"
      echo "-----"
      echo "Type output"
      echo "-----"
      echo "releasenotes origin/release/${Core_PreviousProductionReleaseNumber}.. -p GhostGroup/weedmaps "
      echo "-----"
      echo "Release notes should be generated "
    else
      echo "You were supposed to do something"
    fi
}

function helpWeedmapsCoreReleaseProcess() {
  echo "git cherry-pick -m 1 -e [SHA-to-merge-in]"
  echo "git cherry-pick -m 1 -e ${1}"
}

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function color_set_fg {
  code=16
  [ $# -ge 3 ] && code=$((16 + $1 * 6 * 6 + $2 * 6 + $3))
  echo -en "\033[1;38;5;${code}m"
}

function color_set_bg {
  code=16
  [ $# -ge 3 ] && code=$((16 + $1 * 6 * 6 + $2 * 6 + $3))
  echo -en "\033[48;5;${code}m"
  color_current_bg="$1 $2 $3"
}

function color_reset {
  echo -en "\033[0m"
}

function color_start {
  color_reset
  echo
  color_set_fg $1 $2 $3
  color_set_bg $4 $5 $6
}

function color_change {
  color_reset
  color_set_fg $color_current_bg
  [ $# -ge 3 ] && color_set_bg $4 $5 $6
  echo -en "$icon_separator"
  [ $# -ge 3 ] && color_set_fg $1 $2 $3
}

function color_end {
  color_change
  color_reset
}

function color_block {
  echo -en "  $@  "
}

function generate_prompt {
  # Window title.
  echo -en "\033]0;\u@\h:\w\a"

  # Basic prompt.
  color_start 0 0 0 5 4 0
  color_block "\u@\h"
  color_change 5 5 5 1 1 1
  color_block "\w"

  # Git info.
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
      ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="$icon_commit $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
      ref_sha=$(git show-ref --head -s --abbrev | head -n1 2>/dev/null)
      color_change 0 3 5
      color_block "(${ref_sha})"
      color_change 0 5 1
      color_block "${ref/refs\/heads\//$icon_branch }"
      color_change 0 3 5
  fi

  # Timestamp
  printf %s "$(date)"
  color_change 0 3 5
  color_end
  echo "\n\$ "
}

function set_prompt {
  PS1="$(generate_prompt)"
}

# I don't like one letter functions that I should be using ...
# That's why there are aliases for everything!!!
#function 

# colorized mysql error log tail command
function tailColorMysqlLogOut() {
  tail -fn 100 $1 | ~/bin/grcat ~/code/dotfiles/grc_conf_files/conf.log
}

# colorized apache error log tail command
function tailColorCatalinaOut() {
  sudo tail -fn 100 $1 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.catalina.out.log
}

# colorized apache error log tail command
function tailColorApacheErrorLog() {
  sudo tail -fn 100 $1 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.php.error.log
}

# smart hd tool scan
function smartHdToolScanStatus() {
  sudo smartctl -c $1 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.smartctl
}

# smart hd tool capability
function smartHdToolCapability() {
  sudo smartctl -i $1 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.smartctl.capability
}

# smart hd tool capability
function tailColorizedSyslog() {
  sudo tail -f /var/log/syslog | ~/code/dotfiles/bin/grcat ~/code/dotfiles/bin/grc/conf.log
}

# smart hd tool scan
function tailColorSaltRun() {
  tail -f $1 | ~/code/dotfiles/bin/grcat ~/code/dotfiles/grc_conf_files/conf.salt-run
}

# Quick file grep command.
function g() {
    OPTS="-nrs"
    SEARCH="$@"
    if [[ $SEARCH =~ ^[^A-Z]*$ ]]; then
        OPTS="${OPTS}i"
    fi
    grep "$OPTS" --exclude-dir=.git "$SEARCH" . | less
}

# Random one-off
# WIth comments, because I suck at reading code - Sorry, I don't have cool bash scripting skills ... yet
# function getSls { [[ -d dir ]] || mkdir $1; cd $1; wget https://raw.githubusercontent.com/roblayton/master-minion-salt-vagrant/master/salt/roots/$1/$2; cd ..; }
function getSls {
  # if directory not there, create it
  [[ -d dir ]] || mkdir $1;

  # Change into $1 (first parameter passed in)
  cd $1;

  # copy the code down to my directory
  # - Well why not copy it down with git? because I can copy it down, but apparently this is what my brain thought was easier at the time ...
  wget https://raw.githubusercontent.com/roblayton/master-minion-salt-vagrant/master/salt/roots/$1/$2;
  # Change back into previous directory, so continue on with the next command
  cd ..;
}

# Quick find command.
function f() {
    SEARCH="$@"
    find -iname "*$SEARCH*" | less
}

# Quick development directory change command.
function d() {
    if [ -n "$1" ]; then
        cd "$HOME/$(whoami).$1"
    else
        (cd && ls -d "$(whoami)."*) | sed "s/$(whoami)\.//"
    fi
}

