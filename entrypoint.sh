#!/bin/sh -l

set -e

print_info(){
  echo "\033[32mINFO \033[0m $@" > /dev/stderr
}

print_error(){
  echo "\033[31mERROR\033[0m \a $@" > /dev/stderr
}

PUBLISHER_REPO=""
# setup publisher
if [ -n "${INPUT_PERSONAL_TOKEN}" ]; then
    print_info "Using provided PERSONAL_TOKEN"
    PUBLISHER_REPO="https://x-access-token:${INPUT_PERSONAL_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
elif [ -n "${INPUT_GITHUB_TOKEN}" ]; then
    print_info "Using automatic GITHUB_TOKEN"
    PUBLISHER_REPO="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
else
    print_error "No PERSONAL_TOKEN or GITHUB_TOKEN found, you can provide one in your workflow YAML"
    exit 1
fi

# config git
git config --local user.name "${GITHUB_ACTOR}"
git config --local user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# install gitbook
print_info "Installing gitbook-cli"
npm install gitbook-cli  -g

print_info "Installing gitbook plugins"
gitbook --version
gitbook install

# build gitbook
print_info "Buildling gitbook"
gitbook build

# checkout gh-pages branch
set +e
git checkout gh-pages || git checkout -b gh-pages
git fetch origin && git reset origin/gh-pages
git status
set -e

# copy the static site files into the current directory
cp -R _book/* .

# remove 'node_modules' and '_book' directory
print_info "Cleaning artifacts"
git clean -fx node_modules
git clean -fx _book

# add all files
git add .

# commit
COMMIT_MESSAGE="Update gitbook `date '+%Y-%m-%d %H:%M:%S'`"
git commit -a -m "${COMMIT_MESSAGE}"

git remote add publisher ${PUBLISHER_REPO}

# push to the publisher
print_info "Pushing to gh-pages branch"
git push -u publisher gh-pages
