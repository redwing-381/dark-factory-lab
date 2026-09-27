#!/usr/bin/env bash
# Pre-submit check against a FRESH clone (catches uncommitted files and nested .git folders).
# Usage: scripts/fresh-clone-check.sh <git-url> [track=tablekeeper]
set -euo pipefail
url="${1:?git url}"; track="${2:-tablekeeper}"
KIT="$HOME/dark-factory/dark-factory-wearedevs"
dest="$HOME/dark-factory/band-work/fresh-clone-$(date +%m%d-%H%M%S)"
git clone -q "$url" "$dest"
cd "$KIT" && . .venv/bin/activate
echo "=== harness check (gates 1, 2, 4-mandates, credentials)"
python -m harness check "$dest" --track "$track" || true
echo "=== harness run --all --mode isolated (gate 3 + claimed stages)"
python -m harness run --track "$track" --repo "$dest" --all --mode isolated \
  --out "$HOME/dark-factory/band-work/checks/fresh-$(basename "$dest")"
echo "Now also: follow each RUN.md by hand, open the UI, read room.json for secrets."
