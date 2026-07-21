---
name: diagnose-runtime
description: Diagnose failures in commands, tests, local services, Docker Compose stacks, network paths, logs, and development environments without changing code, configuration, service state, or data. Use when the user asks why something fails, requests root-cause analysis, log inspection, environment triage, or another read-only diagnosis. Do not use for known-fix implementation, routine verification of an understood change, or live mutations. If the request includes diagnosis and repair, establish the diagnosis first and then return implementation to the main agent.
---

# Diagnose Runtime

Find the evidence-backed root cause with the least invasive checks and keep diagnosis separate from repair.

## Workflow

1. Read applicable repository guidance and inspect the working tree without changing it. Capture the exact failing command, error, expected behavior, environment, and known-good comparison when available.
2. Map the relevant boundaries, such as caller, process, filesystem, network, service, dependency, configuration, and persisted data. Form a small set of falsifiable hypotheses.
3. Run the cheapest read-only checks first. Prefer current status, configuration, logs, version output, health endpoints, and focused reproduction over broad scans or restarts.
4. Delegate existing tests, builds, or large log collection to `test_runner` only when the output is lengthy, multiple checks can run independently, or the main thread would be polluted. Give it exact scope and commands when known, wait for its result, and verify its conclusions against direct evidence.
5. Trace the failure to the earliest incorrect state or boundary. Do not present a downstream error message, missing retry, or restart effect as the root cause without explaining why it occurred.
6. Classify the failure as a code defect, test defect, flaky behavior, configuration mismatch, missing dependency or service, permission problem, network problem, corrupted state, or environment limitation.
7. Stay non-mutating: do not edit files, install dependencies, update snapshots, run migrations, restart or recreate services, delete data, or issue live administrative commands. If a mutation is needed to prove or repair the diagnosis, explain it and return control to the main agent for the separately authorized action.
8. Separate observed facts from inference. If reproduction is blocked, state the blocker, confidence level, and the next read-only evidence that would reduce uncertainty.

## Result

Report the outcome first, followed by the decisive evidence, root cause and confidence, blockers or unknowns, and a concise repair direction that was not applied.
