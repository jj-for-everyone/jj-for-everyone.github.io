#!/usr/bin/env bash
set -euxo pipefail

red='\033[0;31m'
blue='\033[0;34m'
no_color='\033[0m' # No Color

error="${red}Error:${no_color}"
hint="${blue}Hint:${no_color}"

# The env variable JJ_TUTORIAL_DIR can be used to override the location of the
# tutorial repository. This is *intentionally not documented* in the tutorial,
# because doing so can lead to problems. For simplicity, the tutorial will
# continue to use the hardcoded path in code snippets to copy-paste into the
# terminal. If the location is changed, those code snippets will have to be
# adjusted manually. The feature is still there for opinionated folk who know
# what they're doing.
jj_tutorial_dir=${JJ_TUTORIAL_DIR:-$HOME/jj-tutorial}

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

rm -rf "$jj_tutorial_dir"

if [ "$chapter" = install ] ; then success ; fi

if ! command -v jj > /dev/null ; then
    set +x
    printf "$error Jujutsu doesn't seem to be installed.\n"
    printf "       Please install it and rerun the script.\n"
    exit 1
fi

# make sure jj version is recent enough
detected_version="$(jj --version | cut -c 6-7)"
required_version="36"
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

# Ensure existing user configuration does not affect script behavior.
export JJ_CONFIG=/dev/null
export GIT_CONFIG_GLOBAL=/dev/null

if [ "$chapter" = initialize ] ; then success ; fi

mkdir "$jj_tutorial_dir"
jj git init "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo

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

git init --bare -b main "$jj_tutorial_dir"/remote
jj git remote add origin "$jj_tutorial_dir"/remote
jj bookmark create main --revision @-
jj bookmark track main@origin
jj git push --bookmark main

if [ "$chapter" = update_bookmark ] ; then success ; fi

printf "\nThis is a toy repository for learning Jujutsu.\n" >> README.md
jj commit -m "Add project description to readme"

jj bookmark move main --to @-

jj git push

if [ "$chapter" = clone ] ; then success ; fi

cd ~
rm -rf "$jj_tutorial_dir"/repo
jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo
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

jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo-bob
cd "$jj_tutorial_dir"/repo-bob
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

cd "$jj_tutorial_dir"/repo
jj bookmark move main --to @-
jj git fetch

if [ "$chapter" = show ] ; then success ; fi

if [ "$chapter" = merge ] ; then success ; fi

jj new main@origin @-

jj commit -m "Merge code and documentation for hello-world"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = ignore ] ; then success ; fi

cd "$jj_tutorial_dir"/repo-bob

tar czf submission_alice_bob.tar.gz README.md

echo "
## Submission

Run the following command to create the submission tarball:

~~~sh
tar czf submission_alice_bob.tar.gz [FILE...]
~~~" >> README.md

jj show > /dev/null

echo "*.tar.gz" > .gitignore

jj file untrack submission_alice_bob.tar.gz

jj commit -m "Add submission instructions"

if [ "$chapter" = rebase ] ; then success ; fi

jj bookmark move main --to @-
jj git fetch
jj rebase --onto main@origin
jj git push

if [ "$chapter" = more_bookmarks ] ; then success ; fi

cd "$jj_tutorial_dir"/repo

echo 'for (i = 0; i < 10; i = i + 1):
    print("Hello, world!")' > hello.py

jj commit -m "WIP: Add for loop (need to fix syntax)"

jj git push --change @-

if [ "$chapter" = navigate ] ; then success ; fi

jj git fetch
jj new main
jj new 'description(substring:"Document hello.py in README.md")'
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
rm -rf "$jj_tutorial_dir"/repo
jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo

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

jj new 'description(substring:"WIP: Add for loop")'

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

jj abandon 'description(substring:"Experiment")'

jj git push --deleted

if [ "$chapter" = restore ] ; then success ; fi

rm README.md
jj show &> /dev/null

jj restore README.md

jj restore --from 'description(substring:"Fix loop syntax")' hello.py

jj commit -m "Remove translations"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = commit_interactive ] ; then success ; fi

# `jj commit --interactive doesn't work in a script, so we reproduce the same
# commits a little differently.
echo "Implement task 1" > task_1.txt
jj commit --message "Implement task 1" task_1.txt
echo "Implement task 2" > tasks_2_and_3.txt
jj commit --message "Implement task 2"
echo "Implement task 3" >> tasks_2_and_3.txt
jj commit --message "Implement task 3"

jj bookmark move main --to @-
jj git push

if [ "$chapter" = complete ] ; then success ; fi

set +x
echo "Error: Didn't recognize the chapter keyword: '$chapter'."
exit 1
