#!/bin/sh -l

# config git
DEFAULT_USER=${GITHUB_ACTOR}
DEFAULT_EMAIL=${GITHUB_ACTOR}@users.noreply.github.com
git config --local user.name "${INPUT_GIT_USER:=${DEFAULT_USER}}"
git config --local user.email "${INPUT_GIT_EMAIL:=${DEFAULT_EMAIL}}"

# check github token
[ -z "${INPUT_GITHUB_TOKEN}" ] && {
  echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
  exit 1;
};

# checkout gh-pages branch
set +e
git fetch
git checkout -b gh-pages
git pull origin gh-pages --rebase || echo "Branch gh-pages does not exist on remote"
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
