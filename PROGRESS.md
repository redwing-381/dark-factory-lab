# Progress log

Newest entry at the bottom. Format: **Done / Result / Usage / Next**.

## 2026-09-28 — P0 environment
- **Done:** Claude Code CLI 2.1.283, BAND Desktop + `band` 0.4.12 + band-peer plugin, Docker running.
  Cloned `dark-factory-wearedevs`, venv with harness + Playwright chromium (Python 3.14 works).
  Created `band-work/{result,toy-result,checks}`; toy-result seeded with scaffold + sample mandates.
  Created this workshop repo (CLAUDE.md, PLAN.md, logs, templates, scripts).
- **Result:** toy stage-1 baseline `2 passed, 6 failed` — expected (scaffold only answers health/reset).
  Note: first Docker build timed out only because of the Claude sandbox; pulls work normally.
- **Usage:** n/a
- **Next:** push this repo to private GitHub (needs `gh auth login`), then P1 — write the 4 generic mandates
  + handoff template + dispatch texts, run `scripts/vocab-lint.sh`.

## 2026-09-28 — P1 factory v1 written
- **Done:** `mandates/` coordinator, analyst, engineer, verifier (generic, Harness/Model lines).
  `skills/` requirements-extraction, spec-to-tests, concurrency-safety, offline-container, ui-states,
  verify-gate, stage-advance. `dispatch/job-template.md` + `scripts/make-dispatch.sh` (inlines spec,
  copies to clipboard). `scripts/new-run.sh` (fresh result repo with mandates + `.claude/skills`).
  Lint extended to skills. Decisions D7–D11, risks R11–R12.
- **Result:** vocab-lint: 0 official findings vs tablekeeper and pocketful lists. Run `toy-e2` created
  at `~/dark-factory/band-work/toy-e2` (scaffold in stage-1). Toy stage-1 job message generated.
- **Usage:** n/a
- **Next:** P2 — user creates 4 seats in Band Desktop (working dir = toy-e2, mandate text as
  instructions), one room, paste `dispatch/out/toy-e2-stage-1.md`. Observe: skills loaded? permission
  prompts? handoffs complete? Then stages 2–4, room.json download, `harness check`.

## 2026-09-28 — P2 toy stage 1 (E2)
- **Done:** 4 seats created in Band Desktop (Claude Code, sonnet, Auto permissions, working dir toy-e2,
  mandate as Role file). Fresh room toy-e2-run1, single job message.
- **Result:** stage 1 accepted by verifier; operator isolated check 8/8, claimed stage 1. ~26 min. See
  experiments/E2-toy-stage1.md.
- **Usage:** TODO
- **Next:** download room.json → inspect handoffs/reject loop; note Pro usage %; dispatch toy stage 2
  (`scripts/make-dispatch.sh toy 2 toy-e2`) in the same room.

## 2026-09-28 — P2 toy stage 2 + factory v1.1
- **Done:** toy stage 2 in the same room (37 min). Mandates v1.1: coordinator mention discipline + human only in
  final report; engineer must invoke matching skills (ui-states) and judge inside the image.
- **Result:** operator isolated --all: stage 1 and 2 both claim 100%. Verifier caught a real test bug → fixed via room.
- **Usage:** 04:05 IST — session 11% (resets 08:40), **weekly 99%** (resets 10:30). Weekly cap is the binding limit; operator Opus chat shares it.
- **Next (after 10:30 IST weekly reset, D15):** user updates Role of coordinator + engineer; note weekly %; tablekeeper stage-1 practice (skip toy stage 3)
  (concurrency) to validate v1.1; then tablekeeper stage-1 practice run.

## 2026-09-29 — P3 tablekeeper stage 1 practice (E3)
- **Done:** tk-p1 run, 4 seats v1.1. Session limit hit mid-stage; human RESUME after reset.
- **Result:** 120/120 shipped stage-1 checks, claimed stage 1 (isolated). See experiments/E3-tablekeeper-stage1.md.
- **Usage:** weekly 16%→30% (14% per stage 1); ≈1.25 five-hour windows. Weekly budget ≈ 9 windows.
- **Next:** get weekly % → compute per-stage cost → redesign for Pro (fit a stage in one 5-hour window).

## 2026-10-01 — P3 tablekeeper stage 2 practice (in progress)
- **Done:** stage 2 dispatched Sep 29 ~02:15 IST in tk-p1-run1. Coordinator advanced stage-1→stage-2 (5128e6d);
  analyst checklist 49 KB + 8 UI test files (c578c56), fixed stale hard-coded dates (68a0575). Usage limit hit before
  the engineer started. RESUME sent Oct 1 ~04:35 IST.
- **Factory fix:** spec-to-tests skill — never hard-code calendar dates that drift into the past (workshop copy only).
- **Next:** wait for final report → operator isolated check + open UI in browser, screenshot, judge App quality.

## 2026-10-01 — P3 tablekeeper stage 2 practice done (E4)
- **Result:** stage-2 claims stage 2 (25/25 + 120/120), stage-1 intact. Manual UI review found 5 UX flaws.
- **Factory fix:** ui-states skill "Flow rules"; spec-to-tests no drifting dates; R13 restart rule.
- **Next:** judged run (fresh repo `result`, fresh room) per D15 — stages 1–2 Oct 3–4, stages 3–4 from Oct 5 10:30 IST.
