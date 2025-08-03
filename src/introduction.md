# Introduction

This is a tutorial for the [Jujutsu](https://github.com/jj-vcs/jj) version control system.
It requires **no previous experience with Git** or any other version control system.

At the time of writing, most Jujutsu tutorials are targeted at experienced Git users, teaching them how to transfer their existing Git skills over to Jujutsu.
This book is my attempt to fill the void of beginner learning material for Jujutsu.
If you are already experienced with Git, I recommend [Steve Klabnik's tutorial](https://steveklabnik.github.io/jujutsu-tutorial) instead of this book.

I do assume you know how to run commands in the terminal.
TODO reference optional terminal basics chapter.
I will often suggest you run commands to modify files, which only work on Unix-like operating systems like Linux and Mac.
If you're on Windows and can't switch to Linux, consider using [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## How to read this book

The book is split into **levels**, which are indicated in the sidebar.
The idea is that once you complete a level, you should probably put this book away and practice what you've learned.
When you're comfortable with those skills, come back for the next level.

There is one exception to this:
If you're here because you need to **collaborate with other people**, you should push through to the end of **level 1** right away.

Here's an overview of the planned levels:

| level | description |
| :-: | --- |
| **0** | The bare minimum to get started. This is only enough for the simplest use cases where you're working alone. For example, students who track and submit their homework with a Git repository can get by with only this. |
| **1** | The bare minimum for any sort of collaboration. Students who are working on a group project and professional software developers need to know this. Going further is highly recommended, but you can take a break after this. |
| **2** | Basic history navigation and problem solving skills like conflict resolution. Without this knowledge, it's only a matter of time until you have to ask one of your peers to fix something for you. Completing this level is probably comparable to the skill level of the average software developer. |
| **3** | History rewriting skills. These will allow you to iterate toward a polished version history, which pays dividends long-term. Some projects require you to have these skills in order to meet their quality standards. |
| **4** | Rounding out the skill set with productivity boosters, advanced workflows, lesser-known CLI functions and a little VCS theory. At the end of this, you can pat yourself on the back and move on to new adventures. |
| **5** | Additional topics that only come up in specific situations: tags, submodules, workspaces etc. Consider skimming the list of topics and come back once you have an actual need for it. |

Only a few levels are complete right now, the rest are on the way.
If you want to be notified when a new level becomes available, **subscribe to releases of the GitHub repo**.
I will "cut a release" every time a new level is complete, causing you to get an email from GitHub.
Go to [the repo](https://github.com/jj-for-everyone/jj-for-everyone.github.io) and click on "watch > custom > releases".

### Restoring your progress

Throughout the book, you will build an example repository.
Later chapters depend on the repo state of previous ones.
Losing the state of the example repo can therefore block you from making smooth progress.
This might happen for several valid reasons:
- You switch computers or reinstall the OS.
- You intentionally delete it to clean up your home directory.
- You use the example repo for off-road experimentation with Jujutsu.

To solve this problem, there is a script which automates the task of recreating the example repo.
It expects the number of the next chapter as the first argument.
For example, to set everything up to continue with chapter **4**, you can run:

```sh
curl https://jj-for-everyone.github.io/restore_script.sh | bash -s 4
#                                                                 ^^^
#                                                    the next chapter
```

```admonish info title="Always be careful when executing scripts from the internet!"
The script is not complicated, you can verify that it's not doing anything malicious.
For convenience, it's included in the expandable text box below.
You can also download the script [here](./restore_script.sh) and then execute it locally once you have inspected it.
```

`````admonish note title="Source of restore script" collapsible=true
````sh
{{ #include restore_script.sh }}
````
`````

## Help make this book better

If you find a typo, you can suggest a fix directly by clicking on the "edit" icon in the top-right corner.
If you have general suggestions for improvement, please [open an issue](https://github.com/jj-for-everyone/jj-for-everyone.github.io/issues/new).
I am also very interested in experience reports, for example:
- Do you have any frustrations with Jujutsu which the tutorial did not help you overcome?
- Was there a section that wasn't explained clearly?
  (If you didn't understand something, it's probably the book's fault, not yours!)
- Did you complete a level but didn't feel like you had the skills that were promised in the level overview?
- Is there something missing that's not being taught but should?
- Do you feel like the content could be structured better?

Thank you for helping me improve this tutorial!

## What is version control and why should you use it?

I will assume you're using version control for software development, but it can be used for other things as well.
For example, authoring professionally formatted documents with tools like [Typst](https://typst.app/).
The source of this book is stored in version control too!

What these scenarios have in common is that a large body of work (mostly in the form of text) is slowly being expanded and improved over time.
You don't want to lose any of it and you want to be able to go back to previous states of your work.
Often, several people need to work on the project at the same time.

A general-purpose backup solution can keep a few copies of your files around.
A graphical document editor can allow multiple people to edit the text simultaneously.
But sometimes, you need a sharper knife.
Jujutsu is the sharpest knife available.

## Why Jujutsu instead of Git?

Git is by far the most commonly used VCS in the software development industry.
So why not use that?
Using the most popular thing has undeniable benefits.
There is lots of learning material, lots of people can help you with problems, lots of other tools integrate with it etc.
Why make life harder on yourself by using a lesser-known alternative?

Here's my elevator pitch:
- **Jujutsu is compatible with Git.**
  You're not actually losing _anything_ by using Jujutsu.
  You can work with it on any existing project that uses Git for version control without issues.
  Tools that integrate with Git mostly work just as well with Jujutsu.

- **Jujutsu is easier to learn than Git.**
  (That is, assuming I did a decent job writing this tutorial.)
  Git is known for its complicated, unintuitive user interface.
  Jujutsu gives you all the functionality of Git with a lot less complexity.
  Experienced users of Git usually don't care about this, because they've paid the price of learning Git already.
  (I was one of these people once.)
  But you care!

- **Jujutsu is more powerful than Git.**
  Despite the fact that it's easier to learn and more intuitive, it actually has loads of awesome capabilities for power users that completely leave Git in the dust.
  Don't worry, you don't have to use that power right away.
  But you can be confident that if your VCS-workflow becomes more demanding in the future, Jujutsu will have your back.
  This is not a watered-down "we have Git at home" for slow learners!

Learning Jujutsu instead of Git as your first VCS does have some downsides:

- When talking about version control with peers, they will likely use Git-centric vocabulary.
  Jujutsu shares a lot of Git's concepts, but there are also differences.
  Translating between the two in conversation can add some mental overhead.
  (solution: convince your peers to use Jujutsu 😉)

- Jujutsu is relatively new and doesn't cover 100% of the features of Git yet.
  When you do run into the rare problem where Jujutsu doesn't have an answer, you can always fall back to use Git directly, which works quite seamlessly.
  Still, having to use two tools instead of one is slightly annoying.
  I plan to teach these Git features in this book at a higher level.
  The book should be a one-stop-shop for all Jujutsu users.

- The command line interface of Jujutsu is not yet stable.
  That means in future versions of Jujutsu, some commands might work a little differently or be renamed.
  I personally don't think this should scare you away.
  Many people including me have used Jujutsu as a daily driver for a long time.
  Whenever something _did_ change, my reaction was usually:
  "Great, that was one of the less-than-perfect parts of Jujutsu! Now it's even more intuitive than before!"
  You can subscribe to release announcements on the [GitHub repo](https://github.com/jj-vcs/jj) (watch > custom > releases).
  You will get a monthly email with the release notes, including any breaking changes.

Despite some downsides, I think the benefits are **well worth it**.
