#!/bin/bash
#
# Open the Github pull request detail page for the current branch
# Inspired from http://codeinthehole.com/tips/open-github-pull-request-command/
#
# Requires:
#
# - A GITHUB_AUTH_TOKEN env var
# - httpie and jq.

GITHUB_ORG=$(git config --get remote.origin.url | awk -F/ '{print $4}')
GITHUB_REPO=$(basename -s .git `git config --get remote.origin.url`)
BRANCH=$(git rev-parse --abbrev-ref HEAD)

fetch_pr_detail_url() {
    http https://api.github.com/repos/$GITHUB_ORG/$GITHUB_REPO/pulls \
        head=="$GITHUB_ORG:$BRANCH" \
        Authorization:"token $GITHUB_AUTH_TOKEN" | jq -r '.[].html_url'
}

main() {
    if [ -z "$GITHUB_AUTH_TOKEN" ]; then
        echo "A GITHUB_AUTH_TOKEN env var is required"
        exit 1
    fi

    GITHUB_PULL_URL=$(fetch_pr_detail_url)

    if [ -z "$GITHUB_PULL_URL" ]; then
        echo "No pull request found from branch $BRANCH"
        exit 1
    else
        open "$GITHUB_PULL_URL"
    fi
}

main
