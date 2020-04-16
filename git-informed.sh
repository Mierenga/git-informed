while :
do
  git fetch origin
  branch=`git branch --show-current`
  compare=`git rev-list --left-right --count origin/${branch}...${branch}`
  compare_array=($compare)
  echo remote: ${compare_array[0]} ahead
  echo local:  ${compare_array[1]} ahead
  message="(${branch})"
  if (( ${compare_array[1]} > 0 )); then
    eval "osascript -e 'display notification \"$message\" with title \"⌛️\"'" 
  fi
  sleep 10
done
