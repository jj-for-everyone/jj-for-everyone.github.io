#!/usr/bin/env bash
set -euxo pipefail

red='\033[0;31m'
blue='\033[0;34m'
no_color='\033[0m' # No Color

error="${red}Error:${no_color}"
hint="${blue}Hint:${no_color}"

if [ "${1:-x}" = "x" ] ; then
    set +x
    printf "$error Please provide the chapter keyword as the first argument.\n"
    exit 1
fi
chapter="$1"

function success() {
    set +x
    echo "✅ Reset script completed successfully! ✅"
    exit 0
}

rm -rf ~/jj-tutorial

if [ "$chapter" = install ] ; then success ; fi

if ! command -v jj > /dev/null ; then
    set +x
    printf "$error Jujutsu doesn't seem to be installed.\n"
    printf "       Please install it and rerun the script.\n"
    exit 1
fi

# make sure jj version is recent enough
detected_version="$(jj --version | cut -c 6-7)"
required_version="33"
if [ "$detected_version" -lt "$required_version" ] ; then
    set +x
    printf "$error Your Jujutsu version (0.$detected_version) is too outdated.\n"
    printf "       Please update to version 0.$required_version or later.\n"
    printf "$hint If you installed Jujutsu with mise, as recommended in the installation\n"
    printf "      chapter, use the following commands to update:\n"
    echo "
mise install-into jujutsu@latest /tmp/jj-install
mv /tmp/jj-install/jj ~/.local/bin
rm -rf /tmp/jj-install"
    exit 1
fi

# Make sure user configured git.colocate = true
if [ "$(jj config get git.colocate)" != "true" ] ; then
    set +x
    printf "$error Your configuration of git.colocate is not set to true.\n"
    printf "       This will become the default in Jujutsu version 0.33, so don't worry"
    printf "       about having a non-standard configuration."
    printf "       Please run the following command:\n"
    echo "
jj config set --user git.colocate true"
    exit 1
fi

# Ensure existing user configuration does not affect script behavior.
tmp_config=/tmp/jj_for_everyone_reset_script_config.toml
echo "git.colocate = true" > $tmp_config
trap 'rm $tmp_config' EXIT
export JJ_CONFIG=$tmp_config

if [ "$chapter" = initialize ] ; then success ; fi

mkdir ~/jj-tutorial
jj git init ~/jj-tutorial/repo
cd ~/jj-tutorial/repo

jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

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

git init --bare -b main ~/jj-tutorial/remote
jj git remote add origin ~/jj-tutorial/remote
jj bookmark create main --revision @-
jj git push --bookmark main --allow-new

if [ "$chapter" = update_bookmark ] ; then success ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj commit -m "Add project description to readme"

jj bookmark move main --to @-

jj git push

if [ "$chapter" = clone ] ; then success ; fi

cd ~
rm -rf ~/jj-tutorial/repo
jj git clone ~/jj-tutorial/remote ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

if [ "$chapter" = github ] ; then success ; fi

if [ "$chapter" = branch ] ; then success ; fi

echo 'print("Hello, world!")' > hello.py

jj commit -m "Add Python script for greeting the world

Printing the text \"Hello, world!\" is a classic exercise in introductory
programming courses. It's easy to complete in basically any language and
makes students feel accomplished and curious for more at the same time."

jj git clone ~/jj-tutorial/remote ~/jj-tutorial/repo-bob
cd ~/jj-tutorial/repo-bob
jj config set --repo user.name Bob
jj config set --repo user.email bob@local
jj metaedit --update-author

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

echo 'for (i = 0; i < 10; i = i + 1):
    print("Hello, world!")' > hello.py

jj commit -m "WIP: Add for loop (need to fix syntax)"

jj git push --change @-

if [ "$chapter" = navigate ] ; then success ; fi

jj git fetch
jj new main
jj new 'description("Document hello.py in README.md")'
jj new main

if [ "$chapter" = undo ] ; then success ; fi

echo 'print("Hallo, Welt!")' >> hello.py
echo 'print("Bonjour, le monde!")' >> hello.py

jj commit -m "code improvements"

jj undo

jj commit -m "Print German and French greetings as well"

jj undo
jj undo
jj undo

jj redo
jj redo
jj redo

if [ "$chapter" = track ] ; then success ; fi

cd ~ # move out of the directory we're about to delete
rm -rf ~/jj-tutorial/repo
jj git clone ~/jj-tutorial/remote ~/jj-tutorial/repo
cd ~/jj-tutorial/repo

# roleplay as Alice
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

echo 'print("Hallo, Welt!")' >> hello.py
echo 'print("Bonjour, le monde!")' >> hello.py
jj commit -m "Print German and French greetings as well"

jj bookmark move main -t @-
jj git push

jj bookmark track 'glob:push-*@origin'

if [ "$chapter" = conflict ] ; then success ; fi

jj new 'description("WIP: Add for loop")'

echo 'for _ in range(10):
    print("Hello, world!")' > hello.py

jj commit -m "Fix loop syntax"

jj new main @-

echo 'for _ in range(10):
    print("Hello, world!")
    print("Hallo, Welt!")
    print("Bonjour, le monde!")' > hello.py

jj commit -m "Merge repetition and translation of greeting"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = abandon ] ; then success ; fi

jj commit -m "Experiment: Migrate to shiny new framework"
jj git push --change @-
jj new main
jj commit -m "Experiment: Improve scalability using microservices"
jj git push --change @-
jj new main
jj commit -m "Experiment: Apply SOLID design patterns"
jj git push --change @-
jj new main

jj abandon 'description("Experiment")'

jj git push --deleted

if [ "$chapter" = restore ] ; then success ; fi

rm README.md
jj show &> /dev/null

jj restore README.md

jj restore --from 'description("Fix loop syntax")' hello.py

jj commit -m "Remove translations"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = complete ] ; then success ; fi

set +x
echo "Error: Didn't recognize the chapter keyword: '$chapter'."
exit 1
