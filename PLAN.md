# Dark Factory hackathon — master plan & persistent dev environment

## Context
Hackathon: WeAreDevelopers × BAND "Dark Factory" (lablab.ai). Deadline **Mon Oct 5, 23:59 PDT** (~8 days from Sep 28).
We build a *factory* — a band of ≥3 Claude Code seats in BAND Desktop with generic mandates — that autonomously builds the
**tablekeeper** track (OpenTable clone, 4 cumulative stages). Judged: Factory 50% · App 25% · Agent Teamwork 25%, behind 4 gates.
The user wants one plan that every future session follows, stored in a stable place, so development is consistent and resumable.

Decisions made: track **tablekeeper** · models via **Claude Pro subscription** · plan lives in **PLAN.md in a private workshop repo** · **solo**.

Already done (verified): Claude Code 2.1.283, BAND Desktop + `band` 0.4.12 + band-peer plugin, Docker running,
`~/dark-factory/dark-factory-wearedevs` cloned with `.venv` (harness + Playwright chromium), `band-work/{result,toy-result,checks}`
created, toy baseline check ran (2 passed / 6 failed as expected).

## 1. What gets created now (Phase 0 execution)

Workshop repo **`~/dark-factory/dark-factory-lab`** (private GitHub repo `dark-factory-lab`):
```
dark-factory-lab/
  CLAUDE.md            session bootstrap: "read PLAN.md + PROGRESS.md first", paths, commands, hard rules
  PLAN.md              this plan (phases, checklists, seat design, rules) — the single source of truth
  PROGRESS.md          dated log: what ran, result, cost/usage, next action (appended every session)
  DECISIONS.md         ADR-style log: decision, reason, date (e.g. "4 seats on Pro")
  RISKS.md             live risk register (Pro quota, hidden tests, mandate vocab)
  mandates/            generic mandate drafts: coordinator.md, analyst.md, engineer.md, verifier.md
  dispatch/            task texts pasted into the room: toy.md, stage-1..4.md (track detail lives HERE, never in mandates)
  templates/           handoff-template.md, FACTORY.md skeleton, README skeleton, RUN.md skeleton
  experiments/         one file per run: config, seats, model, duration, usage %, harness output, failure modes, fix applied
  scripts/             check.sh (harness run wrappers), vocab-lint.sh (runs harness mandate scan on drafts), fresh-clone-check.sh
```
**Critical layout rule:** no CLAUDE.md at `~/dark-factory/` root. Seats work in `~/dark-factory/band-work/...`; Claude Code loads
parent-directory CLAUDE.md files, which would leak operator/track instructions into the seats and break "mandates are the only
standing instructions". The CLAUDE.md lives only inside `dark-factory-lab/`, which is a sibling of `band-work/`, never a parent.

Steps:
1. `brew install gh` → user runs `gh auth login` once (interactive).
2. Create the folder structure + files above; PLAN.md = this document; seed PROGRESS/DECISIONS/RISKS.
3. `git init`, first commit, `gh repo create dark-factory-lab --private --source . --push` (confirm with user before creating).
4. Every later session: open in `~/dark-factory/dark-factory-lab`, read PLAN.md + PROGRESS.md, append to PROGRESS.md at the end.

## 2. Factory design (v1, sized for Claude Pro)
Pro = one shared usage quota across all seats, 5-hour windows. Seat count barely changes token use (seats idle between turns);
what burns quota is context duplication in handoffs and rework loops. So: **4 seats, all `claude-sonnet-5`**, sequential flow.

| Seat | Owns | Never does |
|---|---|---|
| **coordinator** | reads task, plans, splits into scoped work items, pastes full requirements into every handoff, advances stages (copy folder forward, delete nested `.git`), final report; decides instead of asking human | writes code |
| **analyst** | turns the given spec into a numbered requirements checklist + independent acceptance tests derived from the spec (targets the hidden tests: only 11–21% shipped at stages 3–4) | implements features |
| **engineer** | implements one work item at a time (API, data, concurrency, UI), commits under own author name, posts commit hash + evidence | approves own work |
| **verifier** | independently runs the check command from the task in isolated mode + analyst tests + audits checklist line by line; rejects with specific failing items; approves only on evidence | edits product code |

Flow: human task → @coordinator → @analyst (checklist+tests) → @coordinator splits → @engineer ⇄ @verifier (reject loop) →
@coordinator marks stage done → next stage. Every handoff uses `templates/handoff-template.md` (task, full requirements,
absolute repo path, check command, acceptance criteria, expected evidence).
Experiment E3 (if quota allows): 5 seats, split engineer → backend-engineer / frontend-engineer for stage 2 UI quality.

Mandate rules (gate 4): start with `Harness: Claude Code` / `Model: claude-sonnet-5`; describe *how the seat works* only; no
endpoints, snake_case field names, kebab-case test ids, error codes (harness `vocabulary.py` regex-scans identifier shapes —
avoid any `/path`, `snake_case`, `kebab-case` tokens entirely). File name = seat name as shown in room.
Track detail + stack choice go in `dispatch/stage-N.md` (e.g. single container, Python 3.12, SQLite with serialized writes,
server-served UI, no runtime network, 2 vCPU/2 GiB).

## 3. Phases & calendar (tick in PLAN.md, log in PROGRESS.md)
- [x] **P0 Sep 28** — workshop repo + environment (section 1). Pushed to private github.com/redwing-381/dark-factory-lab.
- [x] **P1 Sep 28** — 4 generic mandates, 7 generic skills (`skills/`, D7), handoff template, job template + `make-dispatch.sh`, `new-run.sh`; `vocab-lint.sh` clean vs both tracks.
- [ ] **P2 Sep 29** — toy rehearsal: E2 = our 4 seats in run `toy-e2` (E1 with sample mandates skipped to save Pro quota, D11). Full loop incl. room.json download +
  `harness check` on toy-result. Measure duration + Pro usage %.
- [ ] **P3 Sep 30–Oct 1** — tablekeeper practice runs, stage 1 → 4 (human may intervene). After each run: log failure modes in
  experiments/, fix *mandates/dispatch only*, never code. Measure usage per stage to schedule the judged run.
- [ ] **P4 Oct 2–3** — judged run: fresh room + fresh `band-work/result` repo, one dispatch per stage, zero human input between;
  dispatch each stage right after a quota reset; screen-record for video. Day 2 = retry buffer.
- [ ] **P5 Oct 4** — write FACTORY.md (seats, design rationale, what failed, measured time/usage, how bad work is caught), README,
  room.json, video (must include room recording), slides; push public submission repo; submit on lablab. **Oct 5 = spare.**

## 4. Hard rules (copied into CLAUDE.md)
- Human never edits `band-work/result/stage-*`; no amend/rebase/squash of band history.
- Judged run: no messages between dispatches ("continue" = steering, re-dispatch = rerun).
- Final checks always `--mode isolated`; `claimed stage: N` required per folder; chain must be contiguous.
- Build to the spec, not the shipped tests. No credentials anywhere in the repo or room.json.
- Stage folders never contain `.git`.

## 5. Key risks
| Risk | Mitigation |
|---|---|
| Pro quota runs out mid judged run (stall = possible steering/rerun) | measure per-stage usage in P3; dispatch stages separately after resets; fallback: temporary Max upgrade or API key for P4 only (decide by Oct 1) |
| Hidden tests (89% of stage-3 held back) | analyst seat writes spec-derived tests; verifier audits checklist |
| Mandate vocab DQ | vocab-lint.sh on every mandate edit + `harness check` |
| Stage folder chain breaks | verifier runs full `--stage N` each stage; `--all` before submit |

## 6. Verification
- P0: `gh repo view dark-factory-lab` shows private repo; new Claude session opened in `dark-factory-lab` picks up CLAUDE.md.
- P1: `scripts/vocab-lint.sh` → no hits (uses `harness.vocabulary.terms_in` against `TRACK_VOCABULARY['tablekeeper']`).
- P2: `python -m harness check ../band-work/toy-result --track toy` → ok; `harness run --track toy --stage 4` → claimed stage 4.
- P4/P5: fresh clone of submission repo → `harness check --track tablekeeper` ok + `harness run --all --mode isolated`.

Critical existing files: `~/dark-factory/dark-factory-wearedevs/docs/participant-guide.md` (authoritative rules),
`tablekeeper/spec/stage-{1..4}.md`, `harness/vocabulary.py`, `harness/check.py`, `toy/mandates/*.md` (starting templates).
