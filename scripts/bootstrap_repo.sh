#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="Borisders"
DEFAULT_BRANCH="main"
DEFAULT_REMOTE="https://github.com/Borisder1/Borisders.git"

if ! command -v git >/dev/null 2>&1; then
  echo "[ERROR] git is not installed."
  exit 1
fi

if [ ! -f "README.md" ]; then
  echo "# ${REPO_NAME}" > README.md
  echo "[INFO] README.md created."
fi

if [ ! -d ".git" ]; then
  git init
  echo "[INFO] Git repository initialized."
fi

git add README.md

echo "[INFO] Creating initial commit if needed..."
if git diff --cached --quiet; then
  echo "[INFO] Nothing to commit."
else
  git commit -m "chore: initial repository setup"
fi

git branch -M "${DEFAULT_BRANCH}"

if git remote get-url origin >/dev/null 2>&1; then
  CURRENT_REMOTE="$(git remote get-url origin)"
  echo "[INFO] origin already exists: ${CURRENT_REMOTE}"
else
  git remote add origin "${DEFAULT_REMOTE}"
  echo "[INFO] origin added: ${DEFAULT_REMOTE}"
fi

echo "[DONE] Next step: git push -u origin ${DEFAULT_BRANCH}"
