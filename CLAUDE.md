# dark-factory-lab — operator workshop

This repo is the **operator's workshop** for the WeAreDevelopers × BAND "Dark Factory" hackathon
(track: **tablekeeper**, solo, Claude Pro, deadline **Mon Oct 5 2026, 23:59 PDT**).
It is NOT the submission repo and it is NOT read by the factory's seats.

## Start of every session
1. Read `PLAN.md` (single source of truth: phases, seat design, rules).
2. Read the latest entries in `PROGRESS.md`, then `DECISIONS.md` and `RISKS.md`.
3. Continue from the "Next" line of the last PROGRESS entry.

## End of every session
Append a dated entry to `PROGRESS.md` (done / result / usage / next). Record any new decision in
`DECISIONS.md`. Tick finished items in `PLAN.md` section 3. Commit.

## Paths (absolute)
| Path | What |
|---|---|
| `~/dark-factory/dark-factory-wearedevs` | organizers' kit — specs, harness, toy. Read-only. |
| `~/dark-factory/dark-factory-wearedevs/.venv` | Python venv with the harness + Playwright |
| `~/dark-factory/band-work/result` | submission repo the seats build (judged run only) |
| `~/dark-factory/band-work/toy-result` | toy practice repo |
| `~/dark-factory/band-work/checks` | harness output dirs (each run needs a new name) |
| `~/dark-factory/dark-factory-lab` | this workshop |

**Never put a CLAUDE.md in `~/dark-factory/` or `~/dark-factory/band-work/`.** Seats run under
`band-work/`; Claude Code would load a parent CLAUDE.md into every seat and contaminate the factory.

## Commands
```sh
scripts/check.sh <repo> <stage|all> [track] [isolated]   # harness run wrapper, auto-numbered --out
scripts/vocab-lint.sh [mandates-dir]                     # gate 1 + gate 4 mandate scan, plus stricter shape scan
scripts/fresh-clone-check.sh <git-url>                   # pre-submit: clone fresh, harness check + run --all isolated
```

## Hard rules (disqualification-level)
- The human (and this workshop Claude) never edits code under `band-work/result/stage-*`. Only seats write product code.
- Mandates are generic: no endpoint paths, snake_case / kebab-case identifiers, error codes, test ids. Track detail and
  stack choices go in `dispatch/`, never in `mandates/`. Run `scripts/vocab-lint.sh` after every mandate edit.
- Every mandate starts with `Harness: Claude Code` and `Model: <exact model id>`. File name = seat name.
- Judged run: fresh room + fresh result repo; one dispatch per stage; no messages between dispatches
  ("continue" is steering, a repeat dispatch is a rerun).
- Build to the spec, not to the shipped tests (only part of each suite ships).
- Never amend/rebase/squash band history. Stage folders never contain `.git`.
- Final checks run `--mode isolated`. No credentials in any repo or in `room.json`.
- Changes to the factory are made in mandates/dispatch/templates, never by fixing product code by hand.
