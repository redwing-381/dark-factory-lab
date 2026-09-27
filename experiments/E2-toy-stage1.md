# E2 — toy stage 1, factory v1 (4 seats, all claude-sonnet-5)

- **Date:** 2026-09-28, dispatched 02:35, verified by ~03:01 (≈26 min wall time)
- **Room:** toy-e2-run1 (fresh, only the job message) · **Repo:** band-work/toy-e2
- **Seats:** coordinator, analyst, engineer, verifier · Auto permission mode · reasoning default
- **Pro usage:** TODO (read claude.ai usage after run)

## Result
- Operator isolated check: stage 1 pass 8/8, `claimed stage: 1 (100% of its own suite)`, stage-2 probe fails (correct).
- Verifier ran the isolated check itself twice before ACCEPT.
- Commits: analyst `5c56927` (checklist + tests), engineer `a7078db` (service). Separate git authors per seat. No human input after dispatch.

## Factory behaviour observed
- Coordinator's first handoff pasted the full spec, paths, constraints, expected evidence. ✅
- Coordinator made and recorded a scope decision (no UI in stage 1). ✅
- Analyst: 32 checklist items, 22 flagged UNVERIFIED, 4 recorded decisions; 29 black-box tests incl. container test. ✅
- Coordinator posted an acknowledgement addressed to the human at start. Harmless (not a question) but noise → consider mandate tweak: address the human only in the final report.
- `__pycache__` left in stage-1 working tree (gitignored, fine).

## Open questions for next run
- Did the reject loop ever trigger? (read room.json)
- How much Pro quota did one small stage use?
