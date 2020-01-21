# Gitbook Publish Action

This action publishes a gitbook to github pages.

The source branch is `master`, and the target branch is `gh-pages`. If `gh-pages` does not exist, it will be created automatically.

## How to Use
```yml
uses: tuliren/publish-gitbook@v1
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Gotcha
Unfortunately auto `GITHUB_TOKEN` in workflows cannot trigger a GitHub Pages build. So this action is currently useless. More details can be found here:
- [Github action not triggering gh-pages upon push](https://github.community/t5/GitHub-Actions/Github-action-not-triggering-gh-pages-upon-push/td-p/26869)
- [Cannot deploy with GITHUB_TOKEN for new repository](https://github.com/peaceiris/actions-gh-pages/issues/9)
