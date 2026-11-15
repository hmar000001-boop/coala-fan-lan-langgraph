# Revised Part III pilot plan — one generic supply-chain agentic system

**Status:** Proposed for author approval  
**Pilot scope:** one domain-bounded, request-driven Enterprise Supply-Chain Disruption Management system  
**Provisional chapter numbering:** Chapter 19 (foundation) and Chapter 20 (pilot application). The original Chapter 22 use case is moved to Chapter 20 in this reduced Part III so the revised book does not retain gaps from the ten-case TOC. This is a proposed editorial revision, not yet a formally approved new complete-book TOC.

## 1. Purpose and design premise

Part III is the practical culmination of Parts I and II. Its purpose is to show CoALA and Fan and Lan's mechanism-level analysis operating in real Java code, not merely to restate their concepts or draw architecture diagrams.

The pilot is a **domain-bounded, request-driven agentic system**. It is not a simulation hardcoded for one disruption. It must accept a family of supply-chain requests over time, create an independent execution context for each request, retrieve relevant information, decide which internal or external actions are appropriate, maintain durable objectives, and adapt when new observations change the situation.

A chapter may walk through one supplier shutdown or shipment delay in detail. That walkthrough is a teaching trace only. The implementation must handle many other request types and must not encode that one trace as its fixed workflow.

### 1.1 Supported request families

The initial capability boundary should include:

1. Assess the impact of a supplier delay, outage or capacity reduction.
2. Investigate inconsistent or stale inventory information.
3. Investigate a blocked, delayed, lost or rerouted shipment.
4. Assess a quality failure and identify affected orders, lots and downstream commitments.
5. Evaluate a demand surge or changed fulfillment priority.
6. Find and compare feasible recovery alternatives.
7. Reassess an existing recovery plan after a new observation.
8. Coordinate a specifically authorized supplier, allocation, purchase-order or logistics action.
9. Produce an evidence-backed operational assessment without executing changes.
10. Coordinate two or more related disruptions where they compete for inventory, capacity, routes or supplier availability.

Unsupported requests must be identified as out of scope or referred to an authorized human. The system must not invent capabilities or business facts.

### 1.2 Central business objective

**Recover fulfillment of affected customer orders while respecting product, inventory, supplier, transportation, time, contractual, cost and authorization constraints.**

The agent may change the method or recovery plan as facts change. It may not silently change the authorized objective, customer commitment or hard business constraint.

## 2. Why supply chain is the best first pilot

Supply chain gives the book one system in which several kinds of complexity genuinely interact:

- changing external facts and conflicting evidence;
- dependency propagation across products, suppliers, orders, inventory and shipments;
- multiple plausible recovery paths;
- hard feasibility constraints and soft business preferences;
- scarce operational resources;
- long-running objectives and interruption;
- plans that become infeasible after execution has started;
- concurrency over shared inventory and capacity;
- meaningful human approval boundaries.

This creates natural implementation problems for all three CoALA dimensions and the five residual bundles B1, B2, B3, B4 and B6. It is not necessary to force every mechanism into the application; each must earn its place through an actual business or control requirement.

## 3. Decision-procedure strategy

CoALA defines architectural responsibilities and a repeated decision cycle; it does not prescribe one universal planning algorithm. The pilot should make that distinction executable.

### 3.1 Primary decision procedure: a custom, domain-grounded hybrid

The recommended primary approach is a hybrid with these responsibilities:

1. **Request interpretation and bounded routing.** Identify the request family, desired outcome, affected entities, time horizon, explicit constraints, urgency and authority level.
2. **Evidence acquisition and context construction.** Retrieve only relevant supplier, inventory, order, shipment, route, policy and historical information. Preserve source and time provenance.
3. **Candidate proposal.** Propose investigative actions and/or recovery-plan candidates. Separate action proposals from facts and from committed plans.
4. **Search and planning.** For requests requiring multiple dependent decisions, use a bounded MCTS-style planner over explicit operational state transitions. For smaller branching problems, use bounded tree search or direct deterministic selection.
5. **Evaluation.** Run hard business constraints through deterministic validators. Evaluate feasible candidates on cost, time, service impact, risk, robustness and resource consumption.
6. **Selection.** Choose a candidate under an explicit policy, or reject the candidate set and gather more evidence, enter a typed recovery substate, request human input or stop.
7. **Authorization.** Verify that the action is within the caller's and system's authority. Human approval is a separate decision, not a high score from the planner.
8. **Execution.** Invoke only permitted capabilities, with idempotency, precondition and result contracts.
9. **Observation and reconsideration.** Incorporate actual external results, update working context and durable state, and reconsider the current method when a trigger fires.

The sequence above is a high-level responsibility model, not a rigid one-pass pipeline. Retrieval and reasoning can occur during candidate generation and evaluation. New observations can send the system back to earlier decisions.

### 3.2 Decision-procedure methods to compare

The book's theoretical foundations remain CoALA and Fan and Lan. CoT, ToT and RAP are method-level prior art / engineering alternatives and experimental baselines, not additional theoretical foundations.

| Method | Role in pilot | What it demonstrates | Boundary |
|---|---|---|---|
| CoT-style sequential reasoning | Simple baseline for low-branching analysis and request interpretation | A single reasoning trajectory can propose a next step | Not a complete controller; it does not itself provide durable state, external feedback, approval or recovery |
| ToT-inspired bounded search | Candidate-plan and hypothesis exploration when several alternatives matter | Branching, evaluation of intermediate states, pruning and backtracking | ToT searches thought states; it is not identical to action-state planning in a real supply-chain environment |
| RAP-inspired MCTS | Primary planning experiment for multi-step recovery plans | Search over alternative action sequences with exploration/exploitation and rollout evaluation | RAP's original paper uses the LLM as both reasoner and world model. The pilot's authoritative operational transitions should instead come from a structured domain simulator. Therefore call this a RAP-inspired / domain-grounded MCTS adaptation, not a faithful RAP reproduction |
| Deterministic constraints and policies | Mandatory feasibility and governance layer | Hard constraints, authorization and invariants remain enforceable | Does not replace agent-supported interpretation or candidate generation |

The implementation should run comparative experiments rather than assume that MCTS is always superior. Use the least expensive procedure that solves the request to the required quality and risk level.

### 3.3 Planner selection and meta-control

A bounded decision-policy router may choose among direct rule evaluation, sequential reasoning, bounded branching search and MCTS. It should use declared request complexity, branch factor, uncertainty, risk, available planning budget and deadline. This router is a book-authored engineering decision, not a CoALA or Fan and Lan prescribed component.

The router must be observable and testable. It must also be possible to reject planning when the state is too uncertain, the simulator is outside its validated domain or the resource budget is exhausted.

## 4. Chapter 19 — Engineering Foundations for Request-Driven Cognitive and Agentic Systems

**Chapter purpose:** Establish the common Java architecture, state contracts and implementation discipline required for the pilot. The chapter should teach how the concepts already developed in Parts I and II translate into executable responsibilities. It should not become a general Java or framework tutorial.

### 19.1 From conceptual architecture to production behavior
- What a cognitive/agentic architecture explains and what it does not prescribe.
- The difference between a model call, a language-agent loop and a cognitive agent runtime.
- Why production systems need explicit state, authority, transitions, persistence and failure semantics.
- The relationship between Part I's CoALA dimensions and Part II's mechanism-level analysis.
- The book's distinction among source claims, comparative method references and engineering proposals.

### 19.2 Domain-bounded, request-driven systems
- Defining the system's domain and capability boundary.
- Request contracts, validation, objective, constraints, deadlines and authority context.
- One runtime supporting many requests rather than one hardcoded scenario.
- Execution identity, correlation and independent working contexts.
- Multi-request concurrency and isolation.
- Handling ambiguity, missing input, unsupported requests and conflicting objectives.

### 19.3 CoALA translated into runtime responsibilities
- Information storage: working and long-term information.
- Working memory versus the current model context.
- Episodic, semantic and procedural memory as distinct information roles.
- Internal actions: retrieval, reasoning and learning.
- External actions: grounding in digital/operational environments and receiving observations.
- Decision procedure: proposal, evaluation, selection and execution.
- Iteration and interleaving; observations update subsequent decisions.
- Why CoALA is an organizing framework, not a required software module diagram.

### 19.4 A typed request and execution-state contract
- Request ID, execution ID, domain scope, objective, constraints and authority.
- Working state and version.
- Evidence references and provenance.
- Candidate proposals and evaluation records.
- Selected decision versus committed decision.
- Authorization record versus execution result.
- Observation envelope and resulting state transition.
- Schema/version compatibility and serialization boundary.

### 19.5 Memory and context contracts
- Memory record identity, type, provenance, time validity and privacy scope.
- Retrieval query and candidate set contracts.
- Context assembly and admission decision.
- Distinguishing stored, retrieved, admitted, used and outcome-attributed information.
- Episodic outcome history and semantic domain knowledge.
- Procedural skills and the boundary between a remembered procedure and an executable capability.
- Retrieval latency, context budgets and lifecycle maintenance.

### 19.6 Internal and external action contracts
- Typed action descriptors and declared preconditions/effects.
- Internal action registry and external capability registry.
- Read-only versus state-changing operations.
- Idempotency and deduplication of external requests.
- Timeouts, partial results and uncertain outcomes.
- Capability policy, risk class, least privilege and approval requirements.
- Observations as evidence, not as automatic truth.

### 19.7 Proposal, evaluation, selection and execution in code
- Proposal generation as creation of candidates, not commitment.
- Candidate evaluation with declared criteria and constraints.
- Selection methods and the meaning of their values.
- Selection rejection and return to proposal/retrieval.
- Execution as a separate effectful operation.
- Observation processing and the next decision cycle.
- CoT, ToT, RAP/MCTS and custom decision procedures as alternative implementations of parts of this cycle.
- A compact, testable Java decision-loop implementation.

### 19.8 Fan and Lan's seven-field mechanism analysis as an engineering review lens
For each mechanism, explain how to ask:
- S — what operative state does it consume?
- C — which component has control authority?
- T — what event/condition triggers the transition?
- P — what survives calls, tasks, interruptions or restarts?
- F — what is the failure representation and response?
- L — what outcome changes later behavior, if any?
- R — what resource or governance rules apply?

Clarify that the tuple is an analytical tool, not a requirement to create seven classes or components.

### 19.9 The five residual bundles and B5 boundary
- B1: memory accessibility, predicted latency, downstream action utility and maintenance costs.
- B2: typed impasses, protected substates, typed return and safe resolution reuse.
- B3: bounded content competition, workspace admission, cycle-scoped broadcast and outcome-dependent updates.
- B4: persistent intention, reconsideration and method authority.
- B6: uncertainty, resource allocation, interruption and stopping.
- B5/GraSP: a closed candidate in the reviewed corpus; retain it as a closest baseline/negative case rather than claiming a new residual.
- The bundles are research/engineering hypotheses from a bounded review, not a proven universal architecture.

### 19.10 Durable execution and lifecycle
- State ownership and versioning.
- Durable intention and execution records.
- Checkpoint boundaries and restart behavior.
- Idempotent command handling.
- Outbox/inbox patterns only where they address a demonstrated delivery problem.
- Optimistic concurrency or locking and stale-state detection.
- Reconciliation of uncertain external effects.
- Append-only event/audit history versus mutable current-state projections.

### 19.11 SOLID, DDD and modular Java design
- Domain model and invariants.
- Application use cases and orchestration responsibilities.
- Ports/adapters for external data and actions.
- Dependency direction and interface segregation.
- Dependency inversion for model providers and persistence.
- Avoiding generic abstractions that erase domain-specific constraints.
- Modular monolith as the initial deployment architecture; no artificial microservices.

### 19.12 Authority, security and human approval
- Objective owner versus method governor.
- Proposal, evaluation, selection, approval, authorization and execution as distinct records/events.
- Risk-based permissions and approval expiry.
- Revalidation before execution.
- Untrusted supplier documents, external messages and model-generated content.
- Injection-resistant tool boundaries, least privilege and audit.
- Privacy and retention of supplier/customer/business data.

### 19.13 Failure semantics, uncertainty and recovery
- Missing, stale and contradictory evidence.
- Invalid or infeasible candidate.
- Search/model/provider failure.
- Tool timeout and unknown external outcome.
- Interrupted execution and restart.
- Typed impasse and bounded substate.
- Escalation, abstention and stopping.
- Resource-budget enforcement and safe degradation.

### 19.14 Testing, evaluation and delivery discipline
- Unit tests for domain invariants and transitions.
- Contract tests for ports and adapters.
- Deterministic simulator tests.
- Decision-procedure comparison and ablation.
- Persistence/restart and concurrency tests.
- Fault injection and adversarial inputs.
- End-to-end multi-request testing.
- Reproducible Java 21 Maven build and CI.
- ADRs, source attribution and chapter-to-code traceability.

**Chapter 19 deliverable:** A minimal but real, buildable Java foundation: typed request/execution contracts, capability boundaries, decision-cycle interfaces, memory/retrieval contracts, persistence and audit interfaces, test harness and CI. It should not attempt to implement the full supply-chain application before Chapter 20.

## 5. Chapter 20 — Enterprise Supply-Chain Disruption Management Agent

**Chapter purpose:** Implement one reusable system that handles varied supply-chain disruption requests, demonstrates the selected decision procedures and makes the relevant CoALA and Fan and Lan mechanisms observable in code.

### 20.1 The domain and its operating boundaries
- Enterprise supply-chain context and actors.
- Supported disruption/request families.
- Operational objectives and constraints.
- What the system is allowed to recommend, decide and execute.
- What remains outside the system's authority.
- Define one illustrative company/supply-chain dataset without making the implementation depend on one story.

### 20.2 Request intake and classification
- Typed request model.
- Natural-language request interpretation into a validated request contract.
- Affected order/product/supplier/shipment/resource identity resolution.
- Objective and hard/soft constraints.
- Urgency, deadline, budget and authority context.
- Clarification, out-of-scope and insufficient-evidence responses.
- Multiple independent requests and execution contexts.

### 20.3 Domain model and business invariants
- Customer order and order line.
- Product/SKU and approved substitute.
- Supplier, contract, capability and capacity commitment.
- Inventory location, lot, stock movement and reservation.
- Purchase order and supplier confirmation.
- Shipment, carrier, route, milestone and delivery estimate.
- Disruption, impact assessment and evidence.
- Recovery objective, candidate plan, committed plan and execution.
- Approval and audit record.
- Core invariants: no over-allocation, no invalid substitute, no impossible capacity, no lost order identity, no unapproved contractual/financial commitment, and valid lifecycle transitions.

### 20.4 Supply-chain state and deterministic simulator
- Explicit state snapshot and version.
- Inventory and reservation transitions.
- Supplier-capacity and lead-time transitions.
- Shipment/route transition model.
- Order dependency and fulfillment semantics.
- Simulator input/output contract.
- Validated domain boundaries and unknown/out-of-model states.
- Why the simulator, not a language model, is authoritative for operational state transitions.

### 20.5 Evidence and external observations
- Inventory system observations.
- Supplier messages/confirmations.
- Purchase-order and contract data.
- Shipment tracking and carrier updates.
- Quality inspection data.
- Demand and order-priority signals.
- Source provenance, timestamp, validity interval and trust policy.
- Late, stale, incomplete and contradictory evidence.
- Evidence adapters and deterministic normalization.

### 20.6 CoALA memory in the supply-chain domain
- Working memory: active request, affected entities, current evidence, hypotheses, constraints and plan state.
- Episodic memory: previous disruptions, outcomes, failed alternatives and lessons supported by evidence.
- Semantic memory: product/supplier/route/contract/dependency knowledge.
- Procedural memory: validated procedures, runbooks and task capabilities.
- Retrieval policy and evidence selection.
- Temporal invalidation and correction of superseded facts.
- Memory write policy and outcome attribution.

### 20.7 B1 — activation, retrieval latency, downstream value and maintenance
- Memory and evidence candidate records.
- Query/task/action-conditioned relevance and accessibility.
- Predicted cognitive retrieval latency versus measured infrastructure latency.
- Downstream utility of a memory for a particular recovery decision.
- Storage/indexing, refresh, validation, retrieval, context and maintenance costs.
- Context-admission policy under a bounded budget.
- Outcome events distinguishing retrieval, context admission, downstream use and measured benefit.
- Compare against simpler retrieval/top-k and relevant closest baselines; do not claim a novel B1 law without evidence.

### 20.8 B2 — typed impasses and bounded resolution substates
- Impasse taxonomy: missing capacity, ambiguous supplier commitment, conflicting stock evidence, infeasible allocation, missing dependency or incompatible substitute.
- Detect the exact condition that prevents a normal transition.
- Preserve the parent request, objective, constraints and version.
- Open a bounded child investigation/resolution substate.
- Give the child only the capabilities needed to resolve the impasse.
- Return a typed result and validate it against the current parent version.
- Eliminate/reject/reopen the child according to explicit rules.
- Record candidate reusable procedures only after verification and applicability checks.
- Compare against generic error/retry handling; preserve negative outcomes.

### 20.9 B3 — bounded content competition, workspace and broadcast
- Candidate content from memory, supplier/monitor observations, inventory services, agent proposals and plans.
- Typed candidate envelopes with provenance, validity, source and risk.
- Coalition/candidate grouping when information is complementary.
- Workspace capacity and admission governor.
- Cycle-scoped immutable workspace snapshot.
- Broadcast to the next reasoning/planning consumers and recorded consumer receipts.
- Outcome attribution and versioned admission-policy updates.
- Distinguish a workspace from a message bus, blackboard, top-k retriever or shared store.
- Tests for decisive-evidence suppression, overload and stale candidate admission.

### 20.10 B4 — persistent recovery intentions and reconsideration
- Authorized fulfillment objective and rationale.
- Continuation conditions and termination status.
- Current method/plan reference and version.
- Reconsideration triggers: new supplier facts, failed shipment, invalidated capacity, changed demand, deadline risk, changed approval or violated invariant.
- Governor decision: continue, delegate, suspend, change method, escalate or terminate.
- Goal authority separated from method authority.
- Persistent record and optimistic version checks.
- Anti-oscillation, cooldown and bounded reconsideration policy.
- Method switch without silent objective replacement.

### 20.11 Candidate recovery plans and ToT-inspired exploration
- Alternative plan generation.
- Bounded depth/branching and typed plan states.
- Evaluate partial plans for feasibility, expected impact and remaining uncertainty.
- Prune infeasible candidates.
- Backtrack when a new observation invalidates a branch.
- Compare breadth/depth/beam strategies where appropriate.
- Distinguish thought-tree search from actual supply-chain action-state planning.

### 20.12 RAP-inspired MCTS planning over a structured domain model
- Planning state, available actions and action preconditions.
- Transition model and rollout simulator.
- Reward/cost model: service level, delivery delay, financial cost, resource load, risk and robustness.
- MCTS node state, selection policy, expansion, rollout and backpropagation.
- Exploration/exploitation parameter and stopping criteria.
- Search budgets, deadlines and uncertainty.
- Root action extraction and plan proposal.
- Validation of selected plans against deterministic invariants.
- Comparison with greedy selection, ToT-inspired bounded search and CoT-style baseline.
- Explicit distinction from original RAP's LLM-as-world-model design: the domain simulator is authoritative; an LLM may propose actions or assist with qualitative hypotheses but cannot invent authoritative transitions.

### 20.13 Evaluation, selection and plan commitment
- Hard constraints before soft utility.
- Multi-objective trade-offs and explainable scoring.
- Rejection when no candidate is feasible.
- Sensitivity to weights and uncertainty.
- Record why a candidate was selected or rejected.
- Keep proposal/evaluation/selection distinct from approval and execution.
- Human review for material spend, contract changes, supplier commitments, high-impact allocation changes or exceptions.

### 20.14 Execution, tool boundaries and verification
- Read-only versus state-changing capabilities.
- Supplier communication and purchase-order amendments.
- Allocation/reservation changes.
- Route and shipment coordination.
- Preconditions and authorization proof.
- Idempotency keys and duplicate-effect protection.
- Execution result, external confirmation and postcondition verification.
- Partial completion and unknown outcome handling.
- No model-generated direct database mutation.

### 20.15 B6 — uncertainty, resources, interruption and stopping
- Uncertainty attached to observations, hypotheses and plan transitions.
- Evidence confidence and calibration evaluation.
- Separate business resources (inventory, capacity, time, budget) from agent-computation resources (tokens, calls, search steps, latency).
- Shared resource budget and priority policy.
- Verification budget proportional to uncertainty and risk.
- Interrupt, suspend, checkpoint and resume.
- Stopping criteria: achieved, infeasible, unauthorized, uncertain beyond policy, budget/deadline exhausted or human escalation required.
- Uncertainty propagation through planning and execution.

### 20.16 Concurrency, consistency and durable recovery
- Two disruptions competing for one inventory pool.
- Concurrent plans for a shared supplier or route.
- Reservations and reservation expiry.
- Version checks and stale-plan rejection.
- Locking or optimistic concurrency according to measured need.
- Atomic business transitions.
- Idempotent message intake and action execution.
- Partial saga/compensation only where a business action has an explicit inverse or recovery protocol.
- Reconcile after uncertain external results; do not assume exactly-once external effects.

### 20.17 Audit, observability and operational governance
- Request, evidence, candidate, evaluation, selection, approval, execution, observation and reconsideration trace.
- Decision provenance and policy versions.
- Resource and latency metrics.
- Failure and escalation taxonomy.
- Sensitive supplier/customer/business information controls.
- Retention, access and audit integrity.
- Operator diagnostics without exposing private model reasoning traces.

### 20.18 Complete Java implementation
- Domain module.
- Application/use-case module.
- Agent runtime components from Chapter 19.
- Memory/retrieval adapters.
- Model-provider adapter behind a port.
- Supplier/inventory/shipment adapters.
- Simulator and evaluator.
- Persistence and audit adapters.
- CLI or minimal API for request intake and inspection.
- Configuration, migrations and local run guide.
- ADRs explaining key choices.

### 20.19 Testing and evaluation
- Multiple independent request families, not one golden trace.
- Different suppliers, product types, routes, order priorities and constraints.
- Conflicting and late evidence.
- Infeasible plans and typed impasses.
- MCTS/ToT/CoT comparative runs using matched test cases and budgets.
- Resource exhaustion and stopping tests.
- New evidence invalidating an existing plan.
- Approval denial/expiry and stale approvals.
- Concurrent inventory allocation.
- Process restart during a long-running intention.
- Partial external execution and uncertain results.
- Fault injection and unsafe-action tests.
- Report operational metrics plus mechanism-level ablations.

### 20.20 Engineering synthesis
- What CoALA explains in the implementation.
- Which Fan and Lan mechanism couplings were implemented, adapted or left out.
- How decision algorithms differ while retaining a common CoALA decision-cycle structure.
- What the system does not prove about CoALA or Fan and Lan.
- Where simpler mechanisms outperform the more complex planner.
- Which architecture decisions transfer to other domains and which are supply-chain-specific.

**Chapter 20 deliverable:** a complete, tested Java 21 supply-chain disruption agent that handles a family of requests and supports multiple execution paths. It is the only use-case implementation in this pilot package.

## 6. Expansion policy after the pilot

Do not start the incident-recovery or payment-reconciliation systems as part of this pilot. They remain possible future additions only after the author reviews the supply-chain implementation and decides that it demonstrates the desired depth. If added later, the new use cases must contribute distinct decision-procedure/mechanism evidence rather than duplicate the supply-chain example with different nouns.

## 7. Editorial and implementation gates

1. Resolve the confirmed Part I/II corrections registered in the independent review.
2. Author approves the detailed Chapter 19 and Chapter 20 outlines.
3. Implement the Chapter 19 foundation increment and pass CI.
4. Implement the Chapter 20 domain and request contracts and pass CI.
5. Implement and test the decision procedures and mechanism integrations.
6. Complete multiple request/failure/concurrency scenarios and CI.
7. Freeze a repository checkpoint.
8. Write the chapter against the tested code. Do not write code claims that do not exist in the repository.
