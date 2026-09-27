---
name: ui-states
description: Build browser screens that are coherent, responsive and presentation-ready, handle every state (loading, empty, error, conflict, stale data, lost responses), and carry exactly the element identifiers the requirements name. Use for any work a person sees in a browser.
---

# UI states

A screen is done when every state the requirements identify is visible, clear and recoverable,
at phone and desktop width, and every required element identifier is present exactly as written.

## Structure

- Serve the pages and all their assets from the service itself; no external fonts, scripts or
  styles. Plain HTML, CSS and small vanilla JavaScript is enough and fastest to get right.
- One stylesheet with design tokens (colours, spacing, radius, type scale) as CSS variables; use
  them everywhere so the product looks like one product.
- Semantic HTML: real buttons, labels bound to inputs, headings in order, forms that submit with
  the keyboard.
- Layout mobile-first; check at 375 px and at 1280 px. No horizontal scrolling.

## Element identifiers

Copy every identifier the requirements name, character for character, onto the element the
requirements describe. Keep a list of them with the checklist ids, and verify each one exists in
the rendered page before handoff. Never rename one for style reasons.

## States to design explicitly

For each screen, list and implement: initial, loading, loaded, empty, validation error, server
error, conflict (someone else changed or took it), stale data (refresh and show what changed), and
uncertain outcome (a request whose response was lost: tell the user, then reconcile by reading
state back instead of blindly retrying). Disable submit while a request is in flight so a double
click cannot send twice; send an idempotency key when the API supports one and reuse it on retry.

## Polish that judges notice

Clear page titles, visible focus rings, helpful empty-state text, human-readable dates and times
with the correct zone, error messages that say what to do next, consistent spacing, no layout jump
while loading.

## Self-check before handoff

Drive every screen in a headless browser at both widths through the happy path and each error
state; confirm each required identifier is present; take screenshots for the verifier.
