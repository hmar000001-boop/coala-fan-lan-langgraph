# Part III pilot — engineering and acceptance requirements

**System:** Supply-Chain Disruption Management Agent  
**Pilot chapters:** Chapter 19 foundation; Chapter 20 application  
**Status:** Proposed requirements for author approval. The requirements below are normative once approved; implementation details remain subject to ADRs.

## 1. Scope and non-goals

### 1.1 In scope

- One domain-bounded agentic system for supply-chain disruption and fulfillment recovery.
- Multiple request types and independent executions.
- Java 21 and Maven Wrapper with pinned dependency versions.
- CoALA-based information/action/decision organization.
- Substantial implementation of B1, B2, B3, B4 and B6 when justified by the domain.
- CoT-style baseline, ToT-inspired branching and RAP-inspired MCTS planning comparison.
- Deterministic domain rules, structured state transitions and simulator-backed plan evaluation.
- Persistent intentions, approval, safe tool execution, recovery and audit.
- Tests, evaluation, fault injection and reproducible CI.

### 1.2 Out of scope

- LangGraph4j and LangChain4j Agentic.
- Framework comparison chapters.
- A one-scenario hardcoded demo.
- A complete ERP, warehouse management, procurement or transportation management product.
- Ten different applications.
- Artificial microservices solely to demonstrate distributed architecture.
- Autonomous authority to make material contractual, financial, customer-impacting or irreversible commitments without the required approval.
- Treating generated prose, model confidence or simulator estimates as authoritative real-world facts.
- Automatic self-modification of production policies without review, versioning and controlled evaluation.
- Any source or example in a non-Java implementation language.

## 2. Technology and repository requirements

| ID | Requirement | Acceptance evidence |
|---|---|---|
| TECH-01 | Java 21 is the source and runtime baseline. | Maven compiler/release configuration and CI use Java 21. |
| TECH-02 | Maven Wrapper is committed and reproducible. | `./mvnw -B --no-transfer-progress clean verify` succeeds in CI. |
| TECH-03 | Use ordinary Java components; no LangGraph4j or LangChain4j dependencies. | Dependency tree and automated forbidden-dependency check. |
| TECH-04 | Model/provider access is behind a narrow port. | Domain/application code has no vendor SDK dependency; test double and at least one adapter are supplied. |
| TECH-05 | External operational systems are behind ports/adapters. | Domain tests run without live supplier, inventory, carrier or model services. |
| TECH-06 | Build and test artifacts are deterministic enough for repeatable CI. | Pinned dependencies, repeatable test fixtures and CI logs. |
| TECH-07 | Use a modular monolith initially. | Clear modules/bounded contexts without artificial service deployment. |
| TECH-08 | Architecture decisions are documented. | Numbered ADRs for model adapter, persistence, simulator, planning, concurrency, approvals and memory. |

A model adapter may use the JDK HTTP client or a small focused library; no agent orchestration framework may own the decision cycle. The model can assist with language interpretation, evidence summarization and candidate generation. It does not own authoritative business state.

## 3. Functional requirements

### 3.1 Request handling

| ID | Requirement | Acceptance evidence |
|---|---|---|
| REQ-01 | Accept multiple supported request families (supplier, inventory, shipment, quality, demand, recovery, reassessment). | Table-driven tests for each request family. |
| REQ-02 | Create a distinct execution ID and versioned working context for every request. | Concurrent request tests show isolation. |
| REQ-03 | Resolve named entities against domain records and report ambiguity. | Unknown/ambiguous supplier, order, SKU and shipment tests. |
| REQ-04 | Preserve objective, hard constraints, soft preferences, deadline and authority. | Contract tests and persistence round-trip. |
| REQ-05 | Reject or refer unsupported requests. | Out-of-scope request tests. |
| REQ-06 | Support request clarification when necessary. | Missing mandatory constraint and ambiguous entity tests. |

### 3.2 Domain and authoritative state

| ID | Requirement | Acceptance evidence |
|---|---|---|
| DOM-01 | Model orders, products, suppliers, capacity, inventory, reservations, shipments, disruptions, plans and approvals with typed identities. | Domain model tests; no raw string IDs in core transitions. |
| DOM-02 | Enforce no over-allocation and no negative available inventory. | Property/invariant tests. |
| DOM-03 | Validate supplier capacity and route/product compatibility. | Constraint tests. |
| DOM-04 | Distinguish observations, hypotheses, recommendations, committed plans and executed changes. | Type/state tests; transitions reject illegal status promotion. |
| DOM-05 | Track source time, observation time, validity interval and supersession. | Temporal evidence tests. |
| DOM-06 | Make the domain simulator authoritative for modeled state transitions. | Simulator contract and golden transition tests. |
| DOM-07 | Make out-of-model conditions explicit; never silently extrapolate as fact. | Unknown-state and unsupported transition tests. |

### 3.3 CoALA memory and actions

| ID | Requirement | Acceptance evidence |
|---|---|---|
| COALA-01 | Working memory is separate from prompt/context serialization. | State remains richer than an individual model input; snapshot tests. |
| COALA-02 | Episodic, semantic and procedural information have distinct types/roles. | Separate retrieval policies and type checks. |
| COALA-03 | Retrieval, reasoning and learning are explicit internal action categories. | Action traces distinguish them. |
| COALA-04 | External actions are typed, permission-checked capabilities. | Capability contract tests. |
| COALA-05 | Observations feed a later decision cycle. | Integration test with observation-driven reconsideration. |
| COALA-06 | The decision cycle separates proposal, evaluation, selection and execution. | State/transition tests and audit trace. |
| COALA-07 | Candidate sets may be rejected; the system can retrieve, clarify, escalate or stop. | No-feasible-plan and insufficient-evidence tests. |

### 3.4 Decision procedure and planning

| ID | Requirement | Acceptance evidence |
|---|---|---|
| PLAN-01 | Provide a simple sequential reasoning baseline. | Deterministic baseline interface and benchmark trace. |
| PLAN-02 | Provide bounded branching search for candidate recovery plans. | Search-depth/branch limits and backtracking tests. |
| PLAN-03 | Provide MCTS-based multi-step planning over explicit domain state transitions. | Unit tests for selection, expansion, rollout, backpropagation and stopping. |
| PLAN-04 | Distinguish ToT thought-state search from MCTS action-state planning. | Documentation and separate result types. |
| PLAN-05 | Label the supply-chain MCTS implementation RAP-inspired unless it reproduces RAP's LLM world-model arrangement. | Chapter text and ADR state the deviation explicitly. |
| PLAN-06 | Use deterministic constraints for hard feasibility and authority checks. | Invalid plan never reaches approval/execution. |
| PLAN-07 | Bound planning by time, iterations, branching, model calls and other resource budgets. | Budget exhaustion and safe stop tests. |
| PLAN-08 | Record why each candidate was selected, rejected or deferred. | Decision trace and audit inspection. |

### 3.5 Fan & Lan mechanism requirements

| ID | Requirement | Acceptance evidence |
|---|---|---|
| FL-01 / B1 | Context admission makes activation/accessibility, predicted latency, downstream utility and lifecycle/maintenance cost explicit without double counting. | Component-level metrics, policy trace and ablations. |
| FL-02 / B2 | Typed impasses create bounded substates, preserve parent version/state and return typed results. | Parent-state integrity and invalid-result tests. |
| FL-03 / B3 | A bounded workspace admits typed content, broadcasts a cycle snapshot and records consumption/outcome feedback. | Capacity, snapshot, broadcast and admission-update tests. |
| FL-04 / B4 | Persistent intention keeps objective/rationale/continuation condition and separates method authority. | Restart, method-switch and goal-drift tests. |
| FL-05 / B6 | Uncertainty and resource budgets influence verification, interruption and stopping. | Uncertainty propagation, budget exhaustion and interrupt/resume tests. |
| FL-06 / B5 | Do not assert a new B5 residual; retain GraSP as a reviewed closest baseline / closed case. | Design note and comparison protocol. |
| FL-07 | For each implemented mechanism, record S/C/T/P/F/L/R or explicitly state which fields are not applicable/unknown. | Mechanism traceability records. |
| FL-08 | Distinguish source-described mechanisms from engineering reconstruction. | Code comments/docs and chapter attribution tags. |

### 3.6 Execution, approval and recovery

| ID | Requirement | Acceptance evidence |
|---|---|---|
| ACT-01 | All external actions declare preconditions, effects, risk class and required authorization. | Contract tests and policy matrix. |
| ACT-02 | High-impact supplier, purchasing, allocation and contractual changes require explicit approval. | Approval gate tests. |
| ACT-03 | Approval is bound to a specific proposal/version/scope and expires or becomes stale when relevant state changes. | Expired/stale approval tests. |
| ACT-04 | Model output cannot call external systems or mutate database state directly. | Architecture test and dependency boundary. |
| ACT-05 | External command execution is idempotent where the external interface supports it. | Duplicate delivery/retry tests. |
| ACT-06 | Unknown outcome after timeout is represented as uncertain and reconciled before retry. | Simulated timeout-after-commit tests. |
| ACT-07 | Partial execution has an explicit recovery or compensation protocol. | Injected partial-failure tests. |
| ACT-08 | The objective is not silently replaced during method reconsideration. | Goal-version and authority tests. |

## 4. Persistence, concurrency and consistency requirements

- Persist execution identity, versioned request/objective, intention, current method/plan, evidence references, decision records, approvals, external-command status and audit history.
- Treat persistent intention, business state and working memory as distinct records with explicit ownership.
- Use optimistic concurrency or locking based on the demonstrated write-conflict pattern; do not choose a mechanism just for fashion.
- Ensure concurrent allocation cannot reserve the same units twice.
- Reject a plan if its state version is stale at commit time; require re-evaluation/replanning.
- Make request/event ingestion idempotent.
- Keep an immutable or append-only audit history for decisions and external effects; current-state projections may be mutable.
- Do not claim globally exactly-once execution across external systems. Demonstrate at-least-once delivery with idempotent effects and reconciliation of uncertain outcomes.
- Define retention, archival and deletion for supplier/customer/business-sensitive data.

## 5. Security, safety and governance requirements

- Treat supplier messages, uploaded documents, tracking feeds and model-generated summaries as untrusted inputs.
- Preserve provenance and separate quoted/source text from instructions.
- Apply least privilege to each capability; use distinct read-only and write-capable adapters.
- Validate model-proposed IDs, quantities, routes, substitutions and operations against authoritative state.
- Do not let a high model score bypass hard constraints or approvals.
- Require explicit approval for material procurement changes, financial commitments, contractual modifications, customer-impacting changes or irreversible actions.
- Revalidate approval immediately before execution.
- Record who/what authorized, what version was approved and what was executed.
- Do not store private reasoning traces as an audit substitute. Store structured evidence, candidate actions, criteria, decision reasons, approvals and execution results.
- Provide safe fallback when the model/provider is unavailable: deterministic rules, read-only assessment, bounded retry, human escalation or stopping.

## 6. Testing and evaluation requirements

### 6.1 Required test layers

1. Domain invariant/unit tests.
2. Application service tests with fake ports.
3. Simulator transition/constraint tests.
4. Retrieval and memory policy component tests.
5. Decision procedure unit and comparative tests.
6. Persistence/restart tests.
7. Integration tests for provider/adapters.
8. End-to-end multi-request scenarios.
9. Concurrency and duplicate-delivery tests.
10. Fault-injection and adversarial-data tests.

### 6.2 Required scenario families

- Supplier announces a delay or outage.
- Inventory evidence conflicts between two systems.
- Shipment is blocked or route becomes unavailable.
- Quality failure invalidates previously allocated stock.
- Demand changes after a recovery plan is approved.
- Two disruptions compete for the same stock or supplier capacity.
- Existing plan becomes infeasible after an external observation.
- External command times out after the provider may have committed it.
- Approval is denied, expires or becomes stale.
- Application restarts while a persistent intention is suspended.
- Planning budget expires before a feasible plan is found.
- All candidates are infeasible or evidence is insufficient.

### 6.3 Metrics

- Request classification correctness.
- Evidence coverage, freshness and provenance completeness.
- Retrieval usefulness, relevant recall, context admission precision and cost.
- Plan feasibility and constraint-violation rate.
- Fulfillment impact: delayed orders, affected units, service level and recovery time.
- Cost, inventory/transport/resource use and plan robustness.
- Replanning frequency and unnecessary plan churn.
- Typed-impasse resolution rate and parent-state integrity.
- Workspace decisive-evidence recall, distractor robustness and admission-policy effects.
- Intention drift, unauthorized method/goal changes and interruption recovery.
- Calibration/uncertainty quality, escalation precision and safe stopping.
- Duplicate external effects, stale approval use, and audit completeness.
- Model/tool calls, latency, search expansions and total resource cost.

### 6.4 Required decision-procedure comparisons

- Sequential CoT-style baseline.
- ToT-inspired bounded branch search.
- Greedy or deterministic heuristic plan selection.
- MCTS-based domain-grounded planner.

Use matched request datasets, simulator states, time/search budgets and deterministic seeds where possible. Report quality and cost. Do not claim one method is universally superior based on a handful of hand-selected traces.

### 6.5 Required mechanism ablations

Where implemented, test the contribution of:

- B1: activation/accessibility, utility, latency, maintenance accounting and feedback dimensions;
- B2: typed impasse/substate/typed return against generic retry/error handling;
- B3: bounded workspace/broadcast/admission update against top-k/shared-context baselines;
- B4: persistent intention/reconsideration against a plan-only baseline;
- B6: uncertainty/resource-aware control against fixed-budget execution.

If an element cannot be isolated or the task does not exercise it, record it as not evaluated rather than inventing a metric.

## 7. CI and release acceptance

A pilot increment is acceptable only when:

- Java 21 compilation succeeds with warnings treated according to the agreed policy;
- `./mvnw -B --no-transfer-progress clean verify` passes;
- dependency-boundary checks confirm no forbidden agent frameworks;
- unit, integration, simulator and end-to-end tests pass;
- architecture tests enforce domain/application/infrastructure boundaries;
- tests cover concurrency, restart, approval, duplicate and uncertain-outcome behavior;
- static quality checks and dependency vulnerability review pass;
- the README documents build/run/test commands and sample requests;
- ADRs and the mechanism traceability matrix are updated;
- a full repository ZIP checkpoint is created before the chapter is written.

Do not mark the chapter implementation complete until the hosted GitHub Actions run is green. Report local checks separately from hosted CI.

## 8. Chapter-writing acceptance

The chapter may be drafted only after the code it describes exists and its CI gate has passed. Every substantial code listing must be either:

- copied from or linked to the tested repository version; or
- explicitly marked as explanatory pseudocode/illustration.

The chapter must include at least several distinct request executions, not just one happy path; a full architecture and state contract; the relevant CoALA/Fan & Lan traceability; failure and approval cases; evaluation results; limitations; and a distinction between source-paper claims and this book's engineering results.
