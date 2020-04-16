prev_remote_ahead=0
while :
do
  git fetch origin
  branch=`git branch --show-current`
  compare=`git rev-list --left-right --count origin/${branch}...${branch}`
  compare_array=($compare)
  remote_ahead=${compare_array[1]}
  echo remote: ${remote_ahead} ahead
  echo local:  ${compare_array[1]} ahead
  message="(${branch}) is ahead by "
  if (( ${remote_ahead} > ${prev_remote_ahead} )); then
    eval "osascript -e 'display notification \"$message\" with title \"⌛️\"'" 
  fi
  prev_remote_ahead=${remote_ahead}
  sleep 10
done
