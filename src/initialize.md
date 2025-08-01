# Initializing a repository

A "repository" is a directory (folder) where Jujutsu keeps track of all files, including the ones in subdirectories.
A repository usually corresponds to a project, so the version history of unrelated projects are not tied to each other.
To create a repository, make a new folder on your filesystem.
I will assume you use `~/jj-tutorial`, but you can use any location you like.
`cd` into that directory and run `jj git init --colocate`.

In summary:

```sh
mkdir ~/jj-tutorial
cd ~/jj-tutorial
jj git init --colocate
```

Let's examine our first `jj` command.
`git` is the subcommand responsible for various Git-specific compatibility features.
One of them is the `init` command, which initializes a new repository that's compatible with Git.
I highly recommend always using the `--colocate` flag.
It allows third-party tools with Git-integration to work seamlessly.

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
We'll talk about a second layer of backup in [chapter 7](./remotes.md).
```

Files and directories staring with a dot are hidden by default, but you can verify they were created with `ls -a`:

```
$ ls -a
.git  .jj
```

In the last chapter, you configured Jujutsu with your name and email address.
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
