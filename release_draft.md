I use this file to write down things to put in the next release.
When a new jj version has very small breaking changes, I usually don't cut a release.
This file contains the small changes accumulated over some releases.

- In [jj v0.36](https://github.com/jj-vcs/jj/releases/tag/v0.36.0), the `--destination` flag of the `jj rebase` command was renamed to `--onto`.

- In [jj v0.37](https://github.com/jj-vcs/jj/releases/tag/v0.37.0), the syntax of the `jj bookmark track` command was changed.
  Previously, name and remote were specified as `name@remote`.
  Now you can simply run `jj bookmark track <name>`, without `@origin`.
  The remote can optionally be specified with the `--remote` flag, but you don't need to worry about that if you're only using one remote.
  The tutorial doesn't discuss workflows with multiple remotes yet, so I don't mention the new `--remote` flag.

You can [subscribe to these releases](https://jj-for-everyone.github.io/watch_releases.html) to stay up to date with new tutorial content and updates from Jujutsu that are relevant to readers.
