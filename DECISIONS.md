# Decisions

| # | Date | Decision | Why | Revisit if |
|---|---|---|---|---|
| D1 | 2026-09-28 | Track: **tablekeeper** | More shipped checks per stage (83/41/11/21% vs 79/35/9/16%) = more feedback for the factory | — (locked: can't switch tracks) |
| D2 | 2026-09-28 | Models via **Claude Pro** subscription | User's available plan | Practice runs show a full stage exceeds one 5-hour window → consider temporary Max or API key for the judged run (decide by Oct 1) |
| D3 | 2026-09-28 | **4 seats**: coordinator, analyst, engineer, verifier — all `claude-sonnet-5` | Pro quota is shared; seat count matters less than handoff context and rework loops. Analyst targets hidden tests; verifier gives real, blocking review | E3 shows a 5th seat (frontend split) improves stage-2 UI without blowing quota |
| D4 | 2026-09-28 | Two repos: private `dark-factory-lab` (workshop) + fresh public submission repo created for the judged run | Judged run needs a fresh result repo whose history is 100% band-made | — |
| D5 | 2026-09-28 | Workshop lives beside `band-work/`, never above it; no CLAUDE.md in any parent of seat working dirs | Claude Code loads parent CLAUDE.md files into seats, which would contaminate mandates | — |
| D6 | 2026-09-28 | Track detail and stack choice live in `dispatch/`, never in mandates | Gate 4: generic mandates or disqualification | — |
