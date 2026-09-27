# Risk register

| # | Risk | Impact | Likelihood | Mitigation | Status |
|---|---|---|---|---|---|
| R1 | Pro usage quota runs out mid judged run; a stalled seat needing a nudge = steering/rerun | Lose Teamwork score or entry | High | Measure usage per stage in P3; dispatch stages separately right after a reset; fallback Max/API for P4 (decide by Oct 1) | open |
| R2 | Hidden tests: 59% (s2), 89% (s3), 79% (s4) of checks held back | Stages don't count despite green local run | High | Analyst writes spec-derived tests + checklist; verifier audits every checklist line | open |
| R3 | Mandate names track vocabulary | Disqualification (gate 4) | Medium | `scripts/vocab-lint.sh` on every edit; avoid identifier-shaped tokens entirely | open |
| R4 | Code written to the tests | Disqualification | Medium | Dispatch says "build to the spec"; verifier checks against spec, not just test output | open |
| R5 | Stage chain breaks (stage-N breaks N-1, or overshoots N+1) | Caps score | Medium | Verifier runs full `--stage N` (includes overshoot probe) each stage; `--all` before submit | open |
| R6 | Service needs network at runtime / exceeds 2 vCPU·2 GiB | Stage scores zero | Medium | Dispatch mandates offline single-container build; verifier uses `--mode isolated` | open |
| R7 | Credentials leak into public repo or `room.json` | Security + cleanup cost | Low | Keys never in band-work; `harness check` credential scan; read room.json before push | open |
| R8 | Seats ask the human questions during judged run | Autonomy score loss | Medium | Coordinator mandate: decide from requirements, record blockers, never ask | mitigated: tools denied via settings (D13), verified headless |
| R9 | Stage folder copied with nested `.git` | Folder arrives empty for judges | Low | Coordinator mandate deletes it; fresh-clone check before submit | open |
| R10 | Time: full 4-stage run takes longer than expected | Miss deadline | Medium | Judged run starts Oct 2 with Oct 3 buffer; submit Oct 4 | open |
| R11 | Headless seats stall on tool permission prompts (git, docker, file edits) during an unattended run | Autonomy loss / stall | Medium | Learn Band Desktop seat permission settings in toy run; consider Docker Sandbox per guide | open |
| R12 | Seats don't load project skills from `.claude/skills` in headless mode | Skills unused | Medium | Verify in toy run (look for skill use in room tool calls); fallback: inline key steps into mandates | closed: headless seat in run repo lists all 7 project skills |
