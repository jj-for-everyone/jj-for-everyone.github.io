# Introduction

This is a tutorial for the [Jujutsu](https://github.com/jj-vcs/jj) version control system.
It requires **no previous experience with Git** or any other version control system.

At the time of writing, most Jujutsu tutorials are targeted at experienced Git users, teaching them how to transfer their existing Git skills over to Jujutsu.
This tutorial is my attempt to fill the void of beginner learning material for Jujutsu.
If you are already experienced with Git, I recommend [Steve Klabnik's tutorial](https://steveklabnik.github.io/jujutsu-tutorial) instead of this one.

This tutorial requires you to work in the terminal.
Don't worry, there's a chapter covering some terminal basics in case you're not 100% comfortable with that yet.
The commands I tell you to run will often only work on Unix-like operating systems like Linux and Mac.
If you're on Windows (and can't switch to Linux), consider using [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## How to read this tutorial

The tutorial is split into **levels**, which are the top-level chapters in the sidebar.
The idea is that once you complete a level, you should probably put this tutorial away for a while and practice what you've learned.
Once you're comfortable with those skills, come back for the next level.

There is one exception to this:
If you're here because you need to collaborate with other people, you should complete the levels 1 and 2 right away.

Here's an overview of the planned levels:

| Level | Description |
| :-: | --- |
| **1** | The bare minimum to get started. This is only enough for the simplest use cases where you're working alone. For example, students who track and submit their homework with a Git repository can get by with only this. |
| **2** | The bare minimum for any sort of collaboration. Students who are working on a group project and professional software developers need to know this. Going further is highly recommended, but you can take a break after this. |
| **3** | Basic problem solving skills like conflict resolution and restoring files from history. Without this knowledge, it's only a matter of time until you run into trouble. Completing this level is comparable to the skill level of the average software developer. |
| **4** | History rewriting skills. These will allow you to iterate toward a polished version history, which pays dividends long-term. Some projects require you to have these skills in order to meet their quality standards. |
| **5** | Productivity boosters, advanced workflows, lesser-known CLI functions and a little VCS theory. Completing this level means you have mastered Jujutsu. |
| **6** | Additional topics that only come up in specific situations: tags, submodules, workspaces etc. Consider skimming the list of topics and come back once you have an actual need for it. |

Only a few levels are complete right now, the rest are on the way.

## Reset your progress

Throughout the tutorial, you will build an example repository.
Later chapters depend on the state of previous ones.
Losing the state of the example repo can therefore block you from making smooth progress.
This might happen for several reasons:
- You use the example repo for practice and experimentation.
- You switch to a different computer or reinstall the OS.
- You intentionally delete it to clean up your home directory.
- The tutorial is updated significantly while you're taking a break.

To solve this problem, there is a script which automates the task of resetting your progress to the **start of any chapter**.
To identify the chapter you want to continue with, the script expects a keyword as an argument.
Each chapter includes its precise reset command at the beginning, so you can easily copy-paste it.

```admonish info title="Always be careful when executing scripts from the internet!"
The script is not complicated, you can verify that it's not doing anything malicious.
Basically, it's just the list of commands I tell you to run manually.
For convenience, it's included in the expandable text box below.
You can also download the script [here](./reset.sh) and then execute it locally once you have inspected it.
```

`````admonish note title="Source of reset script" collapsible=true
````sh
{{ #include reset.sh }}
````
`````

## Stay up to date

Both this tutorial and Jujutsu are still evolving.
In order to keep your Jujutsu knowledge updated, **subscribe to releases of the tutorial's GitHub repo**.
You will be notified of important changes:
- A new level becomes available.
- An existing level is changed significantly.

I especially intend to keep this tutorial updated as new version of Jujutsu come out with features and changes that are relevant to the tutorial's content.
I consider this tutorial up-to-date with the latest version of Jujutsu (`0.32`) as of **August 2025**.
If that's more than a couple months in the past, I probably stopped updating this tutorial.

You can subscribe to these updates by visiting the [GitHub repo](https://github.com/jj-for-everyone/jj-for-everyone.github.io) and clicking on "Watch", "Custom" and then selecting "Releases".

![screenshot of how to subscribe to release announcements](./watch_releases.png)

## Help make this tutorial better

If you find a typo, you can suggest a fix directly by clicking on the "edit" icon in the top-right corner.
If you have general suggestions for improvement, please [open an issue](https://github.com/jj-for-everyone/jj-for-everyone.github.io/issues/new).
I am also very interested in experience reports, for example:
- Do you have any frustrations with Jujutsu which the tutorial did not help you overcome?
- Was there a section that wasn't explained clearly?
  (If you didn't understand something, it's probably the tutorial's fault, not yours!)
- Did you complete a level but didn't feel like you had the skills that were promised in the level overview?
- Is there something missing that's not being taught but should?
- Do you feel like the content could be structured better?

Thank you for helping me improve this tutorial!

## What is version control and why should you use it?

I will assume you're using version control for software development, but it can be used for other things as well.
For example, authoring professionally formatted documents with tools like [Typst](https://typst.app/).
The source of this tutorial is stored in version control too!

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
  I plan to teach such Git features in this tutorial in later levels.
  The tutorial should be a one-stop-shop for all Jujutsu users.

- The command line interface of Jujutsu is not yet stable.
  That means in future versions of Jujutsu, some commands might work a little differently or be renamed.
  I personally don't think this should scare you away.
  Many people including me have used Jujutsu as a daily driver for a long time.
  Whenever something _did_ change, my reaction was usually:
  "Great, that was one of the less-than-perfect parts of Jujutsu! Now it's even more intuitive than before!"
  Consider [subscribing to GitHub releases of this tutorial](#stay-up-to-date).
  You will be notified if new versions of Jujutsu change something in a way that's relevant to what you learned in this tutorial.

Despite some downsides, I think the benefits are **well worth it**.
