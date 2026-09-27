---
name: requirements-extraction
description: Turn a written specification into a numbered, testable requirements checklist with traceability, coverage flags and recorded ambiguity decisions. Use when you receive requirements for a step and must define what "done" means before anyone builds.
---

# Requirements extraction

Goal: a checklist so complete that if every item is satisfied, the specification is satisfied,
including the parts no supplied check asks about.

## Procedure

1. **Read everything twice.** First pass for structure, second pass line by line. Tables, code
   blocks, examples, footnotes and "note" paragraphs are all normative unless marked otherwise.
2. **Extract atomic items.** One item = one observable behaviour a client could test. Split
   compound sentences ("X and Y unless Z" gives three items). Capture:
   - every must, must not, never, always, only, at most, at least, exactly
   - every status or error outcome, and the condition that triggers it
   - every field, its type, format, optionality, bounds and default
   - ordering, pagination, sorting and tie-break rules
   - time rules: zones, offsets, daylight-saving transitions, interval boundaries (open or closed)
   - arithmetic rules: rounding, units, limits, overflow
   - idempotency, retry, and concurrency guarantees
   - state rules: what a failed or rejected request must leave unchanged
   - every worked example, as its own item with its exact inputs and outputs
   - delivery rules: build, run, ports, resource limits, startup time, offline operation
3. **Number stably.** Use `R<section>.<n>` ids that follow the spec's own section numbers, so
   later steps can extend the list without renumbering.
4. **Flag coverage.** For each item note `covered` if a supplied check visibly exercises it, else
   `UNVERIFIED`. Unverified items get priority in tests and review.
5. **Record ambiguity.** When two readings exist, choose the most literal one that is consistent
   with every other item, and write `Decision: … because …` under the item.
6. **Cross-check.** Re-read the spec against the finished list, section by section, and add what
   is missing. Count the normative sentences in each section and compare with your item count.

## Output format

```markdown
# Checklist — <step name>
Source: <absolute path of the spec> · Items: <n> · Unverified: <m>

## <spec section title>
- [ ] R3.1 <behaviour, stated testably> — UNVERIFIED
- [ ] R3.2 <behaviour> — covered
  Decision: <choice> because <reason>
```

When a later step extends an earlier one, carry the earlier checklist forward unchanged and add
the new items: nothing that passed before is allowed to regress.
