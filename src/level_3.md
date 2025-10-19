# Level 3

This level covers essential problem-solving skills like conflict resolution and restoring files from history, bringing you to the level of an average software developer.

Here's the cheat sheet for level 3. You can also review the [level 2 cheat sheet](./level_2.md).

````admonish info title="Cheat Sheet"
Undo or redo the last operation
```sh
jj undo
jj redo
```
Track a remote bookmark to enable pushing
```sh
jj bookmark track <NAME>@origin
```
Abandon a commit (and its bookmarks)
```sh
jj abandon <CHANGE_ID>
```
Restore a file from a specific commit
```sh
jj restore [--from <CHANGE_ID>] [FILE_TO_RESTORE]
```
````
