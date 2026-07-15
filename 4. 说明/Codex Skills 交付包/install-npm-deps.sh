#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQ_FILE="$SCRIPT_DIR/npm-global-requirements.txt"

if ! command -v npm >/dev/null 2>&1; then
  cat >&2 <<'EOF'
npm was not found.

Install Node.js/npm first, then rerun this script.
See:
  Intel Mac 环境准备.md

Recommended options:
  1. Install Node.js LTS from https://nodejs.org/
  2. Or install Homebrew, then run: brew install node
EOF
  exit 1
fi

if [[ ! -f "$REQ_FILE" ]]; then
  echo "Missing npm requirements file: $REQ_FILE" >&2
  exit 1
fi

packages=()
while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
  line="${raw_line%%#*}"
  line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -z "$line" ]] && continue
  packages+=("$line")
done < "$REQ_FILE"

if [[ "${#packages[@]}" -eq 0 ]]; then
  echo "No npm packages listed in $REQ_FILE"
  exit 0
fi

echo "Using npm: $(command -v npm)"
npm --version
echo
echo "Installing global npm packages:"
printf '  %s\n' "${packages[@]}"
echo

npm install -g "${packages[@]}"

echo
echo "Done. Installed npm global packages:"
printf '  %s\n' "${packages[@]}"
