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

## Room log analysis (toy-e2-run1.json, full scope, 523 events)
- Wall time 21:06→21:33 UTC = **27 min**. 17 text messages: coordinator 10, engineer 4, verifier 2, analyst 1.
- Work distribution by tool calls: analyst 66, engineer 64, verifier 39, coordinator 28 → well distributed. ✅
- Mention edges both directions: coordinator⇄engineer, coordinator⇄verifier, engineer⇄verifier, analyst→coordinator. Gate 2 ✅
- Skills used: analyst requirements-extraction + spec-to-tests; engineer concurrency-safety + offline-container;
  verifier verify-gate. (ui-states and stage-advance not needed yet.) ✅
- No permission denials. 6 tool errors, all self-recovered: engineer tried pip install on host Python 3.14
  (pydantic-core wheel build fails) before relying on Docker; stale `git rm` pathspec; verifier Read on a dir;
  coordinator's first message without a mention was rejected by Band CLI.
- Reject loop: **did not trigger** (verifier ACCEPT first time). Fine per rules; real tracks will exercise it.
- `harness check` on toy-e2 with room.json: only README.md + FACTORY.md missing → gates 1, 2, 4 pass. ✅
- Coordinator mentioned the human twice (ack + final report).

## Improvements queued (apply after toy stage 2)
- Coordinator: address the human only in the final report.
- Engineer: note that host Python may differ from the container's; verify inside the container image.
