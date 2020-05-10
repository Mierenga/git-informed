# git-informed

Get notifications of new commits on a remote branch

## About
- Tells you how many commits behind a remote branch your local version is
- Notification comes through macOS or Ubuntu within 10 seconds of a new commit on the remote branch
- Shows a shortened version of the commit logs for the new commits
- Runs in an infinite sleepy loop

## Usage
```sh
ln -s git-informed.sh ~/repo/of/choice/git-informed.sh
cd ~/repo/of/choice
./git-informed.sh
```
or in the background
```sh
./git-informed.sh &
```
with specific branch
```sh
./git-informed.sh development &
```
## Arguments
|position|name|description|
|-----|----|----------|
|1|`branch`|specify the branch to compare remote and local versions (defaults to HEAD)|

## Options
|short|long|description|
|-----|----|----------|
|`-v`|`--verbose`|print the result of each remote check|
|`-a`|`--alert`|(macOS only) show modal alerts in addition to system notifications|
|`-N`|`--no-notification`|don't show system notifications (useful when `-v` or `-a` is specified)|

## Platforms
Works on
  - macOS (with the `osascript` dependency)
  - Ubuntu (with `notify-send` dependency)
