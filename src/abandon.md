# Deleting commits and bookmarks

````admonish reset title="Reset your progress" collapsible=true
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s abandon
cd ~/jj-tutorial/repo
```
````

Jujutsu makes it easy to manage multiple experiments. Let's create a few:

```sh
jj commit -m "Experiment: Migrate to shiny new framework"
jj git push --change @-
jj new main
jj commit -m "Experiment: Improve scalability using microservices"
jj git push --change @-
jj new main
jj commit -m "Experiment: Apply SOLID design patterns"
jj git push --change @-
jj new main
```

<pre class="aha">
<span class="bold "></span><span class="bold green ">@</span>  <span class="bold "></span><span class="bold highlighted purple ">v</span><span class="bold highlighted dimgray ">qytywws</span><span class="bold "> </span><span class="bold yellow ">alice@local</span><span class="bold "> </span><span class="bold highlighted cyan ">2025-08-31 14:29:56</span><span class="bold "> </span><span class="bold highlighted blue ">9</span><span class="bold highlighted dimgray ">bdb2d1d</span><span class="bold "></span>
│  <span class="bold "></span><span class="bold highlighted green ">(empty)</span><span class="bold "> </span><span class="bold highlighted green ">(no description set)</span><span class="bold "></span>
│ ○  <span class="bold "></span><span class="bold purple ">o</span><span class="highlighted dimgray ">qsqtxwo</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:29:56</span> <span class="purple ">push-oqsqtxwowvuw</span> <span class="bold "></span><span class="bold blue ">2</span><span class="highlighted dimgray ">ffeb883</span>
├─╯  <span class="green ">(empty)</span> Experiment: Apply SOLID design patterns
│ ○  <span class="bold "></span><span class="bold purple ">l</span><span class="highlighted dimgray ">qpnzsmz</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:29:56</span> <span class="purple ">push-lqpnzsmzkxry</span> <span class="bold "></span><span class="bold blue ">f</span><span class="highlighted dimgray ">4cf1d7f</span>
├─╯  <span class="green ">(empty)</span> Experiment: Improve scalability using microservices
│ ○  <span class="bold "></span><span class="bold purple ">r</span><span class="highlighted dimgray ">ppuwxxp</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:29:56</span> <span class="purple ">push-rppuwxxpnkqu</span> <span class="bold "></span><span class="bold blue ">8</span><span class="highlighted dimgray ">c44777f</span>
├─╯  <span class="green ">(empty)</span> Experiment: Migrate to shiny new framework
<span class="bold "></span><span class="bold highlighted cyan ">◆</span>  <span class="bold "></span><span class="bold purple ">s</span><span class="highlighted dimgray ">nnoxnvq</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:29:56</span> <span class="purple ">main</span> <span class="green ">git_head()</span> <span class="bold "></span><span class="bold blue ">3</span><span class="highlighted dimgray ">46c0acd</span>
│  Merge repetition and translation of greeting
~
</pre>

After deciding these experiments are not good ideas, they can be deleted with `jj abandon`. You can abandon commits one by one, or all at once with a revset:

```sh
jj abandon 'description("Experiment")'
```

<pre class="aha">
Abandoned 3 commits:
  <span class="bold "></span><span class="bold purple ">o</span><span class="highlighted dimgray ">qsqtxwo</span> <span class="bold "></span><span class="bold blue ">2</span><span class="highlighted dimgray ">ffeb883</span> <span class="purple ">push-oqsqtxwowvuw</span><span class="highlighted dimgray "> | </span><span class="green ">(empty)</span> Experiment: Apply SOLID design patterns
  <span class="bold "></span><span class="bold purple ">l</span><span class="highlighted dimgray ">qpnzsmz</span> <span class="bold "></span><span class="bold blue ">f</span><span class="highlighted dimgray ">4cf1d7f</span> <span class="purple ">push-lqpnzsmzkxry</span><span class="highlighted dimgray "> | </span><span class="green ">(empty)</span> Experiment: Improve scalability using microservices
  <span class="bold "></span><span class="bold purple ">r</span><span class="highlighted dimgray ">ppuwxxp</span> <span class="bold "></span><span class="bold blue ">8</span><span class="highlighted dimgray ">c44777f</span> <span class="purple ">push-rppuwxxpnkqu</span><span class="highlighted dimgray "> | </span><span class="green ">(empty)</span> Experiment: Migrate to shiny new framework
Deleted bookmarks: push-lqpnzsmzkxry, push-oqsqtxwowvuw, push-rppuwxxpnkqu
<span class="bold "></span><span class="bold cyan ">Hint: </span>Deleted bookmarks can be pushed by name or all at once with `jj git push --deleted`.
</pre>

`jj abandon` also removes local bookmarks pointing to the deleted commits. To sync these deletions with the remote, run:

```sh
jj git push --deleted
```

````admonish note title="Duplicate commits when using Git directly" collapsible=true
While Jujutsu is compatible with Git, directly modifying the repo with tools like `git commit` can create duplicate commits. This happens because Jujutsu doesn't realize the new Git commit is meant to replace its own working-copy commit, so it safely preserves both.

For example, committing with `git` after staging a file in `jj`:

```sh
touch some_file
jj status # record new file into working copy
git commit -am "add some file" # create commit with git, bypassing jj
jj log
```

<pre class="aha">
<span class="bold "></span><span class="bold green ">@</span>  <span class="bold "></span><span class="bold highlighted purple ">n</span><span class="bold highlighted dimgray ">wstlotv</span><span class="bold "> </span><span class="bold yellow ">alice@local</span><span class="bold "> </span><span class="bold highlighted cyan ">2025-08-31 14:44:23</span><span class="bold "> </span><span class="bold highlighted blue ">9</span><span class="bold highlighted dimgray ">28b48f4</span><span class="bold "></span>
│  <span class="bold "></span><span class="bold highlighted green ">(empty)</span><span class="bold "> </span><span class="bold highlighted green ">(no description set)</span><span class="bold "></span>
○  <span class="bold "></span><span class="bold purple ">y</span><span class="highlighted dimgray ">qyzyzzo</span> <span class="yellow ">remo@buenzli.dev</span> <span class="cyan ">2025-08-31 14:44:22</span> <span class="green ">git_head()</span> <span class="bold "></span><span class="bold blue ">30</span><span class="highlighted dimgray ">e0eec4</span>
│  add some file
│ ○  <span class="bold "></span><span class="bold purple ">v</span><span class="highlighted dimgray ">qytywws</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:44:05</span> <span class="bold "></span><span class="bold blue ">7</span><span class="highlighted dimgray ">0588b87</span>
├─╯  <span class="yellow ">(no description set)</span>
<span class="bold "></span><span class="bold highlighted cyan ">◆</span>  <span class="bold "></span><span class="bold purple ">s</span><span class="highlighted dimgray ">nnoxnvq</span> <span class="yellow ">alice@local</span> <span class="cyan ">2025-08-31 14:29:56</span> <span class="purple ">main</span> <span class="bold "></span><span class="bold blue ">34</span><span class="highlighted dimgray ">6c0acd</span>
│  Merge repetition and translation of greeting
~
</pre>

The log shows a branched-off commit that is a duplicate of Jujutsu's previous working copy. The fix is to simply `jj abandon` the redundant commit.

Clean up the duplicate commit:

```sh
jj abandon main+ # abandon direct children of main
```
````

## Immutability

Commands like `jj abandon` and `jj rebase` rewrite history. While powerful, rewriting history can be dangerous on shared branches like `main`, as it can confuse collaborators.

To prevent this, version control systems follow a rule: **Never rewrite history on shared branches.**

Jujutsu enforces this rule by default. Commits on shared branches are considered **immutable**. Attempting to modify an immutable commit will fail:

```sh
jj abandon main
```

<pre class="aha">
<span class="bold "></span><span class="bold red ">Error: </span><span class="bold ">Commit 346c0acd36db is immutable</span>
<span class="bold "></span><span class="bold cyan ">Hint: </span>Could not modify commit: <span class="bold "></span><span class="bold purple ">s</span><span class="highlighted dimgray ">nnoxnvq</span> <span class="bold "></span><span class="bold blue ">34</span><span class="highlighted dimgray ">6c0acd</span> <span class="purple ">main</span><span class="highlighted dimgray "> | </span>Merge repetition and translation of greeting
<span class="bold "></span><span class="bold cyan ">Hint: </span>Immutable commits are used to protect shared history.
<span class="bold "></span><span class="bold cyan ">Hint: </span>For more information, see:
      - https://jj-vcs.github.io/jj/latest/config/#set-of-immutable-commits
      - `jj help -k config`, &quot;Set of immutable commits&quot;
<span class="bold "></span><span class="bold cyan ">Hint: </span>This operation would rewrite 1 immutable commits.
</pre>

Jujutsu marks immutable commits with a diamond (`◆`) in the log, while modifiable, **mutable** commits use a circle (`○`). This protection applies to all history-editing commands.
