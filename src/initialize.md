# Initializing a repository

A "repository" is a directory (folder) where Jujutsu keeps track of all files, including the ones in subdirectories.
A repository usually corresponds to a project, so the version history of unrelated projects are not tied to each other.
To create a repository, make a new folder on your filesystem.
For this tutorial, you should use `~/jj-tutorial/repo`.
Otherwise, some commands I tell you to run later won't work.
(If you don't like the clutter in your home directory, you can always delete it and use the [restore script](./introduction#restoring-your-progress) when you continue with the tutorial.)
In that directory, run `jj git init --colocate` to initialize a new repository.

As commands to copy-paste:

```sh
mkdir -p ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj git init --colocate
```

Let's examine our first `jj` command.
`git` is the subcommand responsible for various Git-specific compatibility features.
One of them is the `init` command, which initializes a new repository that's compatible with Git.
I highly recommend always using the `--colocate` flag, it improves compatibility with Git-tooling.
If you're interested in the details, there's an info box a little further below.

What does "initializing a repository" mean?
Essentially, Jujutsu creates two directories `.git` and `.jj`.
These contain all information about the version history.
Why two directories?
The `.git` directory contains all the important stuff, stored in a way that is compatible with Git.
The `.jj` directory contains additional metadata which enable some of Jujutsu's advanced features.

```admonish warning
You should never manipulate files in these directories directly!
Their content is a well-structured database.
If you corrupt the database format, you might completely brick the repository.
We'll talk about a second layer of backup in the [chapter about remotes](./remotes.md).
```

Files and directories starting with a dot are hidden by default, but you can verify they were created with `ls -a`:

```console
$ ls -a
.git  .jj
```

```admonish info title="Deep-dive about the --colocate flag" collapsible=true
We just discussed the purpose of the two directories `.git` and `.jj`.
The `--colocate` flag makes it so they are placed "next to each other".

If we were using Git instead of Jujutsu, the command we'd use to initialize a repository would be `git init`.
This creates only a single `.git` directory.
That makes sense:
Git uses one database, just for itself, in one directory.

Well, Jujutsu works the same way by default.
If you just run `jj git init`, that will only create a single `.jj` directory.
Everything is stored in there: both the Git-compatible database as well as additional, Jujutsu-specific data.
As far as Jujutsu is concerned, that makes sense and works without any issues.

The problem arises when third-party tools offer you features related to integration with version control.
Git has such a huge chunk of the market share that most tools only integrate with Git and don't bother supporting any other VCS.
The way they do that is by reading the `.git` directory, which has a known, stable format.
If there is only a `.jj` directory, these tools won't know that you're using version control in the first place.

That's where the `--colocate` flag comes into play.
As the name implies, it tells Jujutsu to place the Git-compatible database and the Jujutsu-specific one "next to each other".
That way, third-party tools don't even notice you're using Jujutsu and their functionality just works, as if you were using Git directly.

Here's a small word of caution about using third-party tools with Jujutsu.
Most of them only read from the `.git` database, which is no problem at all.
However, some of them will also modify the database.
For example, IDEs often let you perform version control tasks right in their GUI.
This is not _dangerous_ per se, you won't loose any progress by doing that.
But it can confuse Jujutsu a little bit and lead to weirdness.
Most likely, you'll just end up with duplicate commits.
That's slighly annoying, but not destructive.
You can get rid of duplicate commits with the `jj abandon` command, which is covered in a [later chapter](./abandon.md).
```

In the previous chapter, you configured Jujutsu with your name and email address.
This configuration applies to all of your repositories by default.
However, for our example repository, we'll actually pretend to be "Alice", who is later joined by "Bob" to simulate collaboration.
The below commands perform the author configuration only for this specific repo.
There's no need to memorize these commands, they are normally not needed.

```sh
# applies configuration to a single repository only
#             vvvvvv
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"

# reset already recorded global authorship information:
jj describe --reset-author --no-edit
```
