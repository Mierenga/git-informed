# git-informed
Get a notification when the current git branch changes on the remote repository that tells you how many commits behind your local branch is. Notification comes through macOS within 10 seconds of a new commit on the remote branch.

```sh
cd ~/repo/of/choice
./git-informed.sh
```
or in the background
```sh
./git-informed.sh &
```

Works on macOS (with the `osascript` dependency).
