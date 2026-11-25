# Chapter 19 Outline — Engineering Foundations for Request-Driven Enterprise Agentic Systems

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — approved six-chapter structure (Chapters 19–24)  
**Outline status:** approved by the author on 25 November 2026; Chapter 19 prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** establish the single simulated supply-chain application, its domain, environment, module boundaries, and engineering responsibilities before explaining its cognitive and mechanism code.
**Approved Part III heading:** *Engineering a Simulated Supply-Chain Agentic Application with Java*.

## 1. Why this chapter exists

Parts I and II already explain CoALA and Fan & Lan. This chapter must not teach those theories again. It must establish the concrete problem and software system to which the next chapters will refer. A reader should finish Chapter 19 able to explain what is being simulated, what the agent is allowed to decide, which components own business truth, and where to find the relevant code.

The application is a **reference demonstration and teaching system**, not a deployed supply-chain product. It uses a deterministic supply-chain transition engine and simulated external effects. It does not contact real suppliers, carriers, warehouses, or enterprise systems. The architecture may demonstrate production-oriented engineering concerns—typed contracts, durable records, authorization, idempotency, recovery and checkpointing—without claiming production deployment or independent experimental validation.

## 2. Learning outcomes

By the end of the chapter, readers should be able to:

1. Explain the single application problem: assessing and responding to a request-driven supply-chain disruption under business, evidence, authorization and resource constraints.
2. Identify the domain objects and invariants that define what is feasible in the simulated world.
3. Distinguish the domain model, deterministic simulator, agent action adapters, cognitive services, orchestration runtime and persistence infrastructure.
4. Read the eleven-module Maven structure and understand the dependency direction at a high level.
5. Explain why framework orchestration, model integration, planning, memory and business authority are separate responsibilities.
6. Distinguish the demonstration's test-backed behavior from live integrations, deployment claims and later independent experimental validation.

## 3. Relationship to earlier chapters

- **Part I:** Chapter 2 supplies the architectural questions; Chapter 5 explains grounding; Chapters 6–8 explain candidate generation, evaluation/selection and iterative decision-making. This chapter identifies the concrete supply-chain environment and software responsibilities only.
- **Part II:** Chapters 9–10 supply the mechanism-analysis discipline; Chapter 11 supplies historical/modern comparison boundaries; Chapter 18 supplies the five-residual-bundle composition map. Detailed Java realizations are reserved for Chapters 20–24: CoALA in code (20), B1/B3 (21), B2 (22), B4/B6 (23), and application integration (24).
- Do not re-explain CoALA's memory taxonomy, Fan & Lan's historical lineages, the seven fields, or the B1–B6 research hypotheses here. Point back to those chapters and explain why the application needs the corresponding code later.

## 4. Detailed section outline

### 19.1 What is being built—and what is not

Start with one request-driven disruption scenario and the questions the application must answer: what is known, what is uncertain, what recovery options are feasible, what requires approval, what was actually applied in the simulated world, and what can be reported honestly afterward.

State the scope precisely:

- One supply-chain disruption-management application; no catalogue of unrelated enterprise case studies.
- Java 21 implementation, deterministic simulator and test-backed demonstration.
- No production deployment claim, no live third-party supplier/carrier integration, and no claim that CI acceptance is an independent experimental result.
- CoALA and Fan & Lan are the only formal theoretical foundations. The repository's planner strategies and frameworks are implementation choices, not additional theories.

**Code to show:** root Maven module list and a small application-boundary diagram. Do not begin with framework APIs.

### 19.2 The request and its business context

Explain the request lifecycle in business language before introducing implementation names:

1. A user/requestor reports a disruption.
2. The system interprets the request and assembles relevant evidence.
3. The agent develops and evaluates recovery candidates against domain constraints.
4. A candidate may be informational/read-only or state-changing.
5. A state-changing candidate must pass authorization and exact approval binding before execution.
6. The simulator applies a permitted transition; the system observes and reconciles the result.
7. The system records the outcome and may make verified experience available to a later cycle.

Use one coherent supply-chain example. Avoid mixing fixtures or attributing a result to a scenario that does not contain that behavior. The full two-cycle trace belongs in Chapter 24.

### 19.3 The domain model: business facts before agent reasoning

Introduce the real domain concepts selectively and explain their relationships:

- Product and product substitution.
- Supplier and supplier-product capability, including modeled qualification, capacity and lead time.
- Customer order and order lines, quantity, priority and status.
- Inventory location, inventory lot, quality status and reservation.
- Purchase order and purchase-order lines.
- Carrier, route, shipment and shipment lines.
- Disruption, recovery objective, recovery candidate and recovery constraint.
- `SupplyChainSnapshot` as a versioned view of the modeled world.

Emphasize invariants the code actually checks: quantity units, supplier qualification/capacity, lead-time feasibility, inventory quality/availability, shipment and route validity, valid state transitions, version checks and duplicate identifiers. Do not present the model as an exhaustive real-world supply-chain ontology.

**Primary code anchors:**

- `supply-chain-agent-domain/src/main/java/dev/supplychain/agent/domain/world/SupplyChainSnapshot.java`
- `domain/catalog/`, `domain/supplier/`, `domain/orders/`, `domain/inventory/`, `domain/procurement/`, `domain/logistics/`, `domain/disruption/`, `domain/recovery/`
- `domain/common/Quantity.java`, `Money.java`, and `DomainViolation.java`

**Code presentation:** begin with one small typed value object, then show selected entities and one invariant-bearing transition or validation. Avoid listing every domain class.

### 19.4 The simulator is the external world for this demonstration

Distinguish three things:

1. **Pure transition engine:** `SupplyChainSimulator.simulate(snapshot, command)` validates a typed command and returns a new snapshot plus typed effects. It performs no database, network or physical operation.
2. **Simulation-world adapter:** `InMemorySupplyChainSimulationWorld` exposes the simulator through the `SupplyChainSimulationWorld` port, checks the expected snapshot version and uses compare-and-set to reject concurrent stale transitions.
3. **Agent-facing grounding actions:** `SupplyChainGroundingActions` translates authorized action requests into simulation commands. Perception actions expose observations of the modeled state.

Explain selected commands/effects (for example inventory reservation, purchase-order placement, quality hold, shipment delay or reroute) and the difference between a planning-side structured simulator rollout, an internally reasoned candidate consequence, an external dispatch request, a simulated-world transition, and an observation. Relate structured simulator rollouts to Part I Chapter 6, and preserve Chapter 8's distinct account of internal simulation/candidate improvement. Do not imply these are interchangeable, and do not call a simulator transition a real purchase order sent to a supplier.

**Primary code anchors:**

- `supply-chain-agent-simulator/.../SupplyChainSimulator.java`
- `supply-chain-agent-simulator/.../command/SimulationCommand.java`
- `supply-chain-agent-simulator/.../effect/SimulationEffect.java`
- `supply-chain-agent-actions/.../external/grounding/SupplyChainSimulationWorld.java`
- `.../external/grounding/InMemorySupplyChainSimulationWorld.java`
- `.../external/grounding/SupplyChainGroundingActions.java`
- `.../external/perception/SupplyChainPerceptionActions.java`

### 19.5 The eleven Maven modules and their responsibilities

Show the actual modules, grouped by responsibility rather than as an unexplained list:

| Responsibility | Module | What the reader should understand |
|---|---|---|
| Business facts and invariants | `supply-chain-agent-domain` | Typed supply-chain state and constraints; no agent framework |
| Deterministic world transitions | `supply-chain-agent-simulator` | Pure simulation logic and effects |
| Request interpretation contracts | `supply-chain-agent-core` | Framework-neutral application ports and interpretation records |
| CoALA memory | `supply-chain-agent-memory` | Working, episodic, semantic and procedural memory abstractions/services |
| Internal/external action contracts | `supply-chain-agent-actions` | Perception, grounding, dispatch, capability and idempotency boundaries |
| Residual mechanism services | `supply-chain-agent-mechanisms` | B1, B2, B3, B4, B6 and feedback services |
| Candidate planning | `supply-chain-agent-planning` | Planning contracts, world model, strategies, routing and evaluation |
| Cognitive-cycle runtime | `supply-chain-agent-runtime` | Graph controller, operations, lifecycle and framework adapters |
| Durable adapters | `supply-chain-agent-infrastructure-postgres` | PostgreSQL stores, migrations and LangGraph4j checkpoint saver |
| Composition/host | `supply-chain-agent-app` | Application graph composition and durable host API |
| Test/evaluation support | `supply-chain-agent-evaluation` | Scenario fixtures, full-graph tests and separate experiment tooling |

Explain the most important dependency boundaries, not every POM edge. In particular, `core`, `domain`, `simulator`, memory, mechanisms and planning contain application logic/contracts; the runtime and app assemble them; PostgreSQL provides adapters; evaluation fixtures/tests exercise the composition.

**Diagram:** grouped module assembly view with the domain/simulator at the business boundary and framework-specific dependencies at the runtime/application/infrastructure side. Label the arrows as application composition, not as a literal Maven dependency graph; explain the actual dependency direction separately from the POMs.

### 19.6 Responsibility boundaries: who owns which decision?

Introduce the responsibility map that will be deepened later:

- Domain and simulator: business truth and feasibility of a proposed transition.
- CoALA memory services: stored information and memory lifecycle.
- Planner strategies: candidate generation/search; not business authorization or dispatch.
- B1/B2/B3/B4/B6: distinct retrieval, recovery, workspace, intention and meta-control decisions.
- Action registry/dispatcher and capability authority: whether a specific external action can be executed under the current authorization and idempotency rules.
- Cognitive graph: application sequencing, conditional routing, interruptions and checkpointing.
- PostgreSQL adapters: persistence of the corresponding records; not the cognitive policy itself.

Avoid collapsing these responsibilities into a claim that “the LLM decides everything.” Equally, do not imply each conceptual component must be a separate process or microservice.

### 19.7 Runtime technology used by the supplied implementation

The supplied repository is not framework-independent. Accurately identify the technologies used without turning this section into a framework tutorial:

- **LangGraph4j:** `CognitiveCycleGraph` is built with `StateGraph`/`CompiledGraph`; the class comment assigns application sequencing, routing, interruption and checkpointing to LangGraph4j. Domain services and planner strategies remain separate Java components.
- **LangChain4j:** model-facing adapters implement application-owned ports such as `ReasoningProvider` and `RequestInterpreter`. It is not the outer workflow engine.
- **PostgreSQL:** persists memory/runtime records and the graph checkpoint through distinct persistence interfaces/adapters.

The author resolved the earlier scope conflict on 25 November 2026. The 16 November rule requiring a framework-independent reference implementation is retained as historical provenance, but it is superseded for Part III by the approved scope amendment. The chapters must document the actual framework-aware implementation: LangGraph4j for graph orchestration and checkpoint integration, LangChain4j for model-facing adapters, and PostgreSQL for selected persistence adapters and graph checkpoints. These remain implementation choices rather than theoretical foundations. Do not describe the supplied code as framework-independent.

### 19.8 How the reader will navigate the implementation

Explain the code-reading path that the rest of Part III follows:

1. Domain and simulator first.
2. CoALA memory/action/planning services second.
3. B1/B2/B3 and B4/B6 control services third.
4. Graph, host, PostgreSQL adapters and complete test-backed execution last.

Distinguish production sources from tests/fixtures. Explain that `Phase0Application` is a deterministic intake smoke program, not the full cognitive application entry point. The complete graph is composed through `CognitiveCycleApplicationGraph` and `DurableCognitiveApplicationHost`; the most complete demonstration is currently a test-backed host composition, not a user-facing UI/CLI product. Present the five persistence/restart tests as separate evidence: (1) durable-host reconstruction at a clarification boundary in one JVM, before planning or effects; (2) the two-cycle simulated business flow with host reconstruction, deterministic providers, an in-memory simulator/approval adapter retained outside the host, and same-process codecs for selected artifacts; (3) focused workflow reconciliation after Hikari-pool/repository replacement in one JVM; (4) a focused write/reconcile across independent JVMs using a deterministic provider probe; and (5) full cognitive-cycle graph checkpoint resume across JVMs at a clarification boundary using test-owned in-memory world/effect adapters. Do not collapse these into a claim that the durable application or simulated-world snapshot is restored after a fresh-JVM restart. Preserve each test's exact boundary and what it does not prove.

## 5. Code and diagram presentation for this chapter

Use the book's established sequence: problem → intuition → precise contract → selected implementation → call path → failure/boundary → test evidence. Code excerpts must be short, repository-relative, and from the supplied source snapshot. No screenshots of code and no whole-file dumps.

Recommended figures:

1. One request through assessment, approval, simulated transition and observation (conceptual, not a full graph yet).
2. Domain model around orders, inventory, suppliers, shipments and recovery objectives.
3. `SupplyChainSimulator` and the `SupplyChainSimulationWorld` adapter boundary.
4. Eleven-module architecture/dependency map.
5. Responsibility/authority boundary map separating planner, mechanisms, action gate, graph runtime and simulator.

## 6. Boundaries and claims to preserve

- The simulator is a deterministic model of an external world, not a real external integration. Do not imply that every model-backed cognitive decision is deterministic.
- The application is a teaching/reference demonstration, not a deployed product.
- The architecture is one engineering design, not prescribed by CoALA or Fan & Lan.
- The frameworks used by the supplied repository must be named honestly if the author approves the framework-scope change.
- CI acceptance/test evidence is not independent experimental validation.
- Do not claim the repository is a standalone interactive application: the only `main` in the app module is `Phase0Application`, which invokes the intake smoke graph.

## 7. Proposed diagrams and exercises

**Exercise:** Given a proposed inventory reservation, identify which layer knows the business facts, which layer proposes the action, which layer authorizes it, which component applies the simulated transition, and which component records the observation. Explain why the LLM must not supply the inventory truth or approval.

## 8. Author decisions recorded on 25 November 2026

The author approved the six-chapter structure (Chapters 19–24), replacing the two-chapter limit recorded on 16 November 2026. The six chapters separate: engineering foundations (19), CoALA implementation (20), the B1-to-B3 evidence path (21), protected B2 recovery (22), B4/B6 governance (23), and complete runtime composition (24). B2 receives a dedicated chapter because its parent/child state model, delegated capability, nested recovery subgraph, typed return, and separately governed promotion lifecycle form a distinct teaching unit.

The author also approved documenting the framework-aware implementation as it exists: LangGraph4j for application graph orchestration, LangChain4j for model-facing adapters, and PostgreSQL for durable adapters and graph checkpointing. These are implementation technologies, not additional theoretical foundations. Part III is titled *Engineering a Simulated Supply-Chain Agentic Application with Java*. The application is a test-backed teaching/reference demonstration with a deterministic simulated supply-chain world; model-backed cognitive decisions are not thereby guaranteed to be deterministic. It is not a deployed production integration. The primary walkthrough uses deterministic providers/adapters; model-provider integration is explained as an implementation boundary rather than required for that deterministic test path.

Chapter 19's outline is approved for drafting. Chapters 20–24 retain their own outline-approval gates; approval of the overall six-chapter architecture does not automatically approve their detailed outlines.
