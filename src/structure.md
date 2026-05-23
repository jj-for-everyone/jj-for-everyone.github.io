# How to read this tutorial

Here's some information about how the tutorial is structured.
Read carefully for the best experience.

## Level up

The tutorial is split into **levels**, which define the hierarchy in the sidebar.
When you complete a level, you should probably put this tutorial away for a while and practice what you've learned.
Once you're comfortable with those skills, come back for the next level.

There is one exception to this:
If you're here because you need to collaborate with other people, you should complete the levels 1 and 2 right away.

Here's an overview of the available levels:

| Level | Description |
| :-: | --- |
| **1** | The bare minimum to get started. Enough for solo-projects like submitting homework as a student. |
| **2** | The bare minimum for collaboration, e.g. students doing a group project or software engineers working in a team. |
| **3** | Important problem-solving skills: undoing mistakes, resolving merge conflicts, restoring files from history. |

More levels are planned.
The following chapter explains how to get notified about new content.

## Reset your progress at any time

Throughout the tutorial, you will build an example repository.
Later chapters depend on the state of previous ones.
But don't be afraid to mess up or lose your progress by experimenting!

There is a script which automates the task of resetting your progress to the **start of any chapter**.

To identify the chapter you want to continue with, the script expects a keyword as an argument.
Each chapter includes its precise reset command at the top, so you can easily copy-paste it.
For example, the text box below contains instructions to reset your progress to the very beginning of the tutorial:

````admonish reset title="Reset your progress"
To reset your progress to the start of this chapter, run the following command:

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s install
```
````

This method downloads the script from the internet and executes it right away.
If you have security concerns about that, you can instead:

1. [Download the script](./reset.sh).
1. Read the source to make sure it's safe.
   It's not doing anything complicated, it just executes the commands of the tutorial in sequence.
1. Run the downloaded script (with the chapter-keyword as the first argument).

For convenience, the source of the script is also included in the expandable text box below.

`````admonish note title="Source of reset script" collapsible=true
````sh
{{ #include reset.sh }}
````
`````
