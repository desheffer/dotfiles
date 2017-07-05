# vim: ft=sh

function helpGeneralInfo() {
  echo "g - quick file grep command"
  echo "f - quick find command"
  echo "d - quick dev directory change"
  echo "helpTailCommands"
  echo "helpWeedmaps"
  echo "helpGitCommands"
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

