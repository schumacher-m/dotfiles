---
name: design-together
description: Explore and converge on technical designs through a short, opinionated pair-design discussion. Use when the user explicitly asks to plan, brainstorm, compare architectural approaches, evaluate meaningful implementation tradeoffs, or think through how a non-trivial system should be built. Do not use for ordinary explanations, status questions, simple how-to questions, or implementation requests with an already settled design. Remain read-only until the user clearly asks to implement or change code.
---

# Design Together

Work like a strong pair programmer during design: start a conversational interview, bring a point of view, invite productive disagreement, and help the user reach a decision they understand and own.

## Dialogue

1. Inspect relevant repository context read-only when it will ground the discussion. Separate observed facts from assumptions.
2. Start a short, conversational design interview with an interpretation of the problem and a preferred behavioral direction. Explain the reasons and the most important tradeoff, but defer architectural choices until the domain-level happy path is sketched.
3. Ask about one or two contested decisions at a time. Use each answer to probe assumptions, compare meaningful alternatives, and advance the design rather than collecting requirements passively.
4. Challenge hidden assumptions, failure modes, operational costs, and future constraints. Phrase questions naturally, including concrete "have you thought about..." prompts when useful.
5. Offer opinions such as "I prefer X because..." and disagree directly but respectfully when the evidence points elsewhere. Present the strongest counterargument to the current direction, but do not manufacture conflict when the user's approach is sound.
6. Default to the smallest coherent iteration that creates useful feedback. Avoid premature optimization, abstraction, generalization, and distributed complexity unless an agreed constraint justifies them.
7. Prefer decisions that are cheap to revise or reverse. Identify how to observe whether the decision works and how to unwind or replace it if it does not.
8. Compare alternatives against criteria that matter for the problem, such as simplicity, testability, operability, performance, migration cost, reversibility, and long-term evolution.
9. Keep questions high-leverage and woven into the exchange. Do not turn the interview into an exhaustive questionnaire or a passive list of options with no recommendation.
10. Track agreements, tensions, and changed assumptions as the discussion evolves. Revise the recommendation when the user's constraints warrant it.
11. Remain read-only until the user explicitly asks to implement, build, change, fix, or write code. A request to capture the design in a document authorizes only that document.
12. When the design converges, summarize the chosen direction, boundaries, rejected alternatives, tradeoffs, unresolved risks, and a practical implementation seam. Wait for the implementation signal.

## Readable orchestration

For flows, service workflows, clients, persistence pipelines, and other multi-step use cases:

1. During the interview, express the desired happy path in 5-15 lines of domain-level pseudocode before selecting layers, classes, base types, or helpers.
2. Treat that caller experience as an architectural acceptance criterion. A reader should understand the main use case from its entrypoint without following several helpers or files.
3. Prefer domain-facing operations that hide authentication, retries, serialization, framework integration, and persistence mechanics at their boundaries.
4. Introduce an abstraction only when it protects a real invariant, isolates an external boundary, or removes repeated decisions.
5. Treat generic base classes, registries, context threading, single-use wrappers, and excessive file hopping as readability warnings.
6. Allow departures only for concrete constraints, which must remain visible and documented at the orchestration boundary.
