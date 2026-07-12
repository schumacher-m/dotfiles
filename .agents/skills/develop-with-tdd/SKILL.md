---
name: develop-with-tdd
description: Implement code behavior with test-driven development using small red-green-refactor iterations and a final green test suite. Use when the user explicitly asks to implement, build, change, or fix a feature or bug in code where executable behavior can be tested. Do not use for design-only discussions or changes that contain no testable behavior.
---

# Develop with TDD

Implement the agreed behavior as a sequence of small, observable tests and minimal production changes.

## Red-green-refactor

1. Read applicable repository guidance and inspect the current implementation, test layout, canonical test commands, and working tree.
2. Translate the next smallest coherent behavior into an executable focused test. Reuse the repository's existing test style and helpers.
3. Run the focused test before changing production code. Confirm that it fails for the expected behavioral reason rather than a syntax, fixture, dependency, or environment problem.
4. Implement the smallest production change that makes the focused test pass. Avoid speculative abstractions, broad refactors, and unrelated cleanup.
5. Run the focused test until it passes, then refactor only where the now-green behavior makes an improvement useful. Prefer clear names and structure over explanatory comments; keep a comment only for a non-obvious constraint or rationale the code cannot express. Keep the test green throughout refactoring.
6. Repeat the cycle for the next small behavior. Run the feature's specified focused tests after each increment and keep the workset coherent and reviewable.
7. Do not weaken assertions, delete valid tests, over-mock the behavior under test, or change expected results merely to make the suite pass.
8. After the targeted implementation is complete, run the repository's full canonical test suite plus required project-native lint, type, build, or integration checks.
9. Diagnose and fix every deterministic code or test failure until the complete suite is green. Treat flaky tests, missing services, and environment failures according to their actual cause; do not misreport them as passing.
10. Treat a completed feature slice with its tests as a useful commit boundary, but do not commit unless explicitly requested.
11. Report the red-green-refactor increments, focused and full-suite commands, fixes made after the full run, and any verification that remains blocked.
