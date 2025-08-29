#!/usr/bin/env bash
set -euxo pipefail

if [ "${1:-x}" = "x" ] ; then
    echo "Please provide the chapter keyword as the first argument."
    exit 1
fi
chapter="$1"

function success() {
    set +x
    echo "✅✅✅ Reset script completed successfully! ✅✅✅"
    exit 0
}

# Ensure existing user configuration does not affect script behavior.
export JJ_CONFIG=/dev/null

rm -rf ~/jj-tutorial

if ! command -v jj > /dev/null ; then
    echo "ERROR: Jujutsu doesn't seem to be installed."
    echo "       Please install it and rerun the script."
    exit 1
fi

if [ "$chapter" = initialize ] ; then success ; fi

mkdir -p ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj git init --colocate

jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = log ] ; then success ; fi

if [ "$chapter" = make_changes ] ; then success ; fi

echo "# jj-tutorial" > README.md
jj log -r 'none()' # trigger snapshot

if [ "$chapter" = commit ] ; then success ; fi

jj commit --message "Add readme with project title

It's common practice for software projects to include a file called
README.md in the root directory of their source code repository. As the
file extension indicates, the content is usually written in markdown,
where the title of the document is written on the first line with a
prefixed \`#\` symbol.
"

if [ "$chapter" = remote ] ; then success ; fi

git init --bare ~/jj-tutorial/remote
jj git remote add origin ~/jj-tutorial/remote
jj bookmark create main --revision @-
jj git push --bookmark main --allow-new

if [ "$chapter" = clone ] ; then success ; fi

cd ~
rm -rf ~/jj-tutorial/repo
jj git clone --colocate ~/jj-tutorial/remote ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj describe --reset-author --no-edit

if [ "$chapter" = github ] ; then success ; fi

if [ "$chapter" = update_bookmark ] ; then success ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj commit -m "Add project description to readme"

jj bookmark move main --to @-

jj git push

if [ "$chapter" = branch ] ; then success ; fi

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

if [ "$chapter" = show ] ; then success ; fi

if [ "$chapter" = merge ] ; then success ; fi

jj new main@origin @-

jj commit -m "Merge code and documentation for hello-world"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = ignore ] ; then success ; fi

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

if [ "$chapter" = rebase ] ; then success ; fi

jj bookmark move main --to @-
jj git fetch
jj rebase --destination main@origin
jj git push

if [ "$chapter" = more_bookmark ] ; then success ; fi

cd ~/jj-tutorial/repo

echo "for (i = 0; i < 10; i = i + 1):
    print('Hello, world!')" > hello.py

jj commit -m "WIP: Add for loop (need to fix syntax)"

jj git push --change @-

if [ "$chapter" = navigate ] ; then success ; fi

jj git fetch
jj new main

set +x
echo "Error: Didn't recognize the chapter keyword: '$chapter'."
exit 1
