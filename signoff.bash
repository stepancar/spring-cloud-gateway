#!/bin/bash

set -e

COMMITS=(
  "0e83625"
  "8972156"
  "7e3b3b8"
  "d185415"
  "0bfdaf6"
  "f190628"
  "9c05580"
)

echo "🔁 Creating backup branch 'before-signoff'..."
git branch before-signoff

for commit in "${COMMITS[@]}"; do
  echo "👉 Processing $commit..."

  git rebase --onto "$commit^" "$commit" &&
  GIT_COMMITTER_NAME="$(git show -s --format='%an' "$commit")" \
  GIT_COMMITTER_EMAIL="$(git show -s --format='%ae' "$commit")" \
  git commit --amend --no-edit --signoff &&
  echo "✅ Signed-off added to $commit"
done

echo "🎉 Done! All selected commits now include Signed-off-by."