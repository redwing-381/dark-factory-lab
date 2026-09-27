JOB: {{TRACK}} stage {{STAGE}}

This is a dark-factory run. This message is the only human input for this job. Do not ask me
anything and do not wait for me; decide from the requirements and record decisions in the room.
Finish with a final report.

GOAL
Deliver a complete, verified solution to the stage {{STAGE}} requirements below, as its own
buildable service folder, without breaking anything earlier stages required.

PATHS (absolute)
- Result repository: {{REPO}}
- Work folder for this stage: {{REPO}}/stage-{{STAGE}}
- Requirements file (same text as pasted below): {{SPEC}}
- Checklist and acceptance tests for this stage go in: {{REPO}}/stage-{{STAGE}}/acceptance/
  (checklist file: CHECKLIST.md; tests plus a README with the one command that runs them)

STARTING POINT
- If {{STAGE}} is 1: the work folder may be empty or hold a minimal starter; build from there.
- Otherwise: the work folder does not exist yet. Create it as a copy of the accepted
  stage-{{PREV}} folder (stage-advance procedure), then extend the copy. Never edit stage-{{PREV}}.
  Carry the stage-{{PREV}} checklist forward and add the new items.

CONSTRAINTS
- Stack: Python 3.12, FastAPI with uvicorn (one worker process), stdlib sqlite3 for storage,
  browser pages as plain HTML, CSS and vanilla JavaScript served by the same app, all assets
  inside the image. Pin every dependency.
- The folder must contain Dockerfile, RUN.md and the source. Builds may download dependencies;
  the running container has no outbound network, 2 vCPU, 2 GiB memory.
- Build to the requirements text, not to the supplied checks: the supplied checks are only a
  sample of the tests used for judging.
- Every seat commits under its own seat name as git author. Never amend, rebase or squash.
  No nested .git directory inside any stage folder.

CHECK COMMAND (the verifier runs this; use a new output directory name every run)
cd {{KIT}} && . .venv/bin/activate && python -m harness run --track {{TRACK}} --repo {{REPO}} --stage {{STAGE}} --mode isolated --out {{REPO}}/../checks/{{TRACK}}-s{{STAGE}}-$(date +%H%M%S)

Reading its output: every suite up to {{STAGE}} must print pass; the suite after {{STAGE}} (if
printed) is expected to fail. The line that decides is the last one: it must read
"claimed stage: {{STAGE}}". Failing test details are in the log files it names.

DONE MEANS
- Verifier's whole-stage ACCEPT at a named revision: clean build, check command claims stage
  {{STAGE}}, acceptance tests pass, every checklist item confirmed or explicitly decided.
- Coordinator's final report: revision, results, decisions made, open issues.
