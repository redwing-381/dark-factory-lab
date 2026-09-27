#!/usr/bin/env bash
# Create a fresh result repository for one factory run and install the factory into it.
# Usage: scripts/new-run.sh <run-name> [--with-scaffold]
#   e.g. scripts/new-run.sh toy-e2 --with-scaffold ; scripts/new-run.sh tk-p1 ; scripts/new-run.sh result
# Creates ~/dark-factory/band-work/<run-name> with:
#   mandates/         copied from the workshop (one per seat)
#   .claude/skills/   copied from the workshop (seats load project skills from their working dir)
#   stage-1/          empty (or the organizers' scaffold with --with-scaffold, toy only)
set -euo pipefail
LAB="$(cd "$(dirname "$0")/.." && pwd)"
WORK="$HOME/dark-factory/band-work"
run="${1:?run name}"; dest="$WORK/$run"

if [[ -e "$dest" && -n "$(ls -A "$dest" 2>/dev/null)" ]]; then
  echo "refusing: $dest exists and is not empty (judged runs need a fresh repo)"; exit 1
fi
"$LAB/scripts/vocab-lint.sh" "$LAB/mandates" tablekeeper >/dev/null || {
  echo "refusing: mandates/skills fail the official vocabulary scan"; exit 1; }

mkdir -p "$dest/stage-1" "$dest/.claude/skills" "$dest/mandates"
cp "$LAB"/mandates/*.md "$dest/mandates/"
cp -R "$LAB"/skills/* "$dest/.claude/skills/"
[[ "${2:-}" == --with-scaffold ]] && cp "$HOME/dark-factory/dark-factory-wearedevs/scaffold/"* "$dest/stage-1/"
touch "$dest/stage-1/.gitkeep"
printf '__pycache__/\n*.pyc\n.venv/\n.pytest_cache/\n*.db\n.env\n' > "$dest/.gitignore"

git -C "$dest" init -q -b main
git -C "$dest" add -A
git -C "$dest" commit -q -m "Factory setup: mandates and skills (human operator)"
echo "ready: $dest"
echo "seat working directory (use in Band Desktop for every seat): $dest"
git -C "$dest" log --oneline
