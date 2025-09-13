# Initializing a repository

````admonish reset title="Reset your progress" collapsible=true
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s initialize
```
````

A "repository" is a directory (folder) where Jujutsu keeps track of all files, including the ones in subdirectories.
A repository usually corresponds to a project, so the version history of unrelated projects are not tied to each other.
In this tutorial, we'll use `~/jj-tutorial/repo` as the location of our repository.
Don't put it somewhere else, otherwise some commands I tell you to run won't work later.
(If you don't like the clutter in your home directory, you can always delete it and use the [reset script](./how_to_read.md#reset-your-progress) when you continue with the tutorial.)

The command to initialize a new repository is `jj git init <DESTINATION>`.
We use `cd` to change our working directory to the new repository.
Copy-paste these commands into your terminal:

```sh
mkdir ~/jj-tutorial
jj git init ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
```

Let's examine our first `jj` command.
`git` is the subcommand responsible for various Git-specific compatibility features.
One of them is the `init` command, which initializes a new repository that's compatible with Git.

What does "initializing a repository" mean?
Essentially, Jujutsu creates two directories `.git` and `.jj`.
These contain all information about the version history.
Why two directories?
The `.git` directory contains all the important stuff, stored in a way that is compatible with Git.
The `.jj` directory contains additional metadata which enable some of Jujutsu's advanced features.

```admonish warning
You should never manipulate files in these directories directly!
Their content is a well-structured database.
If you corrupt the database format, the repository might become broken.
We'll talk about a second layer of backup in the [chapter about remotes](./remote.md).
```

Files and directories starting with a dot are hidden by default, but you can verify they were created with `ls -a`:

```console
$ ls -a
.git  .jj
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
jj metaedit --update-author
```
