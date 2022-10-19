# Gitbook Publish Action

[![Build Status](https://img.shields.io/github/workflow/status/tuliren/publish-gitbook/build?style=for-the-badge)](https://github.com/tuliren/publish-gitbook/actions/workflows/build.yml) [![GitHub Marketplace](https://img.shields.io/badge/github%20marketplace-publish%20gitbook-blue?style=for-the-badge)](https://github.com/marketplace/actions/publish-gitbook)

This action publishes a gitbook to github pages.

The source branch is `master`, and the target branch is `gh-pages`. If `gh-pages` does not exist, it will be created automatically.

## How to Use

```yml
jobs:
  build:
    name: Build Gitbook
    runs-on: ubuntu-latest
    steps:
      # Check out the repo first
      - name: Checkout code
        uses: actions/checkout@v2
      # Run this action to publish gitbook
      - name: Publish
        uses: tuliren/publish-gitbook@v1.0.1
        with:
          # specify either github_token or personal_token
          github_token: ${{ secrets.GITHUB_TOKEN }}
          # personal_token: ${{ secrets.PERSONAL_TOKEN }}
```

Please note that either `personal_token` or `github_token` needs to be specified.

### `github_token` (recommended)

If you choose `github_token`, this token is auto created when workflow launches. No extra operation is needed.

### `personal_token`

- Create a Personal Access Token ([instruction](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token)).
- Add the token as a repo secret ([instruction](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#creating-encrypted-secrets)).
  - Secret name: `PERSONAL_TOKEN`
  - Secret value: `<token>`
