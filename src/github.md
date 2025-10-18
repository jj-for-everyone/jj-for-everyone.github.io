# Using GitHub (optional)

This section is optional and can be skipped.

GitHub is a popular, proprietary Git hosting service. For open-source alternatives, consider [Forgejo](https://forgejo.org/), [Codeberg](https://codeberg.org/), [Sourcehut](https://sourcehut.org/), [Gerrit](https://www.gerritcodereview.com/), [Tangled](https://tangled.sh/), or [Radicle](https://radicle.xyz/) .

## Authenticating with an SSH Key

Using an SSH key is more secure and convenient than a password for authenticating with GitHub.

1.  **Generate a new key:** Follow GitHub's guide on [generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
2.  **Add the key to your account:** Follow the guide on [adding an SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Verify your setup with this command:

```sh
ssh -T git@github.com
```

You should see a success message like: `Hi user! You've successfully authenticated...`

## Creating a New Repository on GitHub

1.  Go to [github.com/new](https://github.com/new).
2.  Choose an owner and a repository name.
3.  **Important:** If you plan to push an existing local repository, **do not** initialize the new repository with a `README`, `.gitignore`, or license file.
4.  Click "Create repository".

## Cloning an Existing Repository

1.  On the repository's GitHub page, click the green "Code" button.
2.  Select the **SSH** tab and copy the URL.
    ![](./github_ssh_url.png)
3.  Run the clone command in your terminal:

    ```sh
    jj git clone <COPIED_URL>
    ```
