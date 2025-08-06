#!/usr/bin/env bash
set -euxo pipefail

if [ "${1:-x}" = "x" ] ; then
    echo "Please provide the number of the next chapter as the first argument."
    exit 1
fi
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "The provided chapter must be a number."
    exit 1
fi
chapter=$(($1-1))

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

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

if ! command -v jj > /dev/null ; then
    echo "ERROR: Jujutsu doesn't seem to be installed."
    echo "       Please install it and rerun the script."
    exit 1
fi

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

mkdir -p ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj git init --colocate

jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

echo "# jj-tutorial" > README.md
jj log -r 'none()' # trigger snapshot

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

jj commit --message "Add readme with project title

It's common practice for software projects to include a file called
README.md in the root directory of their source code repository. As the
file extension indicates, the content is usually written in markdown,
where the title of the document is written on the first line with a
prefixed \`#\` symbol.
"

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

mkdir ~/jj-tutorial/remote
cd ~/jj-tutorial/remote
git init --bare
cd ~/jj-tutorial/repo
jj git remote add origin ~/jj-tutorial/remote
jj bookmark create main --revision @-
# TODO: fix use of --allow-new.
# The tutorial doesn't actually tell readers to add the --allow-new flag, which
# is because there is no way of explaining it well. It's simply bad UI. Work on
# a better UI is ongoing.
jj git push --bookmark main --allow-new
cd ~
rm -rf ~/jj-tutorial/repo
jj git clone --colocate ~/jj-tutorial/remote ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj commit -m "Add project description to readme"

jj bookmark move main --to @-

jj git push

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

echo "print('Hello, world!')" > hello.py

jj commit -m "Add Python script for greeting the world

Printing the text \"Hello, world!\" is a classic exercise in introductory
programming courses. It's easy to complete in basically any language and
makes students feel accomplished and curious for more at the same time."

jj git clone --colocate ~/jj-tutorial/remote ~/jj-tutorial/repo-bob
cd ~/jj-tutorial/repo-bob
jj config set --repo user.name Bob
jj config set --repo user.email bob@local
jj describe --reset-author --no-edit

echo "# jj-tutorial

The file hello.py contains a script that greets the world.
It can be executed with the command 'python hello.py'.
Programming is fun!" > README.md
jj commit -m "Document hello.py in README.md

The file hello.py doesn't exist yet, because Alice is working on that.
Once our changes are combined, this documentation will be accurate."

jj bookmark move main --to @-
jj git push

cd ~/jj-tutorial/repo
jj bookmark move main --to @-
jj git fetch

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

jj new main@origin @-

jj commit -m "Combine code and documentation for hello-world"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

cd ~/jj-tutorial/repo-bob

tar czf submission_alice_bob.tar.gz README.md

echo "
## Submission

Run the following command to create the submission tarball:

~~~sh
tar czf submission_alice_bob.tar.gz [FILE...]
~~~" >> README.md

echo "*.tar.gz" > .gitignore

jj file untrack submission_alice_bob.tar.gz

jj commit -m "Add submission instructions"

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

jj bookmark move main --to @-
jj git fetch
jj rebase --destination main@origin
jj git push

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

cd ~/jj-tutorial/repo

echo "for (i = 0; i < 10; i = i + 1):
    print('Hello, world!')" > hello.py

jj commit -m "WIP: Add for loop (need to fix syntax)"

jj git push --change @-

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

jj git fetch
jj new main

if [ "$chapter" = 0 ] ; then success ; else chapter=$((chapter-1)) ; fi

echo "Error: The book doesn't have that many chapters."
exit 1
