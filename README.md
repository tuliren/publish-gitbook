# Gitbook Publish Action

This action publishes a gitbook to github pages.

The source branch is `master`, and the target branch is `gh-pages`. If `gh-pages` does not exist, it will be created automatically.

## How to Use
```yml
uses: tuliren/publish-gitbook@v1
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
```
