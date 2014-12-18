This repository is organized as follows:
trunk/		main development branch for future spec revision
branches/	bugfix branches for released revisions
tags/		tag snapshots taken after each release

Recommended workflow:

  # Create local virtio subdir with git - svn bridge.
  # Important: don't miss the -s flag.
  git svn clone -s https://tools.oasis-open.org/version-control/svn/virtio

  # To update from svn repo
  git svn pull

  # To update from svn repo and rebase your (unpublished) git commits
  git svn rebase

  # To push your changes into repo
  git svn dcommit

Warning! merges using git are not supported; Use rebase/cherry-pick/revert
but keep history linear.

Prior revision v1.0-cs01, stored in svn as revision @435,
all development was done directly in the current directory.

To retrieve repository up to that point only, use
git svn clone 0:435 https://tools.oasis-open.org/version-control/svn/virtio
