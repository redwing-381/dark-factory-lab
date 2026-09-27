#!/usr/bin/env bash
# Usage: scripts/vocab-lint.sh [mandates-dir] [track]
set -euo pipefail
here="$(cd "$(dirname "$0")/.." && pwd)"
dir="$(cd "${1:-$here/mandates}" && pwd)"
. "$HOME/dark-factory/dark-factory-wearedevs/.venv/bin/activate"
python "$here/scripts/vocab-lint.py" "$dir" "${2:-tablekeeper}"
