# Installation and setup

Please refer to the official documentation for installing Jujutsu:\
<https://docs.jj-vcs.dev/latest/install-and-setup/>

Then run `jj version` to verify the installation.
It should print the currently installed version of Jujutsu, something like `jj 0.47.1-blabla`.
If the output is an error instead, e.g. `bash: jj: command not found...`, open the text box below.

````admonish fail title="jj: command not found..." collapsible=true
You probably installed the `jj` binary to a location that is not in your `PATH` environment variable.
Remember: It lists the directories where your shell searches for programs to run, when you enter their name.
In order to fix that, refer to the [Terminal basics](./terminal_basics.md) page, specifically the [PATH variable](./terminal_basics.md#the-path-variable) and [startup scripts](./terminal_basics.md#startup-scripts) sections.

After editing your shell's startup script to include the `jj` installation directory in `PATH`, make sure to restart your shell or terminal so the changes take effect.
````

## Git

You also need to have Git installed.
MacOS and most Linux dirstros come with Git preinstalled.
If you don't have it yet, install it using your package manager, e.g. `sudo apt install git`.

## Initial configuration

Jujutsu is very configurable, but we don't care about most knobs and dials right now.
The only thing that you **must** configure is your name and email.
This is required metadata and some things won't work right without this information.
However, you don't have to enter your _real_ name and email, in case you're not comfortable storing that information in the repositories you're planning to work on.

If you're working on school or work projects, it's probably fine to configure your real name and school / work email.
These repositories are usually not publicly accessible.

If you're planning to work on open source projects that anyone can see, you may want to be more careful.
You could use your GitHub handle as username, but many are comfortable using their real name too.
The email address is more important.
If you use your normal, private email address, there is a risk of receiving undesirable emails at that address.
You might consider using a dedicated address just for open source work.
Another alternative is to use an address provided by GitHub.
It identifies your GitHub account, but you cannot receive emails through it.
Go to [GitHub's email settings](https://github.com/settings/emails) and select "Keep my email address private", your private email address will then be shown at the top.

Here are the commands to configure your username and email:

```sh
jj config set --user user.name "Anonymous"
jj config set --user user.email "anon@local"
```

### Shell completion

Typing out the commands for Jujutsu can become tedious.
"Shell completion" solves that problem.
It allows you to type the first few characters of a command, then hit the <kbd>Tab</kbd> key to complete the rest (assuming there is only one possibility left).
For example, typing `jj v<TAB>` would expand to `jj version`, because the version command is the only one starting with v.

In order for that to work, your shell needs to be "taught" about all the possible commands `jj` has.
Depending on your shell, add one of the following commands to your [startup script](./terminal_basics.md#startup-scripts):

| shell | startup command |
| --- | --- |
| Bash | `source <(COMPLETE=bash jj)` |
| Zsh | `source <(COMPLETE=zsh jj)` |
| Fish | built-in since v4.0.2 |

For more detailed information, including other shells, refer to the [documentation](https://docs.jj-vcs.dev/latest/install-and-setup/#command-line-completion).

### Text editor

Jujutsu will sometimes ask you to edit a text file.
The default text editor used for that purpose is `nano` on Linux and Mac.
It works fine, but it can be counter-intuitive for new users.
The most important commands to remember are:

- <kbd>Ctrl+O</kbd> to save the file
- <kbd>Ctrl+X</kbd> to close the program

I you'd like to use a different editor instead, refer to Jujutsu's [editor configuration documentation](https://docs.jj-vcs.dev/latest/config/#editor).
I recommend [edit](https://github.com/microsoft/edit) as a simple and intuitive nano-alternative.
If you use Visual Studio Code for programming, you can configure Jujutsu to use it with the following command:

```sh
jj config set --user ui.editor 'code --wait'
```
