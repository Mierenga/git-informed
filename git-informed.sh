#!/bin/bash

# set -e

# 'Darwin'|'Linux'
platform=`uname`

show_notification() {
  [[ -n $NO_NOTIFICATION ]] && return
  if [[ $platform == 'Darwin' ]]; then
    eval "osascript -e 'display notification \"$2\" with title \"$1\"'" 
  elif [[ $platform == 'Linux' ]]; then
    notify-send '$1' '$2'
  fi
}

show_alert_modal() {
  [[ -z $SHOW_ALERT ]] && return
  if [[ $platform == 'Darwin' ]]; then
    eval "osascript -e 'display alert \"New commit on origin/$1\" message \"$2\"'" 
  fi
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -v|--verbose)
      VERBOSE=true
      shift # past argument
      ;;
    -a|--alert)
      SHOW_ALERT=true
      shift # past argument
      ;;
    -N|--no-notification)
      NO_NOTIFICATION=true
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
    ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
# 1st positional arg is branch

prev_remote_ahead=0
while :
do
  git fetch origin > /dev/null
  repo=`basename $(git rev-parse --show-toplevel)`
  [ "$1" ] \
    && branch="$1" \
    || branch=`git branch --show-current`
  compare=`git rev-list --left-right --count origin/${branch}...${branch}`
  compare_array=($compare)
  remote_ahead=${compare_array[0]}
  local_ahead=${compare_array[1]}
  message="${repo} (${branch}) $remote_ahead commits behind origin"
  [[ -n $VERBOSE ]] && echo $message
  if (( $remote_ahead > $prev_remote_ahead )); then
    log_lines=$(( $remote_ahead > 1 ? 2 : 1 ))  
    log=`git log --oneline --pretty=format:"• %<(50,trunc)%s" -n $log_lines origin/${branch}`
    show_notification "${message}" "${log}"
    last_log=`git log --oneline --pretty=format:"• %s" -n 1 origin/master`
    show_alert_modal "${branch}" "${last_log}"
  fi
  prev_remote_ahead=${remote_ahead}
  sleep 5
done
