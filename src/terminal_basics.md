# Terminal basics

This chapter covers the terminal basics required for the tutorial. If you're already comfortable with the command line, feel free to skip it.

<!--toc:start-->
- [What is the terminal?](#what-is-the-terminal)
- [The prompt](#the-prompt)
- [Entering commands](#entering-commands)
- [The current working directory](#the-current-working-directory)
- [Copy-pasting commands](#copy-pasting-commands)
- [Redirection](#redirection)
- [Pagers](#pagers)
- [Variables and the environment](#variables-and-the-environment)
- [The `PATH` variable](#the-path-variable)
- [Startup scripts](#startup-scripts)
<!--toc:end-->

## What is the terminal?

The terminal is a text-based application for sending commands to your operating system. It's also known as a "console" or "shell".

## The prompt

The **prompt** is the text that appears when the terminal is ready for your next command. It often ends with a `$` or `%` sign.

```
[username@hostname ~]$
```

## Entering commands

To run a command, type it and press <kbd>Enter</kbd>. The first word is the program's name, and subsequent words are its **arguments**.

For example, the `echo` program prints its arguments:

```console
$ echo Hello, terminal!
Hello, terminal!
```

The first word is the program to run.
The terminal will find a program called `echo` on your computer and run it with the two **arguments** `Hello,` and `terminal!`.
The program is free to interpret these arguments however it wants.
The program called `echo` happens to simply print its arguments back to the terminal:

## The current working directory

The **current working directory** (CWD) is your current location in the filesystem. Many commands behave differently depending on your CWD.

Use `cd` ("change directory") to move to a different directory and `pwd` ("print working directory") to see your current location. The CWD is often shown in the prompt.

```console
[username@hostname ~]$ cd Downloads
[username@hostname Downloads]$ pwd
/home/username/Downloads
```

The `~` character is a shorthand for your home directory.

**Key takeaway:** Always be aware of your current working directory. If a command behaves unexpectedly, you might be in the wrong directory.

## Copy-pasting commands

This tutorial has many commands for you to copy. You can copy-paste multi-line commands without issue.

-   On Linux/Windows, use <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd>/<kbd>V</kbd>.
-   On Mac, <kbd>Command</kbd>+<kbd>C</kbd>/<kbd>V</kbd> works as usual.

If you accidentally use <kbd>Ctrl</kbd>+<kbd>V</kbd> on Linux/Windows, you'll see strange characters (`^[[200~...`). Just press <kbd>Enter</kbd> to get a fresh prompt and try again.

Lines starting with a pound sign (`#`) are **comments** and are ignored by the terminal.

You can practice by copy-pasting the following command into your terminal:

```sh
# Here are some example comments:
#
# This is the program being run.
# |
# |  This is the start of the first argument.
# |  |
# |  |      This is the start of the second argument.
# v  v      v
echo Hello, terminal! # Placing a comment next to a command is also allowed.
```

## Redirection

By default, programs print to "standard out" (stdout), which is your terminal. You can **redirect** stdout to a file using the `>` operator, which overwrites the file.

```sh
echo "bread, onions, tea" > groceries.txt
```

To append to a file instead, use the `>>` operator.

## Pagers

A **pager** is a program that displays large amounts of text one screen at a time. Some commands, including `jj`, will automatically use a pager for long output.

-   Press <kbd>q</kbd> to quit.
-   Use arrow keys or page up/down to navigate.
-   Press <kbd>/</kbd> to start a search, and use <kbd>n</kbd>/<kbd>N</kbd> to find the next/previous match.

If you see a colon `:` at the bottom-left of your terminal, you are likely in a pager.

## Variables and the environment

While we often refer to the "terminal" as a whole, it's actually the **shell** (the program interpreting your commands) that provides scripting features, like variables.

```console
$ my_name=Alice
$ echo Hello, $my_name!
Hello, Alice!
```

To make a variable accessible to programs you run, you must **export** it into the **environment**. These are called **environment variables**. By convention, their names are uppercase.

```sh
export MY_NAME=Alice
```

## The `PATH` variable

`PATH` is a special environment variable. It contains a colon-separated list of directories where the terminal searches for programs.

```console
$ echo $PATH
/home/username/.local/bin:/usr/local/bin:/usr/bin
```

If you try to run a program and get a "No such file or directory" error, the program might not be in a directory listed in `PATH`. You can add a new directory to `PATH` like this:

```sh
export PATH="/path/to/my-programs:$PATH"
```

If you mess up your `PATH`, the easiest fix is to close the terminal and open a new one.

## Startup scripts

Changes to environment variables like `PATH` only last for the current session. To make them permanent, add the `export` command to a **startup script**, which runs every time you open a new terminal.

The script's name depends on your shell. Find your shell by running `echo $SHELL`.

-   For `bash`, edit `~/.bashrc`.
-   For `zsh`, edit `~/.zshrc`.

You can view your script's content with `cat ~/.bashrc` (or `~/.zshrc`).

```admonish success title="Now you know the basics of the terminal ! 🎉"
That's enough terminal knowledge to get you through this tutorial. Don't hesitate to come back and review this chapter if you need a refresher.
```
