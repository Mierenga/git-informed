while :
do
  git fetch origin
  branch=`git branch --show-current`
  compare=`git rev-list --left-right --count origin/${branch}...${branch}`
  compare_array=($compare)
  echo ${compare_array[0]}
  echo ${compare_array[1]}
  # filename=.origin.${branch}.diff
  # different=`diff ${filename} ${filename}.new
  message="Current branch is ${branch}."
  eval "osascript -e 'display notification \"$message\" with title \"⌛️\"'" 
  sleep 10
done

# eval "osascript -e 'display alert \"⌛️\" message \"$message\"'" 
