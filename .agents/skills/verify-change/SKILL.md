---
name: verify-change
description: Independently verify that code, configuration, documentation, or infrastructure changes satisfy the requested behavior using project-native checks and direct runtime evidence. Use for explicit test, validation, proof, smoke-test, or final-verification requests, and after material work whose correctness has not already been established. Do not repeat a completed develop-with-tdd final verification unless the user requests an additional independent check.
---

# Verify Change

Establish correctness with focused feedback during each iteration and a green complete test suite at the end.

## Workflow

1. Read applicable repository guidance and inspect the request, current diff, and relevant implementation.
2. Translate the requested behavior into concrete acceptance criteria. Include failure paths and regression risks when material.
3. Discover the project's supported validation entry points from its task runner, package metadata, CI configuration, and documentation.
4. During feature development, run the specified focused tests after each small iteration. Start other verification with the cheapest focused check.
5. Prefer repository-native commands and existing dependencies. Do not introduce a new validation framework solely for a one-off check.
6. Verify actual runtime output, generated artifacts, UI behavior, network behavior, or persisted state when static checks cannot prove the requirement.
7. At the end of the targeted implementation, run the repository's complete canonical test suite and required project checks. Do not substitute a focused subset for the final full run.
8. Diagnose every failure as a code defect, test defect, flaky test, missing service, or environment problem. Fix every deterministic code or test failure and rerun until the complete suite is green.
9. Report each meaningful command and result, acceptance criteria satisfied, fixes made after the full run, blocked checks with reasons, and remaining risk. Never imply unrun checks passed.
