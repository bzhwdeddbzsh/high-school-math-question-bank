#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQ_FILE="$SCRIPT_DIR/skills-requirements.txt"

usage() {
  cat <<'EOF'
Install the Codex skills for this vault.

Usage:
  ./install-codex-skills.sh

Destination:
  ${CODEX_HOME:-$HOME/.codex}/skills

Requirements:
  Node.js/npm, because packages are installed with:
    npx -y skills add <source> -g -y
EOF
}

for arg in "$@"; do
  case "$arg" in
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -f "$REQ_FILE" ]]; then
  echo "Missing requirements file: $REQ_FILE" >&2
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  cat >&2 <<'EOF'
npx was not found.

Install Node.js/npm first, then rerun this script.
See:
  Intel Mac 环境准备.md
EOF
  exit 1
fi

installed=0
failed=0

while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
  line="${raw_line%%#*}"
  line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"

  [[ -z "$line" ]] && continue

  echo "Installing Skill Hub package: $line"
  if npx -y skills add "$line" -g -y; then
    installed=$((installed + 1))
  else
    echo "Failed to install Skill Hub package: $line" >&2
    failed=$((failed + 1))
  fi
done < "$REQ_FILE"

echo
echo "Done."
echo "Skill Hub packages installed: $installed"
echo "Failed: $failed"
echo "Destination: ${CODEX_HOME:-$HOME/.codex}/skills"
echo "Restart Codex CLI after installation so it reloads skills."

if [[ "$failed" -gt 0 ]]; then
  exit 1
fi
