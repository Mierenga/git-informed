#!/bin/bash

prev_remote_ahead=0
while :
do
  git fetch origin > /dev/null
  repo=`basename $(git rev-parse --show-toplevel)`
  branch=`git branch --show-current`
  compare=`git rev-list --left-right --count origin/${branch}...${branch}`
  compare_array=($compare)
  remote_ahead=${compare_array[0]}
  local_ahead=${compare_array[1]}
  message="${repo} (${branch}) $remote_ahead commits behind origin"
  if (( $remote_ahead > $prev_remote_ahead )); then
    log_lines=$(( $remote_ahead > 1 ? 2 : 1 ))  
    log=`git log --oneline --pretty=format:"• %<(50,trunc)%s" -n $log_lines origin/master`
    eval "osascript -e 'display notification \"$log\" with title \"$message\"'" 
    last_log=`git log --oneline --pretty=format:"• %s" -n 1 origin/master`
    eval "osascript -e 'display alert \"New commit on origin/${branch}\" message \"${last_log}\"'" 
  fi
  prev_remote_ahead=${remote_ahead}
  sleep 5
done
