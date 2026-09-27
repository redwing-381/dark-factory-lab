---
name: concurrency-safety
description: Implement writes that stay correct under concurrent requests, retries and partial failure - atomic check-and-act, idempotency keys, all-or-nothing multi-item operations, and input validation that never leaks a server error. Use for any endpoint or job that changes shared state.
---

# Concurrency safety

Invariant-first: write down the invariant each write path protects (for example "no two active
records may claim the same resource at overlapping times", or "the sum of all balances never
changes"). Then make it impossible to violate, not unlikely.

## Patterns

**Atomic check-and-act.** The check ("is it free?") and the act ("take it") happen inside one
transaction that holds the write lock from before the check until after the act. With SQLite, open
write transactions with `BEGIN IMMEDIATE` so the lock is taken before the read; never check in one
transaction and write in another. With other stores use a row lock, a unique constraint, or a
conditional update, and treat a lost race as the documented conflict outcome.

**One writer path.** Route every write through one function per aggregate so no path skips the
lock. Reads may run freely; writes serialize.

**Idempotency keys.** Store key, a fingerprint of the request, and the full original response
(status and body) in the same transaction as the effect. On replay with the same fingerprint,
return the stored response without redoing work. On the same key with a different request, return
the documented error. Scope keys as the spec says (per client, per endpoint).

**All-or-nothing multi-item.** Validate every item first, then apply all inside one transaction.
Any failure rolls back everything; the response names the failing item as the spec requires.

**Validation before effects.** Parse and validate the whole input before touching state. Malformed
JSON, wrong types, unknown enum values, out-of-range numbers and missing fields return the
documented client error, never a server error. Add a last-resort handler that converts unexpected
exceptions into the documented error shape and logs them.

**Time and money.** Store instants in UTC with explicit offsets on output; do zone arithmetic with
a real time zone database included in the image. Store money as integer minor units; round only
where and how the spec says.

## Self-check before handoff

- Fire 20 to 50 conflicting requests in parallel and assert the invariant.
- Replay the same keyed request 5 times in parallel: one effect, identical responses.
- Kill a multi-item request halfway (inject an invalid last item): no partial state.
- Keep the server within its limits: bounded worker pool, connection per request or a safe pool,
  no unbounded in-memory caches.
