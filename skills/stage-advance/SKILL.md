---
name: stage-advance
description: Carry a finished, accepted step folder forward into the next step's folder so requirements accumulate without regressions - copy, strip nested repositories and build output, update run instructions, commit. Use when one step is accepted and the next step begins.
---

# Stage advance

Work is delivered as a sequence of folders, one per step. Each folder is a complete, buildable
service holding **that** step's solution. The next folder starts as an exact copy of the accepted
previous one and is then extended.

## Procedure

1. Confirm the previous step has an ACCEPT whole-step verdict at a named revision, and that the
   working tree is clean at that revision.
2. Copy the accepted folder to the next folder name the job specifies. If the target already
   exists, stop and report; never overwrite.
3. In the copy, delete any nested `.git` directory, build output, caches, virtual environments,
   test output and local databases. A nested repository makes the folder arrive empty for anyone
   who clones the parent repository.
4. Update the copy's run instructions heading and image name to the new step; change nothing else.
5. Confirm the copy builds and starts, and that the previous step's checks still pass against it:
   the copy is the regression baseline for the new step.
6. Commit the copy alone, with a message naming both steps and the source revision, under your
   seat name as author.
7. Never modify the previous step's folder after it was accepted. Later fixes go into the new
   folder only; if an earlier folder is broken, report it to the coordinator as a blocker for that
   earlier step rather than silently patching it.

## Checks

- No symlinks, no submodules, no nested `.git` anywhere in the repository.
- Each step folder contains its build file and run instructions.
- The earlier folder is byte-identical to its accepted revision.
