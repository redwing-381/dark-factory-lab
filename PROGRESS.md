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
