#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [[ $# -lt 2 ]]; then
  echo 'Usage: npm run publish:post -- <slug> "<commit message>" [related file ...]'
  exit 1
fi

slug=$1
message=$2
shift 2
if [[ ! $slug =~ ^[a-z0-9]+(-[a-z0-9]+)*$ || -z $message ]]; then
  echo 'Provide a lowercase, hyphenated slug and a nonempty commit message.'
  exit 1
fi
post="src/content/posts/$slug.md"
files=("$post" "$@")
for file in "${files[@]}"; do
  if [[ ! -f $file || $file == /* || $file == *../* ]]; then
    echo "Expected a repository-relative file: $file"
    exit 1
  fi
done
if [[ $(git branch --show-current) != main ]]; then
  echo 'Run this script on main.'
  exit 1
fi
if ! git diff --cached --quiet; then
  echo 'The staging area already contains changes. Commit or unstage them first.'
  exit 1
fi

echo "Post: $post"
if rg -q '^draft: *true *$' "$post"; then
  echo 'This post is a draft. It will be pushed but will not appear on the public site.'
fi
npm run build
echo 'Files selected for this commit:'
printf '  %s\n' "${files[@]}"
git status --short -- "${files[@]}"
echo 'Existing commits waiting to be pushed (based on the local origin/main ref):'
git log --oneline origin/main..HEAD
read -r -p 'Stage these files, commit, and push main? [y/N] ' answer
if [[ $answer != y && $answer != Y ]]; then
  echo 'Cancelled.'
  exit 0
fi

git add -- "${files[@]}"
if git diff --cached --quiet; then
  echo 'No new changes to commit. Pushing existing commits.'
else
  git diff --cached --stat
  git commit -m "$message"
fi
echo 'Pushing main. Git may ask for your GitHub username and token in this terminal.'
if ! git push origin main; then
  echo 'Push failed. Your local commit is preserved. Resolve authentication or remote changes, then run: git push origin main'
  exit 1
fi
git status --short --branch
echo 'Push completed. Check GitHub Actions for the deployment result.'
