# Terminal basics

This chapter is not about Jujutsu or even version control.
But the tutorial requires you to work in the terminal, so let's cover the basics.
If you're already comfortable in the terminal, you can confidently skip this chapter.

There are a lot of small things to cover, so here's a little table of contents:

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

The terminal is an application that lets you enter commands to the operating system in the form of text.
The commands usually produce text themselves, which will be displayed to you.

The terminal used to be the primary way people interact with a computer.
That was before the time of graphical user interfaces.
Today, the terminal works much the same as it did in the past, but it's inside a normal app window now.
The app can have different names, but "Terminal" and "Console" or variations thereof are most common.

## The prompt

When you start the terminal, the initial text you will see is called the **prompt**.
Whenever a command finishes running, the prompt will be shown again.
That's your sign that you can start entering your next command.
Here's an example of what a prompt can look like:

```
[username@hostname ~]$
```

This shows some information that'll be useful later, but don't worry about it for now.
The prompt usually ends with a dollar **`$`** or percent **`%`** sign, so you can easily recognize it.
The dollar sign is often used as a short representation of the prompt.

## Entering commands

Being presented with the prompt is our cue to execute commands, so let's do that.
Type the following and then press <kbd>Enter</kbd>:

```sh
echo Hello, terminal!
```

The terminal will split your commands into words based on whitespace.
The above command has three words:
- `echo`
- `Hello,`
- `terminal!`

The first word is the program to run.
The terminal will find a program called `echo` on your computer and run it with the two **arguments** `Hello,` and `terminal!`.
The program is free to interpret these arguments however it wants.
The program called `echo` happens to simply print its arguments back to the terminal:

```console
$ echo Hello, terminal!
Hello, terminal!
```

## The current working directory

One fundamental concept of the terminal is the **current working directory**.
It's a location in your filesystem, the one "where you currently are".

Most commands you run behave differently based on this "current location".
Because of that, we need to be able to change it.
The command to do that is called `cd`, short for "change directory".
You probably have a folder called "Downloads", but you can substitute a different one in this example:

```console
[username@hostname ~]$ cd Downloads
[username@hostname Downloads]$
```

Oh!
Did you notice that **the prompt changed**?
The current working directory, or CWD for short, is so important that it's usually shown somewhere in the prompt.
That way you always know "where you are".

Before running `cd` in the example above, the CWD was apparently the tilde **`~`** character.
That's a shorthand for your user's **home directory**.
On Linux, that's `/home/username`.
Another way to determine your CWD is to call the command `pwd`, short for "print working directory".
It expands the shorthand tilde **`~`** character to its full path.

```
[username@hostname Downloads]$ pwd
/home/username/Downloads
[username@hostname Downloads]$
```

One example of a CWD-aware command is `ls`, which lists files and directories.
Go ahead and run `ls` in your `Downloads` folder.
Maybe it's time to clean it up a little...?

The important lesson to take away here is:
**Be aware of your current working directory**.
If a command doesn't do what you want, you might just be in the wrong place.


## Copy-pasting commands

This tutorial contains many code blocks that contain commands for you to copy-paste into your terminal.
Multiple commands can be on separate lines and you can copy-paste them all at once without issues.
If you hover your mouse over the top-right corner of a code block, a hidden copy-button will appear.
Very useful!

For historical reasons, <kbd>Ctrl</kbd>+<kbd>C</kbd> and <kbd>Ctrl</kbd>+<kbd>V</kbd> don't do copy and paste in the terminal.
Instead, you need to use <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd>/<kbd>V</kbd> respectively.
If you're using a Mac, <kbd>Command</kbd>+<kbd>C</kbd>/<kbd>V</kbd> works normally.

If you forget about this and type <kbd>Ctrl</kbd>+<kbd>V</kbd> without <kbd>Shift</kbd> in an attempt to paste a command into the terminal, it will actually get messed up a little.
You can't just try again with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>V</kbd>.
You would end up with something like this:

```console
$ ^[[200~echo Hello, terminal!~
```

These weird characters are an "escape sequence" caused by typing <kbd>Ctrl</kbd>+<kbd>V</kbd> without <kbd>Shift</kbd>.
This command will not work.
So, if you make the mistake of forgetting <kbd>Shift</kbd>, just hit <kbd>Enter</kbd> a couple of times until you get a fresh prompt, then try again.

Some of the commands will contain **comments**, which are lines of text following a pound **`#`** character.
The terminal simply ignores them.
They are used to make commands more understandable to human readers, but they don't affect the command execution.

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

We've seen how the `echo` command prints its arguments back to the terminal.
But that's just the default.
`echo` just prints to something called "standard out", or "stdout".
That is usually connected to your terminal.
But you can also **redirect** the stdout of a program, for example to a file with the `>` operator.
An example looks like this:

```sh
echo "bread, onions, tea" > groceries.txt
```

If you run this command, it will create a file called "groceries.txt" in your CWD.
The content of the file will be "bread, onions, tea".
If a file with the same name already existed, it will be **overwritten**.
In addition to the `>` operator, there is also the `>>` operator.
It _appends_ text to the end of a file, instead of _overwriting_ it.

In this book, I will often tell you to manipulate a file by running a command that looks like the one above.

## Pagers

Some commands you run in the terminal print a lot of text.
It can be tedious to scroll all the way back up to the point where the command output started.
This is where a **pager** can help.
It takes the output from another program and shows it to you from the beginning.

Some programs will display their output in a pager automatically, because they know they will be printing a lot of text.
Jujutsu also does that sometimes.
Given that you may "accidentally" end up in a pager, you need to know that you can **exit a pager by typing** <kbd>q</kbd>!

If the output of Jujutsu is displayed in a pager, the bottom left corner will be a colon `:` character and your prompt won't be shown.
One way you can experiment with using a pager is by running `man tar`, which opens the manual page for the `tar` command.

Various key bindings let you navigate in the pager.
The arrow keys, "page up" and "page down" all work as expected.
Another super useful one is this:
Typing <kbd>/</kbd> allows you to enter a search term, then <kbd>Enter</kbd> starts the search.
Step through the search hits with (lowercase) <kbd>n</kbd> and step backwards with (uppercase) <kbd>N</kbd>.

## Variables and the environment

Running programs on your computer by typing their name is only scratching the surface of what the terminal can do.
It actually has a whole little programming / scripting language built-in.
For example, you can store values in variables with the equal **`=`** sign and evaluate them with the dollar **`$`** sign:

```console
$ my_name=Alice
$ echo Hello, $my_name!
Hello, Alice!
```

Normal variables like above cannot be read by programs you run.
They are only for your own use in the current terminal session.
However, variables can be **exported** into the **environment**, which makes them accessible for programs to read.
This is an alternative way to tell programs what you want them to do.
The more common way is with arguments on the command line, but exported variables are useful in some situations.

You can export a variable separately from setting its value or do it all in one line:

```sh
MY_NAME=Alice
export MY_NAME
```

```sh
export MY_NAME=Alice
```

Such exported variables are usually referred to as **environment variables**.
They are not _required_ to be uppercase, but it's a strong convention.
It makes it easy to know which variables can be read by other programs.

## The `PATH` variable

One environment variable that can be difficult to understand at first is the `PATH` variable.
First, let's print it to see what it contains:

```console
$ echo $PATH
/home/username/.local/bin:/usr/local/bin:/usr/bin
```

Your output may well look different, but the structure is the same:
It's a list of filesystem paths separated by the colon **`:`** character.
In this case, there are three paths:
- `/home/username/.local/bin`
- `/usr/local/bin`
- `/usr/bin`

What do these three paths mean?
They are the places where your terminal searches for programs to run!
Let's mess with it to see what happens.
Set the `PATH` variable to the empty string:

```sh
export PATH=""
```

Now try to run a program, like `ls` for example:

```console
$ ls
bash: ls: No such file or directory
```

Oops.
Setting the `PATH` variable to the empty string tells the terminal to _not search for programs anywhere_.
Therefore, the programs `ls` cannot be found anymore.

We could fix this by copy-pasting the previous value of `PATH` and export that again.
But if you mess up the value of an environment variable for real, you often don't know what the previous, correct value was.
So it's easiest to just close the terminal window and open a new one.
All variables will be reset to their default.

So, if modifying the `PATH` variable can break your session, should you just never touch it?
Not quite.
Sometimes you want (or need) to install programs in a different location than where your terminal searches for them by default.
In that case, you need to _extend_ the list of paths stored in the `PATH` variable.
Here's an example:

```sh
export PATH="/home/username/my-local-programs:$PATH"
```

This starts with a new path at the front of the list, then there's the colon **`:`** separator and lastly the rest of the list, which is the previous value stored in `PATH`.

## Startup scripts

The above command to edit the `PATH` variable will only affect the current terminal session.
So, if you close the terminal and reopen a new window, the value of `PATH` will be reset to its default.
But that may not be desirable.
If you install programs into a custom location, you may want all your future terminal sessions to find those programs automatically.

That's where startup scripts come into play.
They are files containing a list of commands (also known as **scripts**).
_Startup_ scripts are automatically executed whenever you open a new terminal, before you can even type the first command.
So that's the perfect place to make permanent changes to all your future terminal sessions!

The location and name of your startup script depend on your **shell**, i.e. your specific "flavor" of terminal.
The terminal is pretty standardized, so we mostly don't need to worry about different shells.
This is an exception.
If you're using Linux, your shell is probably called `bash`.
If you're using Mac, your shell is probably called `zsh`.
To find out for sure, you can read the `SHELL` environment variable:

```console
$ echo $SHELL
/bin/bash
```

If your shell is `bash`, you should add your custom startup commands to the file **`~/.bashrc`**.
In the case of `zsh`, the startup script is **`~/.zshrc`**.

For now, print the content of your startup script.
It's probably complicated, so don't try to understand it all.
Nevertheless, taking a look is a great way to get acquainted with the terminal:

```sh
# for bash
cat ~/.bashrc
```

```sh
# for zsh
cat ~/.zshrc
```

```admonish success title="Now you know the basics of the terminal ! 🎉"
If most of this stuff was news to you, pat yourself on the back!
You've already learned a lot.
This should be enough knowledge about the terminal to get you through the tutorial.

Don't hesitate to come back here and revise from time to time.
The rules of the terminal are not the most intuitive, so it can take a couple attempts for them to settle in.
```
