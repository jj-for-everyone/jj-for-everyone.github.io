#!/usr/bin/env bash
set -euo pipefail # enable strict error handling

set -x

bin_dir="$(jj root)/bin"

jj workspace add /tmp/jj-for-everyone-deploy-workspace
trap 'jj workspace remove jj-for-everyone-deploy-workspace' EXIT
cd /tmp/jj-for-everyone-deploy-workspace
ln -s "$bin_dir" ./bin # use installed bins from default workspace

jj new main

./bin/mdbook build --dest-dir docs
jj describe --message 'deploy to github pages'
jj bookmark track gh-pages &> /dev/null
jj abandon --retain-bookmarks gh-pages
jj bookmark move gh-pages --to @ --allow-backwards
jj git push --bookmark gh-pages
jj new main
jj bookmark forget gh-pages
jj git export
