---
name: review-architecture
description: Assess existing or proposed software architecture across system, service or module, and component boundaries; preserve sound decisions, identify evidence-backed structural risks, and recommend the smallest coherent improvement. Use when discussing architecture, reviewing a design, planning a structural refactor, choosing boundaries or dependency direction, evaluating modularity, or investigating architectural anti-patterns such as god components. Do not use for routine code review or localized bug fixes with no architectural decision.
---

# Review Architecture

Apply architectural reasoning inside the active discussion. Optimize for a design that fits the system's real goals and constraints, not for compliance with named patterns.

## Operating stance

1. Stay read-only while reviewing or designing unless the user explicitly asks for implementation.
2. Ground the assessment in the actual repository when available. Read applicable guidance, relevant entrypoints, data and control flow, runtime boundaries, tests, and architecture documentation.
3. Separate observed facts, inferences, and material unknowns. Ask only when an unresolved choice would change the recommendation.
4. Judge structure by responsibilities and change pressures, not by file size, dependency count, or diagram shape alone.
5. Keep the recommendation proportional. Prefer a simple design that makes the main use case readable and future changes safe over speculative flexibility.

## Review workflow

### 1. Frame the architectural problem

Establish:

- the user or business outcome;
- the main use cases and actors;
- hard technical, organizational, and operational constraints;
- the quality attributes that matter now, such as changeability, reliability, security, performance, or deployability;
- the most likely reasons the system will change.

Do not assume every quality attribute needs equal optimization. Name consequential tensions, such as simplicity versus independent deployment, before recommending structure.

### 2. Reconstruct the architecture

Describe the happy path in 5-15 lines of domain-level prose or pseudocode. Identify only the boundaries needed to understand it:

- responsibility and decision ownership;
- state and data ownership;
- dependency direction;
- external system boundaries;
- deployment and failure boundaries;
- orchestration versus domain behavior.

Use a diagram only when it makes several relationships or a non-trivial flow materially clearer.

### 3. Establish architectural fitness

State what good architecture needs to enable in this specific system. Identify concrete decisions that already support that outcome and should be preserved. Do not manufacture praise; if evidence is limited, say so.

Assess only relevant lenses:

- cohesion and reasons to change;
- coupling and dependency direction;
- responsibility, data, and invariant ownership;
- boundary clarity and abstraction leakage;
- readability of the primary orchestration path;
- failure isolation, recovery, and observability;
- testability and replaceability of external boundaries;
- security and trust boundaries;
- operational simplicity and deployability;
- ability to evolve along likely change axes.

### 4. Test suspected problems with evidence

Treat anti-pattern names as diagnostic hypotheses, never as findings by themselves.

A god component is supported by several signals such as unrelated reasons to change, ownership of unrelated state or decisions, mixed domain and infrastructure responsibilities, excessive knowledge of collaborators, central orchestration for otherwise independent behavior, or tests that require most of the system. Size alone is not sufficient evidence.

Apply the same standard to other suspected problems. For example:

- Do not recommend microservices without a concrete need for independent ownership, deployment, scaling, or failure isolation.
- Do not add an abstraction unless it protects an invariant, isolates an external boundary, or removes repeated decisions.
- Do not add layers that merely increase file hopping without clarifying dependency direction.
- Do not split a cohesive component merely to satisfy a size heuristic.
- Do not accept shared mutable state, circular dependencies, or implicit ownership without tracing their actual consequences.

For every material risk, connect evidence to the quality attribute or likely change it threatens.

### 5. Recommend the smallest coherent direction

Lead with the target responsibility and ownership model, not a catalog of classes or patterns. Provide:

- the architectural property to preserve or create;
- the smallest useful boundary or seam that moves toward it;
- the intended dependency and data flow;
- the main tradeoff and migration cost;
- how the result can be observed and, when relevant, reversed.

Prefer one coherent improvement over a broad rewrite. Make larger restructuring conditional on evidence that the smaller step cannot satisfy the required quality attributes.

## Present the assessment

Lead with the outcome. Adapt the depth to the decision, using this order when a structured review is useful:

1. **Overall assessment**: State whether the architecture fits its current goals and name the most important architectural property.
2. **Strengths to preserve**: Cite concrete decisions and why they help.
3. **Prioritized risks**: For each risk, give evidence, consequence, recommendation, and tradeoff. Avoid style-only findings.
4. **Recommended direction**: Describe the target design and smallest viable improvement.
5. **Material unknowns**: Include only uncertainties that could change the direction.

Do not assign arbitrary architecture scores, fill a praise quota, or produce an anti-pattern checklist. If the architecture is sound for its current constraints, say so without inventing work.

## Coordinate with other workflows

- When `$design-together` also applies, use both: let it drive the collaborative design conversation and use this skill as the architectural evaluation lens.
- Keep ordinary correctness, security, regression, and test review with the general reviewer workflow unless structural concerns are explicitly in scope.
- When the user asks to implement the agreed direction, switch from assessment to the repository's implementation and TDD workflow.
- Use `$verify-change` after implementation to prove the resulting behavior and boundaries where practical.
