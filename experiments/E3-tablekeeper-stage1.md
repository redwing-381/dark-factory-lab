# E3 — tablekeeper stage 1 practice, factory v1.1 (4 seats, claude-sonnet-5)

- **Date:** 2026-09-28 ~21:30 IST dispatch → 2026-09-29 00:40 IST whole-stage ACCEPT
- **Room:** tk-p1-run1 · **Repo:** band-work/tk-p1
- **Usage before:** weekly 16%, session 25% (resets 23:10). **After:** TODO

## Result
- Operator isolated check: **120/120 shipped stage-1 checks**, `claimed stage: 1`, stage-2 probe fails (correct).
- Commits: analyst f5ff2ab (checklist + 11 test files), engineer fa0db57 (WI core, R1–R9), engineer b6d9e95 (export/import +
  atomic reservation moves, R10–R11).

## Incident: session limit hit mid-stage (~22:50 IST)
- 5-hour session limit reached while the verifier was checking fa0db57 (118/120 at that point). All seats stopped.
- After reset, human sent a RESUME message (allowed in practice, would be steering in the judged run).
- **Lesson:** one tablekeeper stage does NOT fit in one Pro 5-hour window as currently designed (~2 h of work hit it,
  starting at 25% session). Judged run must fit each stage in a window or it is disqualifying-level steering.

## Cost reduction ideas to evaluate
- Start each judged stage at 0% session (right after a reset).
- Reduce context: avoid repeated full-spec reads/pastes; analyst writes fewer, sharper tests; verifier runs the
  harness once per work item, not repeatedly.
- Consider 3 seats (merge analyst into verifier) if still too costly.
