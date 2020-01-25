# Gitbook Publish Action

This action publishes a gitbook to github pages.

The source branch is `master`, and the target branch is `gh-pages`. If `gh-pages` does not exist, it will be created automatically.

## How to Use

```yml
jobs:
  build:
    name: Build Gitbook
    runs-on: ubuntu-latest
    steps:
      # We must check out the repo first
      - name: Checkout
        uses: actions/checkout@v2
      # Now run this publish action
      - name: Publish
        uses: tuliren/publish-gitbook@v0.9.1
        with:
          personal_token: ${{ secrets.PERSONAL_TOKEN }}
```

## Gotcha

Unfortunately auto `GITHUB_TOKEN` in workflows cannot trigger a GitHub Pages build. So the current workaround is to generate a new Personal Access Token and supply it separately as `personal_token`.

More details can be found here:
- [Github action not triggering gh-pages upon push](https://github.community/t5/GitHub-Actions/Github-action-not-triggering-gh-pages-upon-push/td-p/26869)
- [Cannot deploy with GITHUB_TOKEN for new repository](https://github.com/peaceiris/actions-gh-pages/issues/9)
