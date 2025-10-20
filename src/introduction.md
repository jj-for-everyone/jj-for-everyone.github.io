# Introduction

```admonish note
This is a simplified and condensed (TL;DR) version of the [original tutorial](https://jj-for-everyone.github.io/). If you prefer a little bit longer (but more entertaining) one, consider reading the original one. This version is my intermediate product to build the tutorial in Thai. I used AI to help with summarize each page, then I review and edit myself.
```

This tutorial teaches the [Jujutsu](https://github.com/jj-vcs/jj) version control system (VCS). It's designed for beginners with **no previous experience with Git** or any other VCS.

If you already know Git, you might prefer [Steve Klabnik's tutorial](https://steveklabnik.github.io/jujutsu-tutorial).

This tutorial uses the terminal. We'll cover the basics, so don't worry if you're new to it. The commands are for Unix-like systems (Linux, Mac). Windows users can use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## What is version control?

Version control helps you track changes in a project over time. It's like having a "save" button for your entire project, allowing you to:
- Go back to previous versions of your work.
- See who changed what, and when.
- Collaborate with others without overwriting their work.

It's essential for software development, but can be used for any project with files that change over time, like this tutorial itself!

## Why Jujutsu instead of Git?

Git is the most popular VCS. So why learn Jujutsu?

- **It's Git-compatible.** You can use Jujutsu with any Git project.
- **It's easier to learn.** Jujutsu has a simpler, more intuitive interface than Git.
- **It's more powerful.** Despite being simpler, Jujutsu has advanced features that surpass Git's.

However, there are some trade-offs:
- **Git-centric World:** Most developers use Git, so you may need to "translate" concepts when talking to them.
- **Missing Features:** Jujutsu is new and doesn't have every single Git feature yet, though you can fall back to Git when needed.
- **Unstable CLI:** The command-line interface is still evolving, so commands might change in future versions.

Despite these points, the benefits of learning Jujutsu are **well worth it**.
