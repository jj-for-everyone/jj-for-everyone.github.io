# Level 3

This level will provide you with basic problem solving skills like conflict resolution and restoring files from history.
Without this knowledge, it's only a matter of time until you run into trouble.

Here's the cheat sheet for level 3. You may also want to revise the [level 2 cheat sheet](./level_2.md).

````admonish info title="cheat sheet"
Undo and redo the last operation on the repository
```sh
jj undo
jj redo
```
Track a remote bookmark in order to push to it
```sh
jj bookmark track <NAME>@origin
```
Delete a commit (and bookmarks pointing to it)
```sh
jj abandon <CHANGE_ID>
```
Restore the state (of a specific file) (from a specific commit)
```sh
jj restore [--from <CHANGE_ID>] [FILE_TO_RESTORE]
```
````
