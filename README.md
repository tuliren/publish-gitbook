# Gitbook Publish Action

![Build Status](https://github.com/tuliren/publish-gitbook/workflows/build/badge.svg)

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
        uses: tuliren/publish-gitbook@v1.0.0
        with:
          # specify either github_token or personal_token
          # github_token: ${{ secrets.GITHUB_TOKEN }}
          personal_token: ${{ secrets.PERSONAL_TOKEN }}
```

Please note that either `personal_token` or `github_token` needs to be specified.

### `github_token`

If you choose `github_token`, this token is auto created when workflow launches. No extra operation is needed.

Unfortunately this auto token cannot trigger a GitHub Pages build. So the current workaround is to generate a new Personal Access Token and supply it separately as `personal_token`.

More details can be found here:
- [Github action not triggering gh-pages upon push](https://github.community/t5/GitHub-Actions/Github-action-not-triggering-gh-pages-upon-push/td-p/26869)
- [Cannot deploy with GITHUB_TOKEN for new repository](https://github.com/peaceiris/actions-gh-pages/issues/9)

### `personal_token` (recommended)

- Create a Personal Access Token ([instruction](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token)).
- Add the token as a repo secret ([instruction](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#creating-encrypted-secrets)).
  - Secret name: `PERSONAL_TOKEN`
  - Secret value: <token>
