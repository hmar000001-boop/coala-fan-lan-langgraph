# Chapter 19 Outline — Engineering Foundations for Request-Driven Enterprise Agentic Systems

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — proposed six-chapter structure  
**Outline status:** proposed for author review; not approved; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** establish the single simulated supply-chain application, its domain, environment, module boundaries, and engineering responsibilities before explaining its cognitive and mechanism code.
**Proposed Part III heading:** *Engineering a Simulated Supply-Chain Agentic Application with Java* (author approval required; the active LaTeX heading is not changed by this outline).

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

Explain selected commands/effects (for example inventory reservation, purchase-order placement, quality hold, shipment delay or reroute) and the difference between proposal, dispatch request, simulated state transition and observation. Do not call a simulator transition a real purchase order sent to a supplier.

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

**Diagram:** Maven module/dependency map with the domain/simulator at the business boundary and framework-specific dependencies confined to the runtime/application/infrastructure side as actually declared in the POMs.

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

This creates an author decision: the current book rule (16 November 2026) says the reference architecture must be framework-independent and must not include LangGraph4j/LangChain4j. The code repository contradicts that restriction. The recommended resolution is to amend the rule so Part III documents the actual framework-aware implementation while keeping frameworks out of the theoretical foundations. Do not describe the code as framework-independent unless the code is changed to make that statement true.

### 19.8 How the reader will navigate the implementation

Explain the code-reading path that the rest of Part III follows:

1. Domain and simulator first.
2. CoALA memory/action/planning services second.
3. B1/B2/B3 and B4/B6 control services third.
4. Graph, host, PostgreSQL adapters and complete test-backed execution last.

Distinguish production sources from tests/fixtures. Explain that `Phase0Application` is a deterministic intake smoke program, not the full cognitive application entry point. The complete graph is composed through `CognitiveCycleApplicationGraph` and `DurableCognitiveApplicationHost`; the most complete demonstration is currently a test-backed host composition, not a user-facing UI/CLI product.

## 5. Code and diagram presentation for this chapter

Use the book's established sequence: problem → intuition → precise contract → selected implementation → call path → failure/boundary → test evidence. Code excerpts must be short, repository-relative, and from the supplied source snapshot. No screenshots of code and no whole-file dumps.

Recommended figures:

1. One request through assessment, approval, simulated transition and observation (conceptual, not a full graph yet).
2. Domain model around orders, inventory, suppliers, shipments and recovery objectives.
3. `SupplyChainSimulator` and the `SupplyChainSimulationWorld` adapter boundary.
4. Eleven-module architecture/dependency map.
5. Responsibility/authority boundary map separating planner, mechanisms, action gate, graph runtime and simulator.

## 6. Boundaries and claims to preserve

- The simulator is a deterministic model of an external world, not a real external integration.
- The application is a teaching/reference demonstration, not a deployed product.
- The architecture is one engineering design, not prescribed by CoALA or Fan & Lan.
- The frameworks used by the supplied repository must be named honestly if the author approves the framework-scope change.
- CI acceptance/test evidence is not independent experimental validation.
- Do not claim the repository is a standalone interactive application: the only `main` in the app module is `Phase0Application`, which invokes the intake smoke graph.

## 7. Proposed diagrams and exercises

**Exercise:** Given a proposed inventory reservation, identify which layer knows the business facts, which layer proposes the action, which layer authorizes it, which component applies the simulated transition, and which component records the observation. Explain why the LLM must not supply the inventory truth or approval.

## 8. Author approval items

1. Approve the six-chapter Part III structure (19–24) as a replacement for the 16 November two-chapter limit. Six is recommended because CoALA realization, the B1/B3 evidence pipeline, B2 protected recovery, B4/B6 governance, and final runtime integration are distinct teaching units. B2 deserves its own chapter because its parent/child state model, delegated capability, nested subgraph, typed return and governed promotion lifecycle would overload a combined B1/B2/B3 chapter.
2. Approve replacing the framework-independent restriction with an accurate description of the supplied LangGraph4j/LangChain4j/PostgreSQL implementation. The alternative is to keep the restriction and separately refactor the code, which is not part of this documentation task.
3. Approve the proposed Part III heading *Engineering a Simulated Supply-Chain Agentic Application with Java*. The current active heading says “Production Supply-Chain Agentic System,” which risks implying deployment; the application is a deterministic teaching/reference demonstration.
4. The proposed default is to keep the primary demonstration deterministic and test-backed, while explaining the LangChain4j adapter as an integration point rather than requiring a model provider for the main walkthrough.

No active LaTeX include list, chapter title, preface, reading guide or writing rule is changed by this proposed outline.
