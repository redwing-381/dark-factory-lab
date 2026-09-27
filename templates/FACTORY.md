# FACTORY.md — <factory name>

> Goal of this file: another team can stand this factory up from here and `mandates/` alone,
> and point it at a different problem.

## 1. The band
| Seat | Harness | Model | Owns | Never does |
|---|---|---|---|---|
| coordinator | Claude Code | | | |
| analyst | Claude Code | | | |
| engineer | Claude Code | | | |
| verifier | Claude Code | | | |

## 2. Setup (step by step)
1. Band Desktop version, how each seat is created (New local agent, runtime, working dir).
2. Where each mandate is loaded.
3. Git identity per seat.
4. The one task message per stage (template in section 4).

## 3. Workflow and handoffs
Diagram + the handoff and verdict formats. Who talks to whom, and deliberate omissions.

## 4. Dispatching a job
The generic shape of the task the human pastes (what to include: requirements, repo path, checks, constraints).

## 5. Design choices and why
| Choice | Why | Alternative tried | Result |
|---|---|---|---|

## 6. How the factory catches and recovers from bad work
Concrete examples from our runs: what was wrong, which seat caught it, how it came back through the room.

## 7. What we tried that failed

## 8. Measured cost and time
| Run | Stage | Wall time | Usage (Pro %) / tokens | Rework loops | Result |
|---|---|---|---|---|---|

## 9. Limitations
