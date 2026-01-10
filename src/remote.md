# Sending commits to a remote

````admonish reset title="Reset your progress" collapsible=true
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s remote
cd ~/jj-tutorial/repo
```
````

We now have a commit which we don't want to lose.
The way we're using Jujutsu right now, we don't have a backup at all.
What would happen if we delete the `~/jj-tutorial/repo` directory on disk?
The `.git` and `.jj` subdirectories would be deleted as well.
Since our entire version control database is stored in there, we wouldn't be able to recover any of our work!

We can fix that by duplicating our commit at another location, a so-called **remote**.
Besides providing a backup, sending commits to a remote also allows you to share your work more easily for collaboration.

The most popular form of a remote is to host a repository with an online service like [GitHub](https://github.com/).
That requires an account and a little setup though, so we'll use a simpler approach in this tutorial.
Your remote will be stored in a new directory on your computer, at a different location than your primary repository.
That style of remote is bad as a backup and bad for collaboration, but it's perfect for learning how remotes work.
There are a few practical tips about using GitHub in a [later chapter](github.md).

## Initializing the remote

The following command will initialize a new repository for use as a remote:

```sh
git init --bare -b main ~/jj-tutorial/remote
```

Since you will likely use a different style of remote for real projects, you don't need to understand the details here.
If you're curious anyway, expand the text box below.

````admonish note title="The difference between remote (bare) and regular repositories" collapsible=true
`git init --bare` is very similar to `jj git init`, which we used to create our main repository.
However, instead of a "regular" Jujutsu repository, it creates a "bare" Git repository.

What's the difference?

Think of a regular Jujutsu repository as consisting of two parts: (1) Jujutsu's internal database stored in the `.git` and `.jj` directories and (2) all the actual files of your project, which you can modify - your **working copy**.
The term "copy" is key here, because all the files are also stored in the internal database.
The only reason a copy of the files exists outside the database is so you can read and modify them - "work" with them.
So, "working copy" is a fitting name indeed.

A bare repository is a Git repository **without a working copy** and without any Jujutsu-specific metadata.
Since we will only use the bare repository for sending and receiving commits, we don't need a working copy or the `.jj` directory.

If you inspect the content of the new bare repository, it will look very similar in structure to the content of the `.git` directory in our main repository:
```
ls -lah ~/jj-tutorial/repo/.git
ls -lah ~/jj-tutorial/remote
```

The `-b main` part ensures the default branch is called "main".
If unspecified, the default branch can be different based on installation, configuration, etc.
This would cause problems later.
````

## Connecting to a remote

A repository is connected to a remote by storing its location under a specific name.
Remotes can be called anything, but when there is only one, the convention is to call it **origin**:

```sh
jj git remote add origin ~/jj-tutorial/remote
```

Here we connect to the remote by specifying its path on our filesystem.
When using a repository hosted on GitHub or similar services, the path is replaced with a URL.
More on that later.
If everything went well, `origin` should now appear in the list of remotes:

```sh
jj git remote list
```

## Adding a bookmark

There is another speed bump before we can send our work to the remote.
Remote repositories can receive a lot of commits, not all of which end up being needed in the long run.
Therefore, it's desirable that commits which aren't needed anymore can be deleted automatically.
How does the remote know which commits to delete and which to keep?
With bookmarks!

A bookmark is a simple named label that's attached to a commit.
Every commit with such a bookmark label is considered important and won't be deleted automatically.
Because of that mechanism, a bookmark is _required_ for sending commits to a remote.

Let's create a bookmark called **main** and point it to our completed commit.
The name "main" is a convention that represents the primary state of the project.
In legacy projects, the name "master" is also still in widespread use.

```sh
jj bookmark create main --revision mkmqlnox # <- substitute your change ID here
```

The command `jj bookmark create` expects a name (`main`) and a commit to which the bookmark should point.
We identify the commit by its change ID (`--revision mkmqlnox`).
For our purposes, the word "revision" is a synonym for "commit".
The flag `--revision` can also be abbreviated as `-r`.
Let's check the result with `jj log`:

<!-- generated by aha script -->
<pre class="aha">
<span class="bold "></span><span class="bold green ">@</span>  <span class="bold "></span><span class="bold highlighted purple ">p</span><span class="bold highlighted dimgray ">wpuwyto</span><span class="bold "> </span><span class="bold yellow ">alice@local</span><span class="bold "> </span><span class="bold highlighted cyan ">2025-07-22 20:22:36</span><span class="bold "> </span><span class="bold highlighted blue ">3</span><span class="bold highlighted dimgray ">5de496a</span><span class="bold "></span>
│  <span class="bold "></span><span class="bold highlighted green ">(empty)</span><span class="bold "> </span><span class="bold highlighted green ">(no description set)</span><span class="bold "></span>
○  <span class="bold "></span><span class="bold purple ">m</span><span class="highlighted dimgray ">kmqlnox</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-07-22 20:20:34</span> <span class="purple ">main</span> <span class="green ">git_head()</span> <span class="bold "></span><span class="bold blue ">5</span><span class="highlighted dimgray ">b79353a</span>
│  Add readme with project title
<span class="bold "></span><span class="bold highlighted cyan ">◆</span>  <span class="bold "></span><span class="bold purple ">z</span><span class="highlighted dimgray ">zzzzzzz</span> <span class="green ">root()</span> <span class="bold "></span><span class="bold blue ">0</span><span class="highlighted dimgray ">0000000</span>
</pre>

Great!
We can see that the bookmark `main` is correctly pointing to our recently completed commit.

## Tracking a bookmark

We are now learning about bookmark, because we want to send commits to a remote.
However, bookmarks can also be used for local-only purposes.
For example, you can more easily refer to a commit by making a bookmark with a memorable name point to it.
So, you may not want to send _all_ of your bookmarks to a remote.

Jujutsu identifies bookmarks which are supposed to be sent to a remote with a "tracking" state.
In order to send the `main` bookmark to our remote, we need to "track it" first:

```sh
jj bookmark track main
```

The `@origin` part means that `main` should be sent to the remote called `origin`.
This is relevant in case you have multiple remotes and only want to send a bookmark to a subset of them, but that's an advanced situation you don't have to worry about.

## Pushing the bookmark

Now that we're connected and have a bookmark, let's finally send our commit to the remote.
The technical term for sending commits is "pushing" them.
You will often hear phrases like "pushing to the remote" or "pushing to GitHub".
The command for pushing a specific bookmark is:

```sh
jj git push --bookmark main
```
