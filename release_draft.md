I use this file to write down things to put in the next release.
When a new jj version has very small breaking changes, I usually don't cut a release.
This file contains the small changes accumulated over some releases.

- In [jj v0.38](https://github.com/jj-vcs/jj/releases/tag/v0.38.0), the command `jj git push --bookmark <NAME>` started tracking a bookmark automatically, if it wasn't tracked already.
  That means you don't have to run `jj bookmark track <NAME>` anymore, before pushing a new bookmark.
  You still need to explicitly track bookmarks that only exist on the remote, for example after cloning a repository.

You can [subscribe to these releases](https://jj-for-everyone.github.io/watch_releases.html) to stay up to date with new tutorial content and updates from Jujutsu that are relevant to readers.
