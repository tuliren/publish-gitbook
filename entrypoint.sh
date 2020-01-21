#!/bin/sh -l

# config git
git config --local user.name "${GITHUB_ACTOR}"
git config --local user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# check github token
[ -z "${INPUT_GITHUB_TOKEN}" ] && {
  echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
  exit 1;
};

# checkout gh-pages branch
set +e
git checkout gh-pages || git checkout -b gh-pages
git fetch origin && git reset origin/gh-pages
set -e

# install gitbook
npm install gitbook-cli  -g
gitbook -v
gitbook install

# build gitbook
gitbook build

# copy the static site files into the current directory
cp -R _book/* .

# remove 'node_modules' and '_book' directory
git clean -fx node_modules
git clean -fx _book

# add all files
git add .

# commit
COMMIT_MESSAGE="Update gitbook `date '+%Y-%m-%d %H:%M:%S'`"
git commit -a -m "${COMMIT_MESSAGE}"

# setup publisher
PUBLISHER_REPO="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git remote add publisher ${PUBLISHER_REPO}

# push to the publisher
git push -q -u publisher gh-pages
