# Handoff template (generic — the coordinator fills this in)

Every delegated handoff is self-contained. The receiving seat cannot read earlier room messages,
the human's prompt, or task records. Paste content; never point at a message id.
Long handoffs may be split into numbered direct messages: `[1/3]`, `[2/3]`, `[3/3]`.

```
@<receiver> HANDOFF <work-item id> [part x/y]

GOAL
<one sentence: what done looks like>

REQUIREMENTS (complete, pasted verbatim — not summarized)
<the full requirement text or spec section(s) that apply>

CONTEXT
- Result repository (absolute): <path>
- Folder to work in: <path>/<folder>
- Current committed revision: <hash>
- Constraints: <runtime, resource, offline, language/stack as given in the task>

ACCEPTANCE CRITERIA
1. <checklist item ids this work item must satisfy>
2. <check command(s) that must pass, exactly as given in the task>

EVIDENCE EXPECTED BACK
- committed revision hash
- command(s) run and their summarized output
- checklist items claimed as satisfied, and any left open with reason

REPLY TO: @<sender>
```

Verdict format (reviewing seat → coordinator, cc implementer):
```
@<coordinator> @<implementer> VERDICT <work-item id> ACCEPT|REJECT at <hash>
Checks run: <commands + result>
Failing items: <checklist id — what failed — how to reproduce>   (REJECT only)
```
