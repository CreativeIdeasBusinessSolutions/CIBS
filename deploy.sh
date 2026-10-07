#!/usr/bin/env bash
# Usage: ./deploy.sh cibs-website     (needs git and GitHub CLI: gh auth login)
set -e
NAME="${1:-cibs-website}"
git init -b main
git add .
git commit -m "CIBS website"
gh repo create "$NAME" --public --source=. --push
gh api -X POST "repos/$(gh api user -q .login)/$NAME/pages" -f "source[branch]=main" -f "source[path]=/"
echo "Live soon at: https://$(gh api user -q .login).github.io/$NAME/"
