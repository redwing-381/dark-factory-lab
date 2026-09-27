#!/usr/bin/env bash
# Harness run wrapper with auto-numbered output dirs.
# Usage: scripts/check.sh <repo> <stage|all> [track=tablekeeper] [isolated]
set -euo pipefail
KIT="$HOME/dark-factory/dark-factory-wearedevs"
CHECKS="$HOME/dark-factory/band-work/checks"
repo="$(cd "${1:?repo path}" && pwd)"; stage="${2:?stage number or all}"
track="${3:-tablekeeper}"; mode="${4:-host}"

name="${track}-s${stage}-${mode}-$(date +%m%d-%H%M%S)"
args=(run --track "$track" --repo "$repo" --out "$CHECKS/$name")
[[ "$stage" == all ]] && args+=(--all) || args+=(--stage "$stage")
[[ "$mode" == isolated ]] && args+=(--mode isolated)

cd "$KIT" && . .venv/bin/activate
python -m harness "${args[@]}"
echo "--- test counts per suite:"
grep -hE "[0-9]+ (passed|failed)" "$CHECKS/$name"/*.log 2>/dev/null || true
