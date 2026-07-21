# Personal development guidance

## Working style

- Lead with the outcome and keep explanations proportional to the task.
- For implementation requests, inspect the repository, make the change, and verify it instead of stopping at general advice.
- For review, explanation, status, or diagnosis requests, stay read-only unless a change is explicitly requested.
- For targeted repository work, inspect, edit, and verify without asking for routine confirmation or pausing between safe internal increments.
- Make reasonable, reversible assumptions and continue. State assumptions only when they materially affect the result.
- Pause for approval only when an action is destructive or difficult to reverse, externally visible, security- or production-sensitive, affects data or systems outside the stated scope, or would materially expand the requested work.
- Prefer built-in platform capabilities and existing repository conventions before adding custom machinery.

## Workflow routing

- Use `/design-together` for explicit planning, brainstorming, architecture, or meaningful technical tradeoffs. Keep design work read-only until the user asks to implement.
- Use `/diagnose-runtime` for evidence-backed root-cause analysis of failing commands, tests, services, networks, or development environments. Keep diagnosis non-mutating and separate from repair.
- Use `/develop-with-tdd` for testable behavioral implementation and let it own implementation-time verification through the final green suite.
- Use `/verify-change` for standalone validation or when correctness has not already been established; do not repeat a completed TDD verification workflow without a reason.
- Use `/bootstrap-repository` for reproducible setup surfaces and `/conventional-commit` only when the user explicitly asks to commit.

## Repository work

- Read applicable `AGENTS.md` files and inspect the working tree before editing.
- Preserve unrelated user changes and keep edits scoped to the request.
- Keep implementation worksets small and reviewable, preferably as a coherent end-to-end increment. Do not mix opportunistic refactors into the requested change.
- Write self-explanatory code for professional readers using clear names, cohesive functions, and explicit structure.
- Keep comments for non-obvious invariants, external constraints, workarounds, or rationale that the code cannot express.
- Update documentation when behavior, APIs, configuration, setup, or operations change. Avoid blog-style prose and documentation churn for internal implementation details.
- Use repository-native commands, package managers, lockfiles, and task runners. Prefer an existing `Makefile` target when it expresses the intended workflow.
- Search with `rg` or `rg --files` first.
- When asked to build or change a development surface, leave runnable artifacts and setup-oriented documentation.
- Keep secrets out of tracked files and provide local or example configuration where credentials are required.

## Code quality

- Prefer standard language capabilities and the standard library before third-party packages.
- Reuse an established repository dependency when it already solves the problem well.
- Add a dependency only when it abstracts meaningful recurring behavior; evaluate maintenance, security, licensing, and transitive weight first.
- Use the language's type system and static analysis to make invalid states difficult to represent.
- Model domain concepts with explicit typed objects instead of stringly typed values, loosely structured dictionaries, or parallel primitive arguments.
- Validate untrusted and external data at system boundaries, then work with typed domain objects internally.
- Prefer a mature ecosystem modeling library when it naturally improves validation and readability; in Python, use Pydantic when the domain model justifies the dependency.
- Avoid broad escape hatches such as `Any`, unchecked casts, and untyped maps. Keep unavoidable exceptions narrow and at boundaries.
- Prefer composition over inheritance and keep object graphs shallow.
- Keep domain invariants close to the model they protect, and keep orchestration in small cohesive services or functions.

## Errors and observability

- Use explicit state, result values, or domain types for expected outcomes. Never use exceptions or error channels as normal flow control.
- Validate inputs at system boundaries and fail early with actionable context.
- Do not swallow failures or catch broadly without a specific recovery action. Preserve the original cause when adding context.
- Add fallback or recovery behavior only when it is deliberate, observable, and tested; never silently hide a defect.
- Log meaningful boundaries and state transitions without narrating routine function calls or exposing sensitive values.

## Verification

- Run focused checks during implementation and the repository's complete canonical test suite at the end of a targeted change.
- Do not weaken, delete, or skip a valid test merely to obtain a passing result. Distinguish code defects from flaky tests, missing services, and environment failures.
- Verify runtime behavior when static checks alone cannot establish correctness.
- Report the commands run, their outcomes, anything not verified, and any remaining risk.

## Git

- Do not commit, amend, push, force-push, or open a pull request unless explicitly requested.
- Before committing, inspect the intended diff, exclude unrelated changes, and prefer coherent completed feature slices.
- Never bypass repository hooks unless explicitly requested.
