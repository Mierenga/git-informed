while :
do
  git fetch origin
  branch=`git branch --show-current`
  message="Current branch is ${branch}."
  eval "osascript -e 'display notification \"$message\" with title \"⌛️\"'" 
  sleep 10
done

# eval "osascript -e 'display alert \"⌛️\" message \"$message\"'" 
