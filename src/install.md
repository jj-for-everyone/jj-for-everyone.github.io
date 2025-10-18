# Installation and setup

For a quick installation on Linux or Mac, run this in your terminal:

```sh
curl https://mise.run | sh
~/.local/bin/mise install-into jujutsu@latest /tmp/jj-install
mv /tmp/jj-install/jj ~/.local/bin
rm -rf /tmp/jj-install
exec $SHELL --login
```

Then, run `jj --version` to verify the installation. If you see a `command not found` error, your shell may not have `~/.local/bin` in its `PATH`.

````admonish fail title="jj: command not found..." collapsible=true
Your system probably doesn't add `~/.local/bin` to the `PATH` environment variable. To fix this, find your shell by running `echo $SHELL`.

Then, add the directory to your `PATH` in your shell's startup script:

```sh
# For bash:
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

# For zsh:
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc
```

Restart your terminal for the changes to take effect.
````

````admonish info title="Other installation methods" collapsible=true
- **cargo-binstall**: `cargo-binstall jj-cli`
- **Homebrew (macOS)**: `brew install jj`
- **Winget (Windows)**: `winget install jj-vcs.jj`
- **Compile from source**: `cargo install --locked --bin jj jj-cli`
- **Manual download**: Download a binary from the [releases page](https://github.com/jj-vcs/jj/releases/latest).

For more details, see the [official installation instructions](https://jj-vcs.github.io/jj/latest/install-and-setup/).
````

## Initial configuration

You **must** configure your name and email. This information is stored in the commits you create.

```sh
jj config set --user user.name "Your Name"
jj config set --user user.email "your@email.com"
```

If you contribute to public projects, consider using a handle for your name and a private email address for privacy. [GitHub offers one](https://github.com/settings/emails) you can use.

For command-line completion, see the [official instructions](https://jj-vcs.github.io/jj/latest/install-and-setup/#command-line-completion).

## Optional: Install a simple text editor

Jujutsu sometimes opens a text editor for you. The default editor, `nano`, can be unintuitive. I recommend installing [edit](https://github.com/microsoft/edit), a simpler alternative.

If you used `mise` to install Jujutsu, you can use it to install `edit` as well:

```sh
mise install-into edit@latest /tmp/edit-install
mv /tmp/edit-install/edit ~/.local/bin
rm -rf /tmp/edit-install
```

Then, configure Jujutsu to use it:

```sh
jj config set --user ui.editor edit
```

To exit `edit`, press <kbd>Ctrl+Q</kbd>. It will ask if you want to save; press <kbd>Enter</kbd> to confirm.
