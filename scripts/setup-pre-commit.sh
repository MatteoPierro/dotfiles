#!/usr/bin/env bash

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

if ! command -v brew >/dev/null 2>&1 && [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v pre-commit >/dev/null 2>&1; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is required to install pre-commit." >&2
    echo "Install it from https://brew.sh, then run this script again." >&2
    exit 1
  fi

  brew install pre-commit
fi

pre-commit validate-config .pre-commit-config.yaml
pre-commit install-hooks

local_hooks_path="$(git config --local --get core.hooksPath || true)"
if [[ -n "$local_hooks_path" && "$local_hooks_path" != ".githooks" ]]; then
  echo "Error: this repository already uses core.hooksPath=$local_hooks_path" >&2
  exit 1
fi

git config --local core.hooksPath .githooks

echo "Betterleaks pre-commit hook installed."