# Level 1

This level covers the essentials for simple, solo use cases, such as students tracking homework with Git.

The following "cheat sheet" contains the key commands from level 1.
Use it to prime your brain before getting started and remind yourself later when you forget something.

````admonish info title="cheat sheet"
Configure your authorship information
```sh
jj config set --user user.name "Alice"
jj config set --user user.email "alice@local"
```
Initialize a repository
```sh
jj git init <DESTINATION>
```
Clone an existing repository
```sh
jj git clone <PATH_OR_URL> <DESTINATION>
```
Commit the changes you made
```sh
jj commit
```
Push your latest commit to the "main" bookmark
```sh
jj bookmark move main --to @-
jj git push
```
````
