#!/usr/bin/env bash
# Build the one job message for a stage (track detail lives here, never in mandates) and copy it
# to the clipboard, ready to paste into the room addressed to @coordinator.
# Usage: scripts/make-dispatch.sh <track> <stage> <run-name>
#   e.g. scripts/make-dispatch.sh toy 1 toy-e2 ; scripts/make-dispatch.sh tablekeeper 1 tk-p1
set -euo pipefail
LAB="$(cd "$(dirname "$0")/.." && pwd)"
KIT="$HOME/dark-factory/dark-factory-wearedevs"
track="${1:?track}"; stage="${2:?stage}"; run="${3:?run name}"
repo="$HOME/dark-factory/band-work/$run"
spec="$KIT/$track/spec/stage-$stage.md"
[[ -f "$spec" ]] || { echo "no spec: $spec"; exit 1; }
[[ -d "$repo/.git" ]] || { echo "no result repo: $repo (run scripts/new-run.sh $run)"; exit 1; }

out="$LAB/dispatch/out/$run-stage-$stage.md"; mkdir -p "$(dirname "$out")"
prev=$((stage - 1))
if [[ "$stage" == 1 ]]; then
  starting="- The work folder already exists (it may hold a minimal starter). Build the stage there."
else
  starting="- The work folder does not exist yet. Create it as a copy of the accepted stage-$prev folder
  (stage-advance procedure), then extend the copy. Never edit stage-$prev.
- Carry the stage-$prev checklist and acceptance tests forward and add the new items."
fi
{
  STARTING="$starting" awk '{ if ($0 == "{{STARTING_POINT}}") print ENVIRON["STARTING"]; else print }' "$LAB/dispatch/job-template.md" |
  sed -e "s|{{TRACK}}|$track|g" -e "s|{{STAGE}}|$stage|g" -e "s|{{PREV}}|$prev|g" \
      -e "s|{{REPO}}|$repo|g" -e "s|{{KIT}}|$KIT|g" -e "s|{{SPEC}}|$spec|g" \
      -e "s|{{CHECKS}}|$HOME/dark-factory/band-work/checks|g"
  echo
  echo "===== BEGIN COMPLETE REQUIREMENTS: $track stage $stage ====="
  cat "$spec"
  echo "===== END COMPLETE REQUIREMENTS ====="
} > "$out"
pbcopy < "$out"
echo "written: $out ($(wc -c < "$out") bytes) — copied to clipboard"
