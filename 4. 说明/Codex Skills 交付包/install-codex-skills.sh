#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQ_FILE="$SCRIPT_DIR/skills-requirements.txt"
DEST_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"
REPLACE=0

usage() {
  cat <<'EOF'
Install the vendored Codex skills for this vault.

Usage:
  ./install-codex-skills.sh [--replace]

Options:
  --replace   Back up any existing skill directory, then install this copy.

Destination:
  ${CODEX_HOME:-$HOME/.codex}/skills
EOF
}

for arg in "$@"; do
  case "$arg" in
    --replace)
      REPLACE=1
      ;;
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

mkdir -p "$DEST_ROOT"

installed=0
skipped=0
missing=0
timestamp="$(date +%Y%m%d-%H%M%S)"

while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
  line="${raw_line%%#*}"
  line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"

  [[ -z "$line" ]] && continue
  [[ "$line" == vendor/skills/* ]] || continue

  skill_name="${line##*/}"
  src="$SCRIPT_DIR/$line"
  dest="$DEST_ROOT/$skill_name"

  if [[ ! -d "$src" ]]; then
    echo "Missing vendored skill: $line" >&2
    missing=$((missing + 1))
    continue
  fi

  if [[ -e "$dest" ]]; then
    if [[ "$REPLACE" -eq 1 ]]; then
      backup="$dest.backup-$timestamp"
      mv "$dest" "$backup"
      echo "Backed up existing $skill_name to $backup"
    else
      echo "Skipped existing skill: $skill_name"
      skipped=$((skipped + 1))
      continue
    fi
  fi

  cp -R "$src" "$dest"
  echo "Installed skill: $skill_name"
  installed=$((installed + 1))
done < "$REQ_FILE"

echo
echo "Done. Installed: $installed, skipped: $skipped, missing: $missing"
echo "Destination: $DEST_ROOT"
echo "Restart Codex CLI after installation so it reloads skills."

if [[ "$missing" -gt 0 ]]; then
  exit 1
fi
