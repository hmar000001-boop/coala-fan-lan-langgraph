# Part III Scope Amendment — 25 November 2026

**Status:** approved by the author.

This record amends the Part III decision dated 16 November 2026. The earlier record is retained unchanged as historical provenance.

## Approved changes

1. Part III now contains six chapters (19–24), not two:
   - 19 — Engineering Foundations for Request-Driven Enterprise Agentic Systems
   - 20 — CoALA in Code: Memory, Actions, and Planning
   - 21 — Memory Selection and Workspace Competition: B1 and B3
   - 22 — Typed Impasses and Protected Recovery: B2
   - 23 — Persistent Intention and Resource Governance: B4 and B6
   - 24 — Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution
2. Part III heading: *Engineering a Simulated Supply-Chain Agentic Application with Java*.
3. The system is a deterministic reference demonstration and teaching application. It is not a deployed production integration; live third-party integrations and production deployment are out of scope.
4. The book must document the actual implementation technologies: LangGraph4j for graph orchestration, LangChain4j for model-facing adapters, and PostgreSQL for durable application stores and graph checkpointing.
5. CoALA and Fan & Lan remain the only overarching theories. The planner strategies and frameworks are engineering choices.
6. Fan & Lan's residual bundles are B1, B2, B3, B4 and B6. B5/GraSP remains the closed-candidate boundary, not a claim of implementation.
7. CI acceptance is treated as source acceptance when green; independent experimental validation is a separate phase, not a prerequisite for writing Part III.
8. Each detailed chapter outline still requires its own approval. Chapter 19's outline is approved; Chapters 20–24 are not yet approved for prose drafting.

## Rationale for six chapters

The six chapters separate the domain/engineering foundation, CoALA realization, the connected B1-to-B3 evidence path, B2 protected recovery, B4/B6 authority and governance, and end-to-end application composition. B2 is separate because its parent/child state model, bounded recovery subgraph, typed result validation, and governed promotion lifecycle form a distinct teaching unit. B1 and B3 are grouped as a learning sequence but are explicitly not treated as the same selector.

## Implementation/demo boundary

The central business environment is simulated. The deterministic walkthrough should use actual repository fixtures and tests. Same-process host reconstruction, replacement-pool recovery, and fresh-JVM tests are different evidence boundaries and must be described separately. `Phase0Application` is an intake smoke entry point, not the complete application UI/CLI.
