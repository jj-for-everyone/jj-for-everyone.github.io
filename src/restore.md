# Restoring file contents

````admonish reset title="Reset your progress" collapsible=true
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s restore
cd ~/jj-tutorial/repo
```
````

If you accidentally delete a file and make other changes before realizing it, `jj restore` can help.

For instance, Alice deletes `README.md` and then modifies `hello.py`:

```sh
rm README.md
echo '    print("In soviet Russia, world greets you!")' >> hello.py
jj show
```

<pre class="aha">
Commit ID: <span class="blue ">79cda7b43c273bb0597b7888b2ff9d3afee4a568</span>
Change ID: <span class="purple ">nwstlotvuwrnxrupxnplywqvkloupnxu</span>
Author   : <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:15:13</span>)
Committer: <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:15:13</span>)

<span class="yellow ">    (no description set)</span>

<span class="yellow ">Removed regular file README.md:</span>
<span class="red ">   1</span>     : <span class="red "># jj-tutorial</span>
<span class="red ">   2</span>     : <span class="red "></span>
<span class="red ">   3</span>     : <span class="red ">The file hello.py contains a script that greets the world.</span>
<span class="red ">   4</span>     : <span class="red ">It can be executed with the command 'python hello.py'.</span>
<span class="red ">   5</span>     : <span class="red ">Programming is fun!</span>
<span class="red ">   6</span>     : <span class="red "></span>
<span class="red ">   7</span>     : <span class="red ">## Submission</span>
<span class="red ">   8</span>     : <span class="red "></span>
<span class="red ">   9</span>     : <span class="red ">Run the following command to create the submission tarball:</span>
<span class="red ">  10</span>     : <span class="red "></span>
<span class="red ">  11</span>     : <span class="red ">~~~sh</span>
<span class="red ">  12</span>     : <span class="red ">tar czf submission_alice_bob.tar.gz [FILE...]</span>
<span class="red ">  13</span>     : <span class="red ">~~~</span>
<span class="yellow ">Modified regular file hello.py:</span>
<span class="red ">   1</span> <span class="green ">   1</span>: for _ in range(10):
<span class="red ">   2</span> <span class="green ">   2</span>:     print("Hello, world!")
<span class="red ">   3</span> <span class="green ">   3</span>:     print("Hallo, Welt!")
<span class="red ">   4</span> <span class="green ">   4</span>:     print("Bonjour, le monde!")
     <span class="green ">   5</span>: <span class="green ">    print("In soviet Russia, world greets you!")</span>
</pre>

To restore just `README.md` without losing other changes, run:

```sh
jj restore README.md
```

<pre class="aha">
Commit ID: <span class="blue ">f2922ddd5ad552e1e499b461b8ed900d047cea91</span>
Change ID: <span class="purple ">nwstlotvuwrnxrupxnplywqvkloupnxu</span>
Author   : <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:15:13</span>)
Committer: <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:24:18</span>)

<span class="yellow ">    (no description set)</span>

<span class="yellow ">Modified regular file hello.py:</span>
<span class="red ">   1</span> <span class="green ">   1</span>: for _ in range(10):
<span class="red ">   2</span> <span class="green ">   2</span>:     print("Hello, world!")
<span class="red ">   3</span> <span class="green ">   3</span>:     print("Hallo, Welt!")
<span class="red ">   4</span> <span class="green ">   4</span>:     print("Bonjour, le monde!")
     <span class="green ">   5</span>: <span class="green ">    print("In soviet Russia, world greets you!")</span>
</pre>

`jj restore` can also revert a file to its state in **any commit** using the `--from` flag. For example, to revert `hello.py` to a version with no translations:

```sh
jj restore --from 'description("Fix loop syntax")' hello.py
```

<pre class="aha">
Commit ID: <span class="blue ">c72f36748528f6893316089590374efed90a4214</span>
Change ID: <span class="purple ">nwstlotvuwrnxrupxnplywqvkloupnxu</span>
Author   : <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:15:13</span>)
Committer: <span class="yellow ">Alice</span> &lt;<span class="yellow ">alice@local</span>&gt; (<span class="cyan ">2025-08-31 16:43:32</span>)

<span class="yellow ">    (no description set)</span>

<span class="yellow ">Modified regular file hello.py:</span>
<span class="red ">   1</span> <span class="green ">   1</span>: for _ in range(10):
<span class="red ">   2</span> <span class="green ">   2</span>:     print("Hello, world!")
<span class="red ">   3</span>     : <span class="red ">    print("Hallo, Welt!")</span>
<span class="red ">   4</span>     : <span class="red ">    print("Bonjour, le monde!")</span>
</pre>

After making changes, commit and push them:
```sh
jj commit -m "Remove translations"
jj bookmark move main --to @-
jj git push
```

```admonish success title="You've completed Level 3 ! 🎉"
You now have the skills to handle most version control problems. Here's a summary of what you've learned:

- `jj undo`: Reverts your repository to a previous state, letting you experiment without fear.
- `jj bookmark track`: Lets you work on bookmarks that only exist on the remote.
- Merge Conflicts: Resolve by editing the marked files to combine the changes.
- `jj abandon`: Deletes commits you no longer need.
- `jj restore`: Restores file contents. By default, it reverts to the parent commit, but you can use `--from` to specify any commit.

You're now equipped for most daily tasks. The next level covers rewriting history—a powerful skill for creating a clean and professional commit history.

Feel free to practice these new skills before continuing. To learn more, explore commands with `--help` and consult the [configuration guide](https://jj-vcs.github.io/jj/latest/config/).
```
