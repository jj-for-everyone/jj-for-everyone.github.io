# Introduction

This is a tutorial for the [Jujutsu](https://github.com/jj-vcs/jj) version control system.
It requires **no previous experience with Git** or any other version control system.

At the time of writing, most Jujutsu tutorials are targeted at experienced Git users, teaching them how to transfer their existing Git skills over to Jujutsu.
This tutorial is my attempt to fill the void of beginner learning material for Jujutsu.
If you are already experienced with Git, I recommend [Steve Klabnik's tutorial](https://steveklabnik.github.io/jujutsu-tutorial) instead of this one.

This tutorial requires you to work in the terminal.
Don't worry, there's a chapter covering some terminal basics in case you're not 100% comfortable with that yet.
The commands I tell you to run will often only work on Unix-like operating systems like Linux and Mac.
If you're stuck on Windows, consider using [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## What is version control and why should you use it?

I will assume you're interested in considering version control for software development, but it can be used for other things as well.
For example, authoring professionally formatted documents with tools like [Typst](https://typst.app/).
The source of this tutorial is stored in version control too!

What these scenarios have in common is that a large body of work (mostly in the form of text) is slowly being expanded and improved over time.
You don't want to lose any of it and you may want to compare or be able to go back to previous states of your work.
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
  Git is known for its complicated, unintuitive user experience.
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
  Consider [subscribing to GitHub releases of this tutorial](watch_releases.md).
  You will be notified if new versions of Jujutsu change something in a way that's relevant to what you learned in this tutorial.

Despite some downsides, I think the benefits are **well worth it**.
