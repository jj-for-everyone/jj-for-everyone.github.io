#!/usr/bin/env bash
set -euxo pipefail

if [ "${1:-x}" = "x" ] ; then
    echo "Please provide the number of the next chapter as the first argument."
    exit 1
fi
chapter="$1"

function success() {
    set +x
    echo "
    ┌──────────────────────────────────────────────────────────────────────┐
    │                                                                      │
    │                Restore script completed successfully!                │
    │                                                                      │
    └──────────────────────────────────────────────────────────────────────┘
"
    exit 0
}

# Ensure existing user configuration does not affect script behavior.
export JJ_CONFIG=/dev/null

rm -rf ~/jj-tutorial
rm -rf ~/jj-tutorial-remote
rm -rf ~/jj-tutorial-bob

if [ "$chapter" = 1 ] ; then success ; fi

if ! command -v jj > /dev/null ; then
    echo "ERROR: Jujutsu doesn't seem to be installed."
    echo "       Please install it and rerun the script."
    exit 1
fi

if [ "$chapter" = 2 ] ; then success ; fi

mkdir ~/jj-tutorial
cd ~/jj-tutorial
jj git init --colocate

jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = 3 ] ; then success ; fi

if [ "$chapter" = 4 ] ; then success ; fi

echo "# jj-tutorial" > README.md
jj log -r 'none()' # trigger snapshot

if [ "$chapter" = 5 ] ; then success ; fi

jj describe --message "Add readme with project title

It's common practice for software projects to include a file called
README.md in the root directory of their source code repository. As the
file extension indicates, the content is usually written in markdown,
where the title of the document is written on the first line with a
prefixed \`#\` symbol.
"

if [ "$chapter" = 6 ] ; then success ; fi

jj new

if [ "$chapter" = 7 ] ; then success ; fi

mkdir ~/jj-tutorial-remote
cd ~/jj-tutorial-remote
git init --bare
cd ~/jj-tutorial
jj git remote add origin ~/jj-tutorial-remote
jj bookmark create main --revision @-
# TODO: fix use of --allow-new.
# The tutorial doesn't actually tell readers to add the --allow-new flag, which
# is because there is no way of explaining it well. It's simply bad UI. Work on
# a better UI is ongoing.
jj git push --bookmark main --allow-new
cd ~
rm -rf ~/jj-tutorial
jj git clone --colocate ~/jj-tutorial-remote ~/jj-tutorial
cd ~/jj-tutorial
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = 8 ] ; then success ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj describe -m "Add project description to readme"
jj new

jj bookmark move main --to @-

jj git push

if [ "$chapter" = 9 ] ; then success ; fi

echo "print('Hello, world!')" > hello.py

jj describe -m "Add Python script for greeting the world

Printing the text \"Hello, world!\" is a classic exercise in introductory
programming courses. It's easy to complete in basically any language and
makes students feel accomplished and curious for more at the same time."

jj new

jj git clone --colocate ~/jj-tutorial-remote ~/jj-tutorial-bob
cd ~/jj-tutorial-bob
jj config set --repo user.name Bob
jj config set --repo user.email bob@local
jj describe --reset-author --no-edit

echo "# jj-tutorial

The file hello.py contains a script that greets the world.
It can be executed with the command 'python hello.py'.
Programming is fun!" > README.md
jj describe -m "Document hello.py in README.md

The file hello.py doesn't exist yet, because Alice is working on that.
Once our changes are combined, this documentation will be accurate."
jj new

jj bookmark move main --to @-
jj git push

cd ~/jj-tutorial
jj bookmark move main --to @-
jj git fetch

if [ "$chapter" = 10 ] ; then success ; fi

if [ "$chapter" = 11 ] ; then success ; fi

jj new main@origin @-

jj describe -m "Combine code and documentation for hello-world"
jj new
jj bookmark move main --to @-
jj git push

if [ "$chapter" = 12 ] ; then success ; fi

cd ~/jj-tutorial-bob

tar czf submission_alice_bob.tar.gz README.md

echo "
## Submission

Run the following command to create the submission tarball:

~~~sh
tar czf submission_alice_bob.tar.gz [FILE...]
~~~" >> README.md

jj describe -m "Add submission instructions"

echo "*.tar.gz" > .gitignore

jj file untrack submission_alice_bob.tar.gz

if [ "$chapter" = 13 ] ; then success ; fi

jj new
jj bookmark move main --to @-
jj git fetch
jj rebase --destination main@origin
jj git push

if [ "$chapter" = 14 ] ; then success ; fi

cd ~/jj-tutorial

echo "
for (i = 0; i < 10; i = i + 1):
    print('Hello, world!')" >> hello.py

jj describe -m "WIP add for loop (need to fix syntax)"
jj new

jj git push --change @-

if [ "$chapter" = 15 ] ; then success ; fi

jj git fetch
jj new main

if [ "$chapter" = 16 ] ; then success ; fi

echo "Error: unrecognized chapter."
exit 1
