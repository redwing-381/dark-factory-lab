# E4 — tablekeeper stage 2 practice (tk-p1, same room tk-p1-run1)

- Dispatched Sep 29 ~02:15 IST; limit hit before engineer started; engineer stuck "Reconnecting" (R13), restarted
  Oct 1 ~04:45; engineer commits ea3bb96 (combined tables backend) 04:57, da7b50e (browser UI) 05:29.
- Operator isolated --all: stage-1/ 120/120 claims 1; stage-2/ 25/25 stage-2 suite + 120/120 stage-1, claims 2.
  stage-1/ untouched since accept.

## Manual UI review (desktop + 375px)
Works: search → availability grid → sign-in → book (ref 4KCRG9) → lookup → cancel button. Responsive layout OK,
coherent palette, readable.
Problems (App score):
1. Booking form opens below the grid, off-screen, no scroll/focus, chosen slot not highlighted.
2. Sign-in redirect loses the chosen slot/date (returns to empty search, today's date).
3. Grid not refreshed after booking (booked slot still shown as available).
4. Confirmation is a bare green box: unlabelled reference code, no "Booked" heading, "Table 1" repeated.
5. Table buttons show only numbers (no capacity/meaning).
→ Fix: ui-states skill gained a "Flow rules" section (feedback, keep intent across sign-in, refresh after
  writes, confirmation page, meaningful labels). Workshop copy.
