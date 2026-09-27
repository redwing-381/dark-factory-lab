---
name: spec-to-tests
description: Derive black-box acceptance tests from a requirements checklist, prioritising behaviour the supplied checks do not cover (boundaries, failure paths, retries, concurrency, time and arithmetic edge cases). Use after a checklist exists and before or alongside implementation.
---

# Spec to tests

Goal: tests that would catch an implementation which passes the sample checks but violates the
specification. Tests talk to the running service only through its public interface.

## Priorities (write in this order)

1. Items flagged `UNVERIFIED` in the checklist.
2. Every error and rejection path: correct status, correct error shape, and **state unchanged**
   afterwards (read it back to prove nothing partial was written).
3. Boundaries: first and last valid value, one past each, empty, maximum length, zero, negative.
4. Retries: the same request with the same idempotency key returns the original result and does
   the work once; the same key with a different body behaves as the spec says.
5. Concurrency: fire N identical or conflicting writes in parallel (threads or async, N at least
   20) and assert the invariant holds: exactly one winner, no lost update, totals conserved.
6. Time: interval edges (touching intervals, one minute overlap), different time zones, daylight
   saving gaps and repeated hours, offsets in responses.
7. Multi-item operations: all-or-nothing, including when the last item is the invalid one.
8. Upgrade paths: behaviour of state created by an earlier step still holds after the new step.
9. Every worked example in the spec, reproduced exactly.

## Rules

- One test per checklist id at least; name tests after ids (`test_r3_2_…`) so failures trace back.
- Reset state before each test using the service's documented reset or setup mechanism.
- Assert on the full documented response shape, not only the status code.
- Derive expected values from the spec text, never from what the implementation returns and never
  by copying the supplied checks.
- Keep tests fast and deterministic: fixed clocks or fixed inputs, no sleeps longer than needed.
- Use only standard, pinned test dependencies so anyone can run them with one command, and put
  that command at the top of the test folder's readme.
- A test that fails because the implementation is wrong is a success of this skill. Never weaken
  a test to make it pass.
