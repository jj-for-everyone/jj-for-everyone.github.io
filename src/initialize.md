# Initializing a repository

````admonish reset title="Reset your progress" collapsible=true
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s initialize
```
````

A repository is a directory where Jujutsu tracks all files and their history. For this tutorial, we'll use `~/jj-tutorial/repo`. Don't put it somewhere else, otherwise some commands I tell you to run won't work later.

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

This creates two hidden directories, `.git` and `.jj`, which store the repository's history and metadata. You should not edit these directories directly. You can see them with `ls -a`:

```console
$ ls -a
.git  .jj
```

For this tutorial, we'll configure the repository with a specific author, "Alice". This overrides your global configuration for this repository only.

```sh
# applies configuration to a single repository only
#             vvvvvv
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"

# reset already recorded global authorship information:
jj metaedit --update-author
```
