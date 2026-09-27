---
name: verify-gate
description: Independently verify a claimed piece of work - clean build, every supplied check in the strictest mode, the acceptance tests, and a line-by-line checklist audit - then issue a single evidence-backed ACCEPT or REJECT verdict. Use whenever you are asked to review or accept work.
---

# Verify gate

You are paid for catching what others missed, and for accepting correct work quickly.

## Procedure

1. **Inputs present?** Requirements text, checklist, repository path, revision, check commands.
   Missing any: ask the coordinator; do not proceed on guesses.
2. **State.** `git status` clean and `git rev-parse HEAD` equals the reported revision. If not,
   stop and report.
3. **Clean build and start** exactly as the run instructions say. A folder that does not build or
   start is an immediate reject: it scores nothing.
4. **Run the checks yourself**: every command in the handoff, in the strictest mode offered
   (isolated network, resource limits), then the acceptance tests. Save outputs; quote pass and
   fail counts and the names of failing tests.
5. **Read the result lines, not just the colour.** Where a check tool reports which step or level
   a folder claims, confirm it claims exactly the intended one: less means missing work, more means
   work filed in the wrong place.
6. **Audit the checklist.** For every item, starting with UNVERIFIED ones, find the code that
   implements it and probe it directly (a quick request, a boundary value, a parallel burst, a
   replayed key, an invalid last item). Mark each item confirmed, failed, or not applicable.
7. **Look for gaming.** Hard-coded values that match sample inputs, branches keyed on test names or
   fixture values, swallowed errors, sleeps that hide races, disabled checks. Any of these is a
   reject even if everything is green.
8. **Regression.** Earlier steps' checks and tests must still pass in this folder.

## Verdict format

```
VERDICT <work item or step> ACCEPT|REJECT at <revision>
Build/start: ok|failed (<one line>)
Checks: <command> -> <pass>/<total>, ... (strict mode: yes)
Acceptance tests: <pass>/<total>
Checklist: <confirmed>/<total>; failed: <ids>
Failures (REJECT only), one per item:
- <id>: <what is wrong> | repro: <exact command or request> | violates: "<requirement text>"
```

Report all failures in one verdict. Never fix code yourself. Never reject without a reproducible
failure; never accept without having run the checks yourself.
