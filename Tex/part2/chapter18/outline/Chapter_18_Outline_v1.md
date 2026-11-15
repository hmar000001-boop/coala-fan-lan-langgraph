# Chapter 18 Outline v1.0

## How the Mechanisms Work Together

**Part II — From Cognitive Architectures to Mechanism-Level Understanding**  
**Batch 9 — final synthesis chapter**  
**Outline status:** Approved by the author on 15 November 2026 after one minor-issues review pass.  
**Chapter status:** Prose drafting authorized; the chapter is being written in `Tex/part2/chapter18/chapter.tex`.  
**Governing plan:** Author-approved nine-batch Part II plan. Chapters 9–17 are complete as source drafts; Chapter 18 is the synthesis of those chapters, not a new mechanism study.

---

## 1. Role of the final chapter

Chapter 18 closes Part II by examining how the five residual control bundles identified by Fan and Lan could compose within a bounded language-agent runtime, while treating GraSP's closed B5 chain as an existing skill-governance capability and comparison baseline.

The chapter must answer a question that none of Chapters 12–17 can answer alone:

> When individually meaningful control mechanisms are placed in one runtime, what must be shared, what must remain under separate authority, which dependencies are required, and how can we test whether the composition adds value rather than merely adding components?

The five residual bundles are:

- **B1:** activation, retrieval latency, downstream action utility, and memory maintenance cost;
- **B2:** typed impasse identification, protected recovery substate, typed resolution, and safe compilation of recovery knowledge;
- **B3:** typed-content competition, bounded workspace, cycle-scoped broadcast, and outcome-dependent admission learning;
- **B4:** persistent intention, explicit reconsideration, and authority to change methods without silently changing goals;
- **B6:** propagated uncertainty, resource allocation, preemption, interruption, and stopping.

**B5 is not a sixth residual bundle.** Fan and Lan close the B5 candidate after closest-baseline screening identifies GraSP as already composing calibrated multi-skill routing, typed skill-DAG execution, node-level verification, bounded local repair, and escalation to global replanning or ReAct. GraSP therefore remains an implementation dependency and mandatory baseline in the synthesis, not another open hypothesis.

The chapter will not present the five residual bundles as already validated, nor imply that connecting their diagrams proves that their composition works. Fan and Lan explicitly frame the residual bundles as a compositional research agenda and identify the need to measure the combined control edges.

**Primary source anchors:** Fan and Lan, § VI-A (common runtime semantics), § VI-B (candidate derivation and B5 closure), § VI-C (B1–B6), § VI-D (cross-bundle dependencies and implementation order), § VI-E (bounded synthesis runtime), Figure 8, Figure 9, Tables V–VI, and Appendix D.

---

## 2. Theory-to-practice assessment: a substantial composition bridge is required

The chapter is a synthesis, not a sixth engineering deep dive. Nevertheless, a substantial implementation bridge is required because the central question is whether individually plausible controls can coexist without authority conflicts, inconsistent state, unsafe learning, or duplicated resource decisions.

The bridge must move beyond drawing a combined architecture. It should define a testable composition contract while avoiding a second full implementation tutorial for B1–B6. The detailed mechanism internals remain in Chapters 12–17; Chapter 18 explains their interfaces and cross-bundle invariants.

### 2.1 What the bridge must provide

The outline requires the following engineering content:

1. **A shared runtime state vocabulary.** Use the state representation in Fan and Lan's synthesis model and connect it to the seven-field mechanism vocabulary introduced in Chapter 10.
2. **A responsibility and authority map.** Identify which subsystem owns memory admission, recovery scope, workspace admission, goal/method decisions, external-action authorization, resource allocation, and skill execution.
3. **Typed cross-bundle contracts.** Specify what information can cross each boundary, what evidence is required, and which state is immutable to the receiving component.
4. **A dependency graph.** Explain how B4 scopes B2 recovery, how verified B2 resolutions may become candidates for a GraSP-like skill governor, how B1 and reusable skills supply candidates to B3, how workspace evidence can trigger B4 reconsideration, and how B6 governs risk/resources across the runtime.
5. **An implementation order.** Preserve Fan and Lan's proposed order: externalize authoritative intention, uncertainty, budgets, and recovery state first; implement typed failure and bounded content admission next; add adaptive memory and compiled-skill policies after outcomes can be attributed.
6. **A complete worked trace.** Use Product X's timed-out payment request to show all mechanisms cooperating without crossing their authority boundaries.
7. **Persistence, concurrency, and event semantics.** Explain how correlated transitions, versioned state, reservations, recovery branches, and learning evidence remain consistent across subsystem boundaries.
8. **Compositional experiments.** Turn the cross-bundle dependencies into controlled hypotheses, ablations, observables, baselines, and rejection conditions.

### 2.2 What the bridge must not do

The chapter must not:

- claim that Fan and Lan specify a production Java architecture, database schema, event bus, or API contract;
- re-explain the internal B1–B6 mechanisms as if Chapter 18 were a replacement for Chapters 12–17;
- merge B1 and B3 into one ranking operation;
- merge B2's in-episode recovery with B5's cross-task skill governance;
- let workspace admission authorize tool execution;
- let B4's method authority override B6's action authorization or risk policy;
- let B6 silently amend the principal's goal;
- convert GraSP/B5 into another unresolved residual;
- claim that a D4 component validates an entire bundle or that the combined runtime has already achieved a measured improvement;
- present one universal monolithic cognitive architecture as the required destination.

### 2.3 Source mechanisms versus book-level engineering proposals

Every implementation contract, Java-like interface, event name, transaction strategy, state machine, and Product X sequence will be marked as a **book-level engineering proposal**. Source-described relationships and equations will be attributed to Fan and Lan. Historical mechanisms and modern baseline behaviors will retain the descriptions and limits already established in the preceding chapters.

---

## 3. Learning outcomes and central argument

By the end of the chapter, readers should be able to:

1. explain why the five residual bundles are related but not interchangeable;
2. distinguish the shared runtime state in Fan and Lan's synthesis model from the proposal produced by a language model and the authorized transition selected by a governor;
3. describe the exact cross-bundle dependencies in Figure 8 and the bounded synthesis runtime in Figure 9;
4. identify which component owns each state transition and which authority it does not possess;
5. explain why B5/GraSP is an existing implementation dependency and baseline rather than an open residual bundle;
6. reconstruct one end-to-end Product X trace while preserving goal, recovery, workspace, skill, uncertainty, and resource boundaries;
7. define experiments that isolate the contribution of an individual bundle, a dependency edge, and the full composition;
8. state what a successful or failed compositional evaluation would and would not establish.

**Central argument:** a production agent should not be assembled by placing five controls around one language model and assuming that they cooperate. Composition requires explicit state references, distinct control authorities, typed transitions, carefully scoped persistence, causal outcome attribution, and experiments that test interactions. The result should be a bounded runtime configuration whose components earn their complexity against strong simpler baselines.

---

## 4. Source discipline and synthesis boundaries

### 4.1 Fan and Lan is the only formal theoretical foundation for this chapter

The chapter's theoretical claims will be grounded in Fan and Lan's 2026 review. It will use the exact source labels `[Fan & Lan]` and the shared `\FanLanCite{...}` macro in the authored chapter. CoALA remains the separate foundation for Part I and must not be used to reinterpret Fan and Lan.

The historical mechanisms (ACT-R, Soar, LIDA, BDI, MIDCA, EPIC, Sigma, and ICARUS) have already been explained in the relevant preceding chapters. Chapter 18 may refer back to their role, but it will not reopen the historical survey or add another theoretical foundation.

### 4.2 Keep E and D independent and case-specific

The synthesis may recap E/D codes only where they clarify the composition. It must not assign one aggregate E/D code to an entire bundle or to the complete runtime.

The following distinctions must remain visible:

| Area | Source-grounded mapping that may be summarized | Boundary that must remain explicit |
|---|---|---|
| B1 | Adaptive memory systems include outcome-sensitive or value/cost-sensitive control; the mapping ledger reports high-depth instances such as E3/D4. | No reviewed case supplies the complete activation–latency–downstream-action-utility coupling. Do not imply every cited memory system has the same code or mechanism. |
| B2 | PALADIN and AgentDebugX provide typed diagnosis/recovery comparisons (E3/D3); Shepherd supplies a reversible branch comparison (E2/D3); AgentHER and Reflexion support failure learning (E3/D4). | These are distinct rows, not one unified Soar migration. No single cited baseline is credited with typed impasse, protected parent, typed return, and safe compilation as one chain. |
| B3 | Global Workspace Agents provides the workspace/broadcast correspondence (E2/D3); DyLAN and adaptive graph pruning provide learned team/topology selection (E3/D4). | A learned team or graph selector is not thereby content-level workspace broadcast or outcome-trained admission of typed content. |
| B4 | Hybrid BDI–LLM work (E1/D3), Devil's Advocate (E3/D3), Cognitive Control Architecture (E2/D3), and design-time meta-level adaptation (E3/D4) preserve different edges. | No aggregate code should erase the missing portable intention lifecycle and live method authority. Design-time adaptation is not live in-run method switching. |
| B6 | Resource schedulers and uncertainty-conditioned controllers provide functional control comparisons (typically E3/D3 in the source's mapping). | Existing controls remain locally owned; the residual is calibrated cross-stage propagation coupled to resource allocation, cognitive preemption/interruption, and stopping. |
| B5/GraSP | GraSP closes the candidate as E3/D4 for the mapped skill-governance chain. | E3 is functional approximation, not documented lineage; D4 is outcome-adapted control, not complete ICARUS migration or universal transfer. |

Where a chapter-level summary uses a code, it will state the specific mapped case and retained edge. The chapter will not treat D4 as a general quality score, nor E1 as a higher or lower maturity level than E3.

### 4.3 Scope of the synthesis claim

The chapter will distinguish four levels of statement:

- **Source finding:** what Fan and Lan explicitly map, code, close, or propose.
- **Chapter synthesis:** an explanatory account of how the source's dependencies relate to the preceding chapters.
- **Engineering proposal:** a possible runtime contract or implementation strategy created by this book.
- **Experimental hypothesis:** a causal claim that remains untested until a controlled experiment is run.

No source-level dependency will be described as proof of causal benefit. No local benchmark result from a modern system will be transferred to a different composite system without testing.

---

## 5. Proposed chapter structure

## Section 1 — From mechanism studies to composition

### 1.1 The end of the mechanism-by-mechanism tour

Open with the problem that an agent runtime may contain a memory policy, recovery controller, workspace, intention manager, scheduler, and skill executor, yet still lack a coherent way to govern their interactions.

A component inventory is not an architecture. A diagram with connected boxes is not a control contract. The reader must ask which state is shared, which subsystem owns each transition, what evidence is transferred, and which changes may affect later policy.

### 1.2 The five residual bundles and one closed case

Reintroduce B1, B2, B3, B4, and B6 in one compact table. Keep B5/GraSP in a visibly different row labelled **closed candidate / existing dependency**. Do not call it a sixth residual.

For each residual, summarize only:

- its unique state/control coupling;
- its insertion point;
- its strongest relevant modern baseline class;
- the unresolved coupling that the chapter-specific study leaves open.

Cross-reference Chapters 12–16 for the full mechanism analyses and Chapter 17 for GraSP. Avoid repeating their historical narratives, Java schemas, or benchmark results.

### 1.3 Why connected mechanisms can still conflict

Introduce the central synthesis problems:

- one subsystem may propose evidence while another controls whether it becomes shared context;
- one subsystem may diagnose failure while another owns the parent goal;
- one subsystem may select a method while another controls whether the selected action is safe and permitted;
- one subsystem may learn from outcomes while another determines whether those outcomes are attributable and reusable;
- one subsystem may stop local work while the parent intention remains active.

The section ends with the question that governs the chapter: what minimum shared runtime semantics and separate authority boundaries make a composition testable?

**Source anchors:** Fan and Lan, §§ VI-A–VI-D; Figures 8–9; Table V.

## Section 2 — A common runtime state, not a common authority

### 2.1 The seven-field lens from Chapter 10

Reuse the seven fields—state, control, transition, persistence, failure, learning, and resources/governance—as a recurring analysis grid. Explain that they are a structured comparison vocabulary, not seven sequential software stages.

### 2.2 Fan and Lan's shared state representation

Explain the synthesis state:

\[
 x_t = \langle i_t, w_t, m_t, s_t, u_t, b_t, q_t \rangle,
\]

where the source uses:

- \(i_t\): active intention;
- \(w_t\): bounded workspace content;
- \(m_t\): memory state;
- \(s_t\): compiled or reusable skills;
- \(u_t\): uncertainty state;
- \(b_t\): resource budget;
- \(q_t\): active failure or recovery substate.

Show how these state elements connect to Chapters 12–17. State explicitly that the tuple is the paper's compact synthesis representation, not a complete production database schema and not a claim that every mechanism owns every field.

### 2.3 Proposal, authorization, transition, and learning are different operations

Explain the source's distinction between an LLM proposal, the governor's authorized action, the runtime transition, and an outcome-dependent update:

\[
 p_t = \operatorname{LLM}(w_t, i_t, q_t),
 \qquad a_t = G(x_t,p_t),
\]

\[
 x_{t+1}=T(x_t,a_t,o_{t+1}),
 \qquad \theta_{t+1}=L(\theta_t,x_t,a_t,o_{t+1}).
\]

The text must be careful not to overinterpret the simplified proposal input. The key claim is that a model-generated proposal is not automatically an authorized state transition. The runtime's control locus must be explicit. Learning changes future control only when a measured outcome updates a policy or selection rule; storing an observation alone is not enough.

### 2.4 How the seven fields travel across a boundary

Introduce a compact worked handoff:

- a memory candidate carries provenance and value/cost metadata;
- a workspace decision carries the admitted cycle snapshot and recipients;
- a failure event carries a typed cause and parent-state reference;
- a recovery result carries a bounded, typed resolution;
- an intention decision carries goal/method versions and authority evidence;
- a resource decision carries reservations, uncertainty references, and action permission;
- a skill execution result carries graph version, verification receipts, repair history, and fallback status.

These are **book-level contract examples**, not structures supplied by Fan and Lan.

### 2.5 D3 control and D4 learning in a composite runtime

Show why a runtime can have many autonomous D3 transitions without learning, and why one D4 component does not establish that the entire composite runtime is D4. Outcome attribution must identify which policy changed and which later decision used the update.

**Source anchors:** Fan and Lan, § II-C–II-D; § VI-A; Chapter 10's seven-field representation.

## Section 3 — Responsibilities and authority boundaries

### 3.1 A composition matrix

The chapter should contain a full matrix with one row for each of B1, B2, B3, B4, B6, and the GraSP/B5 capability. Columns:

- authoritative state or object;
- control decision owned;
- trigger or insertion point;
- permitted output or transition;
- state/authority it must not mutate;
- evidence handed to adjacent mechanisms;
- persistence/learning responsibility;
- resource or safety boundary.

### 3.2 B1: memory accessibility is not workspace admission

B1 decides which memory items should be made accessible or proposed using activation, latency, downstream value, and maintenance cost. It may supply candidate memory to B3. It does not decide whether all candidate content should enter the shared workspace, and it does not authorize an external action.

### 3.3 B2: recovery owns a child problem, not the parent goal

B2 classifies an in-episode failure, preserves the parent state, opens a bounded recovery substate, and returns a typed resolution. B4 supplies the intention scope and invariant goal boundary. B6 supplies the wider budget, interruption, and stopping constraints. B2 cannot silently replace the parent goal or expand its authority.

### 3.4 B3: workspace admission owns shared availability, not execution permission

B3 chooses typed content under bounded workspace capacity, broadcasts the admitted coalition for a cycle, and connects downstream utility to later admission. It does not own the persistent memory lifecycle, execute a skill, or authorize tools. A broadcast is not an action approval.

### 3.5 B4: intention owns the goal boundary and method reconsideration

B4 retains the authorized intention and decides whether to continue, delegate, suspend, abandon, or switch method within its delegated authority. It may consume evidence from B1, B2, or B3. It cannot create permission for a high-impact action, bypass resource limits, or claim that an unverified observation satisfies the goal.

### 3.6 B6: risk and resource governance spans stages without taking over the goal

B6 carries uncertainty into budget allocation, verification, tool authorization, preemption, interruption, and stopping. It may deny or defer an action, request more evidence, or stop an execution under its policy. It does not rewrite the user's goal or select a new objective on the user's behalf. The B4 and B6 boundaries must remain distinguishable.

### 3.7 B5/GraSP: skill execution is an existing dependency, not a residual authority

GraSP provides a strong skill-governance path: confidence-conditioned routing, typed DAG construction, node-level pre/postcondition verification, bounded repair, and global replanning/ReAct fallback. In the composition, it can execute an authorized reusable skill or provide candidate artifacts. It does not own the parent intention, the workspace admission policy, or the global risk/resource budget. Its use remains subject to B4 scope and B6 authorization/resource gates.

### 3.8 The coordinator does not erase local authorities

Propose a coordinating runtime boundary that sequences events and validates cross-bundle invariants. It is not a super-agent with unrestricted authority. Its job is to route proposals, enforce version checks, request decisions from the proper governor, and commit only authorized transitions.

**Source anchors:** Fan and Lan, § VI-A, § VI-D, Figure 8; Chapters 12–17 boundary sections.

## Section 4 — Cross-bundle dependencies

This is the chapter's main theoretical synthesis section. It must follow Figure 8 and must not substitute a generic fully connected graph for the specific relationships Fan and Lan identify.

### 4.1 B4 scopes B2 recovery

An in-episode recovery branch needs to know which goal and parent state it must preserve. B4 supplies the commitment boundary; B2 supplies the typed recovery procedure. The proposed experiment is to compare B2 with and without B4 intention scope and measure goal drift, parent-state integrity, recovery success, and extra overhead.

### 4.2 B2 can provide verified resolutions to a GraSP-like governor

A successful B2 resolution may become a candidate reusable procedure only when the failure type, dependency structure, result type, and postconditions establish safe applicability. A recovery trace is not automatically a skill. The chapter must distinguish:

- a local resolution that completes one recovery episode;
- a reusable recovery rule compiled from a scoped, verified resolution;
- a generally invocable skill governed through GraSP-like retrieval, DAG validation, verification, bounded repair, and fallback.

The synthesis will present three trace-admission conditions for evaluation: admit no recovery traces; admit every apparently successful trace; admit only typed, independently verified B2 resolutions. This is a book-level experimental design that probes the paper's stated dependency, not a reported GraSP result.

### 4.3 B1 and migrated skills supply candidates to B3

B1 can propose accessible memory items and reusable skills can propose procedures or skill outputs. B3 operates over a broader candidate domain: memory evidence, tool observations, plan fragments, monitors, agents, and other typed content. It chooses what enters the bounded workspace. Its selection object and trigger remain distinct from B1's memory accessibility decision and GraSP's skill invocation decision.

### 4.4 Workspace evidence can trigger B4 reconsideration

A broadcast may reveal that the active method is failing, that a constraint changed, or that the goal may already be satisfied or impossible. This evidence can trigger reconsideration, but B3 does not own the intention or select the new method. B4 evaluates and authorizes the intention/method transition.

### 4.5 B6 governs risk and resources across the other controls

B6's role is cross-stage. It constrains the cost and risk of memory retrieval, workspace expansion, recovery attempts, skill invocation, verification, tool execution, interruption, and stopping. The chapter must not treat every subsystem's local capacity as the global resource budget. A workspace token limit, a B2 recovery attempt limit, a GraSP repair budget, and a global API/deadline budget have different owners and scopes.

### 4.6 The dependency graph is not a claim of one-way execution order

Figure 8 describes dependencies among mechanisms, not a rigid one-pass pipeline. Evidence and control can move iteratively: B3 may publish new evidence, B4 may reconsider, B2 may recover, B6 may reallocate resources, and another B3 cycle may occur. The chapter must preserve iteration and interleaving while keeping each transition's authority explicit.

**Required source relationships:**

- B4 scopes recovery;
- B6 governs risk and resources;
- B2 can produce verified resolutions for a GraSP-like governor;
- B1 and migrated skills supply candidate assets to B3;
- workspace evidence can trigger B4 reconsideration.

**Source anchors:** Fan and Lan, § VI-D, Figure 8, § VI-E, Figure 9; Chapter 13 § Boundaries; Chapter 14 § Dependencies; Chapter 15 § Cross-bundle boundaries; Chapter 17 § Boundaries and handoff.

## Section 5 — From dependencies to a safe implementation order

### 5.1 Why order matters

The paper warns that automatic skill compilation before state and failure boundaries are explicit can create shortcuts whose conditions cannot be audited. The chapter will explain the difference between a runtime dependency graph and an implementation sequence.

### 5.2 First externalize authoritative state

Proposed first implementation milestone:

- durable intention and goal/method version boundaries from B4;
- versioned uncertainty lineage and resource budgets from B6;
- typed recovery identity and parent-state isolation from B2;
- a persistent evidence and action ledger;
- explicit skill-library version and verification metadata for GraSP reuse.

The point is not to build every policy first. It is to make authority and state observable before adding adaptive behavior. The implementation must distinguish component-local limits (for example, workspace capacity, B2 recovery-attempt caps, or GraSP repair budgets) from the runtime-wide resource ledger (for example, total deadline, API calls, monetary cost, and reserved verification capacity). These budgets may constrain one another, but they are not interchangeable or additive without an explicit accounting rule.

### 5.3 Next add typed failure and bounded content admission

Implement B2's typed recovery boundary and B3's bounded workspace/broadcast cycle. These provide observable transitions and candidate/consumer receipts. Keep their scopes separate: a recovery substate protects parent problem solving; a workspace snapshot governs shared inference content.

### 5.4 Add adaptive memory and compiled-skill policies only after attribution exists

B1's learned memory policy and any skill-library learning need outcome attribution. A system must know which admitted evidence, authorized action, recovery result, and verified skill contributed to the outcome before it updates future selection. Otherwise, a failure or success may train the wrong component.

GraSP should be integrated as an already capable baseline, not re-created under a new residual label.

### 5.5 Integrate B6 across the lifecycle

The scheduler and authorization path must consume uncertainty lineage and resource reservations across stages. Interrupt/resume behavior must respect B2 child state, B4 intention lifecycle, and B5 execution boundaries. Stop decisions must distinguish goal satisfaction, impossibility, budget exhaustion, timeout, and safe escalation.

### 5.6 Stage gates

The proposed engineering sequence will end each milestone with concrete gates:

- state and authority audit;
- typed transition and parent-integrity tests;
- bounded-workspace and broadcast tests;
- verified-skill eligibility and repair/fallback tests;
- uncertainty/resource propagation tests;
- end-to-end composition and failure-injection tests.

These are a book-level roadmap, not a sequence prescribed by the papers beyond the broad ordering Fan and Lan propose.

**Source anchors:** Fan and Lan, § VI-D, especially implementation order and the warning about premature skill compilation; § VI-E.

## Section 6 — The bounded synthesis runtime

### 6.1 Reconstruct Figure 9 without turning it into a monolith

Describe the source's bounded synthesis runtime:

- the language model proposes or interprets;
- durable state lives outside one model call;
- memory and skills propose candidates;
- workspace admission limits the next inference context;
- the scheduler governs external actions;
- typed failure opens a recovery state;
- learning updates admission, memory, skills, and governance evidence.

Show that each edge has a reviewed D3/D4 predecessor in the bounded corpus, but the composition itself remains an unvalidated research target.

### 6.2 Proposed layered view for teaching

The book may reorganize Figure 9 into four explanatory planes, explicitly labelled as a teaching/engineering view:

1. **Durable intent and evidence plane:** goal/intention, memory records, audit events, skills, uncertainty lineage, resource ledger, recovery state.
2. **Candidate and workspace plane:** B1 retrieval candidates, skill candidates, tool/monitor/plan evidence, B3 competition and broadcast.
3. **Execution and recovery plane:** GraSP skill DAG, tool execution, B2 typed recovery, B4 method reconsideration.
4. **Governance plane:** B4 goal/method authority, B6 risk/resource/authorization/interrupt/stop policies, cross-bundle coordinator and audit.

Do not imply the paper prescribes these exact four planes. Explain how they make ownership and cross-boundary contracts legible.

### 6.3 No single shared mutable object

Propose a shared identity/reference model rather than one unbounded mutable record. Each mechanism retains its own authoritative aggregate and version. Cross-bundle messages carry stable identifiers, snapshots, evidence references, and expected versions. This limits accidental mutation and allows transactions to reject stale decisions.

### 6.4 Proposal and commit protocol

The model and specialized components may propose. The relevant authority evaluates the request, returns an explicit decision, and the coordinator commits an allowed transition only after version, invariant, budget, and permission checks. The chapter should distinguish:

- proposed action;
- selected method;
- authorized external action;
- dispatched operation;
- observed outcome;
- verified completion;
- learning update.

These are not synonyms and should not be collapsed into one `success` boolean.

---

## Section 7 — Proposed cross-bundle contracts and Java-oriented architecture

This section is an implementation bridge, not a second full tutorial for each bundle. It will connect the standalone contracts from Chapters 12–17 without rewriting all their fields.

### 7.1 Runtime identity and version references

The shared envelope should include, where relevant:

- `runId` and `correlationId`;
- `intentionId`, `goalVersion`, and `intentionVersion`;
- `workspaceCycleId` and `workspaceVersion`;
- `memoryRecordIds` and memory-policy version;
- `recoveryId`, `parentStateHash`, and recovery version;
- `skillLibraryVersion`, `skillGraphId`, and graph version;
- uncertainty estimate IDs, target definition, evidence references, and calibration version;
- resource reservation ID and budget-policy version;
- authorization decision ID and policy version;
- source event, timestamp, and causality/parent references.

Not every event carries every field. The envelope is a typed correlation boundary, not a reason to duplicate full state across all services.

### 7.2 Illustrative Java-like data contracts

The outline will include concise Java-like records or interfaces for:

- `RuntimeCorrelation`;
- `IntentionRef` and `GoalScope`;
- `EvidenceRef` and `UncertaintyRef`;
- `MemoryCandidate`;
- `WorkspaceCandidate` and immutable `WorkspaceSnapshot`;
- `RecoveryRequest`, `RecoveryResolution`, and `RecoveryReceipt`;
- `SkillInvocation` and `VerifiedSkillResult`;
- `ResourceReservation`;
- `ActionAuthorizationRequest` and `AuthorizationDecision`;
- `ControlProposal`, `ControlDecision`, and `CommittedTransition`;
- `OutcomeAttribution`.

Contracts should be small enough to show their invariants. They should avoid creating a single giant DTO that combines every mechanism's private state.

### 7.3 Separate governors and explicit decision ports

The proposed component interfaces should make these ownership boundaries visible:

- `MemoryPolicy` selects memory candidates and records retrieval/admission outcomes (B1).
- `WorkspaceGovernor` admits/broadcasts typed content and receives consumer/outcome receipts (B3).
- `IntentionGovernor` owns commitment, continuation/reconsideration, and method-switch decisions inside principal-granted authority (B4).
- `RecoveryController` owns the bounded child recovery lifecycle and typed result return (B2).
- `SkillGovernor` invokes the GraSP-like typed skill graph, verifies, repairs within limits, and escalates when required (closed B5 dependency).
- `RiskResourceGovernor` allocates budgets, authorizes or denies tools, and governs preemption/interruption/stopping (B6).
- `RuntimeCoordinator` routes decisions, validates cross-bundle references, and commits authorized transitions without acquiring the domain authorities of the governors.

### 7.4 Contract invariants

Required invariants include:

1. A workspace admission cannot mutate the goal or authorize a tool.
2. A recovery child cannot mutate its parent goal or verified parent facts directly.
3. A recovery resolution cannot become a reusable skill without eligibility checks and verification.
4. A skill graph cannot widen its invocation scope or external capabilities beyond the authorized intention and B6 gate.
5. A B4 method switch preserves the authorized goal identity/version unless a separate principal-authorized goal amendment occurs.
6. B6 can deny, defer, interrupt, or stop but cannot silently replace the goal.
7. Resource reservations are dimension-specific, versioned, and reconciled; workspace capacity and local repair limits are not treated as fungible global budget.
8. An outcome can update a future policy only when its evidence and causal attribution pass the configured acceptance rule.
9. A terminal stop result distinguishes verified success, verified impossibility, authorized abandonment, budget exhaustion, timeout, and unresolved uncertainty.
10. Every cross-bundle transition records the authority, policy version, evidence, prior state version, resulting version, and correlation ID.

### 7.5 Event sequence and transaction boundaries

Propose an event sequence for a composed run, while noting that independent work can interleave:

`TaskAuthorized -> IntentionActivated -> MemoryCandidatesRetrieved -> WorkspaceCycleOpened -> WorkspaceAdmitted -> SkillRouteSelected -> ResourceReserved -> ActionAuthorized -> SkillNodeStarted -> ToolObserved -> FailureClassified -> RecoveryOpened -> RecoveryResolved -> WorkspaceRefreshed -> IntentionReconsidered -> ResourceReallocated -> VerificationCompleted -> StopCommitted -> OutcomeAttributed -> PoliciesUpdated`.

The sequence is illustrative, not a universal mandatory pipeline. Events may be absent, repeated, or interleaved. The important requirement is that a transition has an explicit causal parent, expected versions, authority, and persistence behavior.

### 7.6 Persistence, transactions, idempotency, and concurrency

Discuss:

- append-only transition/audit events with mechanism-owned current-state aggregates;
- optimistic version checks and compare-and-set transitions;
- idempotency keys for retried event handlers and tool dispatch;
- transactional outbox/inbox patterns for external dispatch and event delivery;
- child recovery checkpoints with immutable parent references;
- immutable workspace snapshots per cycle;
- resource reservation/reconciliation that tolerates duplicate delivery;
- skill-library updates separated from a still-running invocation;
- outcome attribution delayed until authoritative results are available;
- replay and recovery after process restart.

State clearly that these persistence designs are proposed engineering choices. They are not part of Fan and Lan's published mechanism definitions.

### 7.7 Graceful degradation and partial composition

The runtime should not require every bundle for every task. A low-risk, short-lived task may not justify persistent B4 intentions or B3 content competition. If B3 is disabled, a simpler context selector may be used. If B1 adaptation is disabled, standard retrieval remains. If B2 compilation is disabled, a typed recovery can still complete without becoming reusable. If B6 calibration is unavailable, the system must fall back to conservative fixed limits and explicit authorization rules rather than pretending an uncalibrated estimate is reliable. GraSP remains a strong skill baseline when applicable.

The chapter should explain how degraded modes are declared and audited so that missing mechanisms are not mistaken for fully enabled bundles.

---

## Section 8 — Product X: one incident, several cooperating controls

The running example will unify the examples already used in Chapters 14–17 without replacing their individual worked examples.

### 8.1 Authorized goal and initial incident

A Product X payment request times out. The payment processor's settlement state is unknown; the service returns HTTP 500 responses; a monitor reports delayed provider notifications. The principal's authorized goal is to determine the status of the original payment and produce a verified incident report. The initial permission is read-only. The agent is not authorized to submit a replacement charge or restart the payment service.

The goal boundary and constraints come from B4. The example must not imply that an HTTP timeout proves that no charge occurred.

### 8.2 B1 retrieves candidate memories

B1 retrieves the provider's idempotency contract, the relevant operation-ID format, and a recent incident note. Explain activation/value/latency/cost as the memory-side decision. The resulting memories become candidates; they are not automatically the next shared context and do not authorize a retry.

### 8.3 B3 forms a bounded workspace cycle

Candidates may include:

- the original request and operation identifier;
- a read-only ledger observation;
- the provider-delay alert;
- the idempotency contract memory;
- a plan fragment to query the original operation before any retry;
- the agent's proposal to retry immediately.

B3 evaluates typed content under the cycle's workspace capacity. It admits the decisive evidence and relevant plan/monitor content, and records what is omitted. Broadcast makes the admitted coalition available to the next reasoning and monitoring cycle. The admission decision does not approve the proposed retry.

### 8.4 B4 preserves the intention

The intention retains the goal: determine the original payment state and report verified findings without creating a duplicate payment. A timeout is an outcome/method trigger, not proof that the goal is impossible or permission to replace it.

### 8.5 GraSP supplies an existing skill-governance path

The skill governor retrieves a suitable read-only reconciliation skill, compiles its typed DAG, and verifies node preconditions and postconditions. A representative graph may resolve the operation ID, query the provider, compare the ledger, and verify consistency. Its details are illustrative and must not be presented as an exact GraSP benchmark trace.

### 8.6 B6 authorizes and budgets the work

B6 consumes the uncertainty lineage for separate propositions (for example, whether the payment settled and whether provider delay explains the service errors), allocates read-only query and verification budgets, and authorizes the relevant tools. It denies the retry and restart proposals because they exceed the current authorization and are not justified by the evidence. It may preempt a low-priority summary to reserve capacity for a higher-priority verification task.

### 8.7 B2 opens a recovery substate after a typed failure

Suppose the provider-status query times out or returns an incomplete response. B2 classifies the failure, freezes the relevant parent snapshot, and opens a bounded child recovery state. The child may try an authorized read-only status endpoint or inspect the notification ledger, subject to B6's budget and permission decisions. It returns a typed resolution such as `STATUS_VERIFIED`, `STATUS_CONFLICT`, or `STATUS_UNRESOLVED` with evidence and parent reference.

The parent goal remains owned by B4. The recovery child cannot submit a charge or rewrite the intention.

### 8.8 New evidence can trigger reconsideration and workspace refresh

A verified ledger result or repeated provider timeout enters a new workspace cycle. B3 chooses the evidence needed for the next shared reasoning step. B4 may continue the current method or switch to another authorized read-only investigation method. B6 updates resource allocation and may interrupt cooperative low-priority work. These transitions can iterate; they are not a rigid one-pass script.

### 8.9 Stop with verified evidence or an explicit unresolved result

If the evidence proves settlement, the agent reports the original payment as settled and stops. If evidence supports a verified failure state, it reports that state. If the deadline expires while status remains unknown, it stops with an explicit unresolved/budget-exhausted result and escalates. It does not claim that the payment failed, the provider caused the incident, or the goal is impossible without evidence.

### 8.10 What the integrated trace demonstrates—and does not demonstrate

The worked trace demonstrates the proposed boundaries: B1 makes memories available; B3 controls bounded shared content; GraSP governs a reusable skill path; B2 handles typed in-episode recovery; B4 preserves goal and method authority; B6 governs risk, resources, authorization, interruption, and stopping. It illustrates a composition proposal. It is not empirical evidence that the full composition improves performance.

---

## Section 9 — Failure modes created by composition

The synthesis must identify failures that are not visible when each mechanism is studied alone.

### 9.1 Authority collision

Two governors issue inconsistent decisions, or the coordinator commits a transition that lacks the relevant authority. Require one owner per decision type and explicit conflict-resolution rules.

### 9.2 Goal drift through recovery or workspace content

A child recovery state or a compelling broadcasted proposal changes what the runtime pursues. Preserve B4 goal identity and require explicit reconsideration/authorization.

### 9.3 Duplicate or competing admission policies

B1 and B3 both rank content but optimize different objects. Prevent accidental double counting and keep memory accessibility separate from workspace admission.

### 9.4 Unverified recovery becomes a reusable skill

A locally successful workaround is generalized without its scope, preconditions, dependencies, or postconditions. Require B2 typed return and skill-library eligibility checks before GraSP-like reuse.

### 9.5 Skill execution bypasses global risk control

A valid DAG still exceeds the intention's scope, action permission, or resource budget. Require B4 scope and B6 gates at the actual external-action boundary.

### 9.6 Stale or misapplied uncertainty

An estimate for one proposition, target population, or calibration version is consumed by a different decision. Keep target identity, provenance, version, and freshness visible.

### 9.7 Resource double counting and starvation

Local workspace, recovery, repair, and global tool budgets are summed or reserved inconsistently. Use dimension-specific reservations, preemption semantics, and reconciliation.

### 9.8 Interrupt/resume breaks an invariant

A task resumes against stale intention, workspace, recovery, skill, or authorization state. Resume must validate referenced versions and reacquire permissions/reservations where required.

### 9.9 Incorrect causal attribution poisons learning

A positive outcome is attributed to the wrong admitted memory, skill, workspace coalition, or method. Delay updates until the outcome and causal evidence are sufficient; retain uncertainty about attribution.

### 9.10 Emergent loops and excessive reconsideration

A workspace broadcast triggers B4 reconsideration, which changes the method, which creates another workspace event, without progress. Add event causality, cooldowns or bounded review policies as engineering safeguards; evaluate whether these constraints hide necessary transitions.

### 9.11 Over-composition and the monolith trap

A low-risk task pays for every mechanism with no measurable benefit. Treat bundle activation as a task/context decision and compare against simpler partial configurations.

---

## Section 10 — Compositional evaluation: test the edges, then the system

### 10.1 The main research question

Does composing the residual mechanisms through their proposed dependencies improve task success, correctness, safety, or efficiency beyond the strongest individual mechanisms and simpler combinations, under matched conditions?

The chapter must explicitly say that the source paper proposes this agenda; it does not report results from a fully composed five-bundle runtime.

### 10.2 Source-prescribed experimental discipline

Preserve Fan and Lan's Appendix D requirements:

- hold base model, prompt, tools, environment, and task budget fixed within each comparison;
- instrument internal state and control transitions, not just final task success;
- preregister task population, experimental unit, model/dependency versions, stochastic replications, sample size, metric formulae, equivalence/non-inferiority margins, uncertainty intervals or statistical tests, exclusions, and stopping rule;
- define a matched simpler baseline as competitive only when it is non-inferior under the preregistered primary margin while using no more resources;
- publish negative results and internal traces needed to identify which edge failed.

### 10.3 Per-bundle ablations remain distinct

The paper requires at least three types of ablation for the proposed bundles:

1. remove the new state object;
2. remove the authoritative control edge while retaining logging;
3. remove the learning update while retaining the runtime transition.

Explain the distinct question each ablation isolates: representational state value, immediate control value, and adaptive value. They must not be collapsed into one generic “remove memory” or “remove agent” condition. Chapter-specific requirements from the preceding chapters remain in force.

### 10.4 Compositional ablation A: B2 with and without B4

Compare:

- typed B2 recovery with no persistent B4 intention boundary;
- B2 recovery constrained by B4 intention and goal invariants.

Measure recovery success, parent-state integrity, goal drift, unsafe scope expansion, completion, and overhead. This tests whether B4 prevents recovery from changing the parent objective while preserving B2's local recovery capability.

### 10.5 Compositional ablation B: B3 with native retrieval, B1, and B1 plus B6

Compare:

- native/simple retrieval feeding the workspace;
- B1 memory candidates plus B3 competition/broadcast;
- B1 plus B3 with B6 uncertainty/risk/resource signals.

Measure relevant-evidence density, decisive-evidence recall, rare-evidence suppression, workspace cost, downstream task success, verification burden, risk, and resource use. This separates memory-item value, heterogeneous workspace admission, and risk-aware admission.

### 10.6 Compositional ablation C: recovery-trace admission to GraSP

Compare three policies:

- no B2 recovery trace is admitted to the skill library;
- every apparently successful recovery trace is admitted;
- only typed and independently verified B2 resolutions with explicit conditions are eligible.

Measure repeated-failure reduction, skill invocation precision, unsafe or stale skill invocation, repair/fallback rate, and regression under changed task context. The design is a composition experiment; it is not a claim that GraSP's original paper tested B2-derived traces.

### 10.7 Additional interaction test: B4 with B6

Test whether intention-governed method switching and resource/risk governance cooperate. Measure unauthorized action rate, correct stopping, premature stopping, method-switch quality, resource use, and completion after interruption. Verify that B6 can veto or interrupt without taking ownership of the goal, while B4 cannot override B6 permission.

### 10.8 Full composition and staged comparison

Only after the pairwise/dependency experiments, evaluate a full composition containing B1, B2, B3, B4, B6, and the existing GraSP skill-governance dependency. Compare with:

- a strong simpler agent/runtime baseline;
- the strongest applicable individual baselines;
- staged compositions that add one dependency at a time;
- a composition with the GraSP capability disabled or replaced by the strongest fair skill baseline, where relevant.

Do not run an indiscriminate full factorial over every possible toggle unless sample size and task design support it. Prefer preregistered contrasts tied to specific dependency hypotheses.

### 10.9 Required internal trace

The evaluation trace should link:

- B1 memory candidates, activation/value/cost estimates, retrieval latency, inclusion, and downstream use;
- B3 candidate types, coalition/candidate selection, workspace capacity, broadcast recipients, consumer receipts, and admission-policy updates;
- B2 failure class, parent hash/version, child-state events, returned resolution, and compilation eligibility;
- B4 intention/goal/method versions, reconsideration trigger, diagnosis, decision, authority, and terminal outcome;
- B6 uncertainty target/provenance/calibration version, budgets, reservations, tool authorization, preemption/interruption, resume, and stop reason;
- GraSP skill/graph version, route confidence, pre/postcondition receipts, repair operations, verification, and fallback;
- shared task outcome, latency, resource ledger, and causal-attribution evidence.

### 10.10 Outcomes and metrics

Use the primary outcome and safety/efficiency measures from the relevant bundles, without pretending that every metric applies to every task:

- task success and verified completion;
- correct stopping, unresolved-but-honest stop, and premature stopping;
- relevant memory recall/use precision and downstream utility;
- relevant-evidence density and rare decisive-evidence recall;
- recovery by failure type, parent integrity, repeated-failure rate, and safe transfer;
- intention drift, method-switch quality, oscillation, and authority violations;
- calibration, selective risk, irreversible-action errors, help precision, verification cost, and interruption latency;
- skill invocation precision, graph verification failures, repair/fallback frequency, and safe reuse;
- latency, token/API/resource cost by dimension, interruption overhead, and failure/restart cost.

A single aggregate score must not hide a safety regression or a change in stopping behavior. Report per-task and per-bundle outcomes as well as system-level outcomes.

### 10.11 Falsification and narrowing criteria

The integrated hypothesis should be rejected or narrowed when:

- the full runtime is not non-inferior to a simpler baseline or consumes more resources without a commensurate gain;
- dependency edges do not change the decisions they are intended to govern;
- B4+B2 fails to preserve goal/parent scope;
- B1+B3 suppresses rare decisive evidence or does not outperform simpler retrieval;
- B6 adds verification/interruption cost without reducing risk or improving correct stopping;
- B2-derived skill admission increases unsafe reuse or no better than all/no trace policies;
- learning updates cannot be causally attributed;
- cross-bundle composition increases oscillation, deadlock, stale-state transitions, or external-action errors.

A negative result does not invalidate the individual mechanism studies. It narrows the conditions under which the composition is useful.

**Source anchors:** Fan and Lan, Appendix D; Table X; § VI-D–VI-E; Chapters 12–17 evaluation sections.

---

## Section 11 — B5 as a closed case inside an open composition agenda

### 11.1 Why the closed case belongs in the synthesis

B5 matters because it demonstrates that a proposed gap can disappear after adversarial closest-baseline screening. The synthesis must preserve this methodological lesson: before adding a new controller, compare the full required state/trigger/control/verification/fallback chain against the strongest existing system.

### 11.2 How GraSP participates without reopening B5

GraSP can serve as the skill-governance substrate in the composite runtime. Its invocation, typed DAG, per-node verification, bounded repairs, and planner fallback must be integrated with B4's goal/method scope and B6's resource/authorization controls. B2 may supply a verified recovery resolution that becomes a candidate skill input under explicit eligibility rules.

### 11.3 What remains open

The remaining research question is whether B1, B2, B3, B4, and B6 compose beneficially around the existing capability. This does not reopen B5. A future B5-adjacent proposal would need a materially new control relationship that remains absent after GraSP is treated as a mandatory baseline.

### 11.4 Three separate claims

Keep separate:

1. Fan and Lan's B5 closure within the frozen review corpus;
2. GraSP's reported empirical results in its own evaluated settings;
3. the book's proposed Java-oriented composition and any future reproduction/extension experiments.

No one claim proves the other two.

**Source anchors:** Fan and Lan, § II-E, § VI-B, § VI-C B5, Table V, Appendix C-O, § VII-C; GraSP primary paper as already reviewed in Chapter 17.

---

## Section 12 — What the synthesis establishes, and what remains unknown

### 12.1 Theoretical synthesis

The historical architectures contribute precise control invariants: memory accessibility and utility, typed failure and scoped recovery, bounded competition and broadcast, persistent intention and method authority, and the propagation of uncertainty through resource and stopping decisions. Modern systems show that many component edges are already operational. The remaining agenda concerns their coupling.

### 12.2 Engineering synthesis

A runtime can make these relationships testable by externalizing authoritative state, separating governors, connecting them through typed events, retaining audit/evidence references, and ensuring that learning follows verified outcomes. This is a design proposal, not a result established by the papers.

### 12.3 Scientific synthesis

The five residual bundles should be judged by strong closest baselines, per-edge instrumentation, compositional ablations, and rejection criteria. B5 shows the importance of closing a candidate rather than preserving it for narrative symmetry. The synthesis has no universal ranking of cognitive architectures and no presumption that all bundles belong in every application.

### 12.4 Limitations

Retain the review's limits:

- a bounded corpus frozen on 26 July 2026;
- no search-recall estimate;
- provisional single-coder E/D assignments and no reported inter-rater reliability;
- heterogeneous tasks, models, and experimental protocols across modern systems;
- no proof that five residual bundles are the only possible partition;
- no causal evidence that the full composition improves reliability or efficiency;
- no universal transfer conclusion from GraSP's benchmarks;
- a composite architecture may introduce overhead or unwanted coupling.

The book's Java-oriented composition must be presented as a proposal that requires implementation, independent review, and empirical testing.

---

## Section 13 — Chapter recap

The recap should leave readers with five conclusions:

1. Mechanisms compose through state, authority, transition, persistence, failure, learning, and resource boundaries—not merely because their components can be connected.
2. B1 and skills can supply B3 candidates, but memory accessibility, skill invocation, and workspace admission remain distinct decisions.
3. B4 scopes the parent goal and recovery boundary; B2 handles typed in-episode recovery; B6 governs cross-stage risk, resources, authorization, interruption, and stopping.
4. GraSP closes B5 and can participate as an existing skill-governance dependency, but it does not validate the remaining bundle composition.
5. Only controlled compositional experiments can establish whether the combined runtime is worth its state, control, learning, and resource costs.

The chapter ends Part II and hands the reader to Part III, where engineering systems can be built and evaluated using the mechanisms and boundaries established in this part. It must not introduce an additional theoretical framework or pretend that Part III implementations have already been completed.

---

## Section 14 — Review questions and exercises

The final chapter should include questions such as:

1. Why does a graph of connected components not prove that a runtime has a coherent control architecture?
2. What does each element of Fan and Lan's shared state tuple represent?
3. Why must a model proposal, an authorized transition, a committed state update, and a learning update be recorded separately?
4. How does B4 scope B2 recovery without taking over its local failure procedure?
5. Why can a B2 resolution become a candidate for GraSP-like skill governance only after verification and eligibility checks?
6. How does B1 differ from B3 even though both involve selection under constraints?
7. Why does B3 broadcast not imply permission to execute a tool or skill?
8. How does B6 constrain B4 and GraSP without owning the goal or skill semantics?
9. Why is GraSP included in the synthesis while B5 is excluded from the residual count?
10. What does E3/D4 say about the GraSP mapping, and what does it not say?
11. Which compositional ablation tests whether B4 prevents recovery-induced goal drift?
12. How do native retrieval, B1 candidates, and B1 plus B6 signals isolate different B3 contributions?
13. Why should all successful B2 traces not automatically be compiled into reusable skills?
14. What evidence is necessary before an outcome can update a future policy?
15. Give an example in which the full composition should be rejected in favor of a simpler runtime.

**Practical exercise:** Given the Product X payment timeout trace, draw the state/authority boundary for each mechanism. Label every proposal, decision, authorization, transition, verification result, and learning update. Then remove one cross-bundle dependency at a time and predict which invariant or outcome should change. State the strongest simpler baseline and a result that would falsify the proposed composition.

---

## Planned figures and Mermaid sources

All figures will be authored as editable Mermaid `.mmd` sources under `Tex/diagrams/source/part2/chapter18/`, use the shared diagram theme, include `accTitle` and `accDescr`, and be referenced using the shared `\\BookDiagram` macro. No TikZ or hand-drawn replacement diagrams will be introduced.

1. `part2-mechanism-map.mmd` — B1, B2, B3, B4, and B6 as residuals, with B5/GraSP visually marked as a closed existing dependency.
2. `shared-runtime-state.mmd` — the seven elements of the source's common runtime state, proposal, governor, transition, observation, and learning update.
3. `authority-boundaries.mmd` — the decision rights of B1, B2, B3, B4, B6, and GraSP, including explicit non-authorities.
4. `cross-bundle-dependencies.mmd` — faithful reconstruction of Figure 8's dependency relationships.
5. `implementation-order.mmd` — externalize authoritative state first, then typed failure and bounded content admission, then adaptive memory and compiled-skill policies, with integration gates.
6. `bounded-synthesis-runtime.mmd` — faithful source-level reconstruction of Figure 9, followed by the book's clearly labelled engineering interpretation in the prose.
7. `productx-composed-run.mmd` — integrated Product X incident sequence across memory, workspace, intention, skill execution, recovery, uncertainty/resource governance, and stopping.
8. `compositional-ablation-matrix.mmd` — B2/B4, B1/B3/B6, B2-to-GraSP trace admission, B4/B6, and full-composition comparisons.
9. `cross-bundle-state-handoffs.mmd` — typed references and versioned events crossing memory, workspace, recovery, intention, skill, and resource boundaries.

Each diagram's title and description must be specific enough to remain understandable outside the chapter. Diagrams are explanatory aids; the detailed contracts and evaluation conditions remain in prose and tables.

---

## Shared glossary and index plan

### 7.1 Glossary candidates

Before adding entries, inspect the shared glossary and reuse existing terms. Candidates for genuinely new or refined entries:

- compositional control;
- cross-bundle dependency;
- bounded synthesis runtime;
- authority boundary;
- outcome attribution;
- compositional ablation;
- partial composition;
- dependency-aware implementation order.

Reuse existing entries for activation, retrieval latency, utility, typed impasse, substate, chunking, workspace, broadcast, intention, reconsideration, method authority, uncertainty, calibration, resource budget, preemption, interruption, stopping, skill graph, verification, and fallback.

### 7.2 Index candidates

Add or reuse index terms for:

- mechanism composition;
- runtime state;
- governor / coordinator;
- authority boundary;
- B1–B6;
- cross-bundle dependencies;
- typed recovery;
- workspace admission;
- intention scope;
- uncertainty propagation;
- resource allocation;
- GraSP / B5 closure;
- outcome attribution;
- compositional ablation;
- implementation order;
- falsification.

Avoid duplicate definitions or using one term to refer to different authority boundaries.

---

## Source and attribution plan

### Primary theoretical source

**Fan, Haodi, and Zucong Lan.** “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942v1, 27 July 2026. <https://arxiv.org/abs/2607.23942>.

Principal anchors:

- § II-C–II-D for the seven-field mechanism representation and independent E/D axes;
- § II-E for the bounded/adjudicated claim boundary;
- § VI-A for common runtime semantics and the shared state/proposal/governor/transition/learning representation;
- § VI-B and Table V for the six initial candidates, merge/split logic, and B5 closure;
- § VI-C and Table VI for B1–B6 insertion points, baselines, and falsifiers;
- § VI-D and Figure 8 for cross-bundle dependencies and implementation order;
- § VI-E and Figure 9 for the bounded synthesis runtime;
- § VII-C for validity limits;
- Appendix B and Appendix C for case-specific mapping records;
- Appendix D for preregistration, internal traces, metrics, simpler-baseline matching, and minimum ablations;
- Appendix F for the bounded analytical evidence ledger.

### Existing chapter sources to cross-reference

- Chapter 9: why feature-level descriptions are insufficient.
- Chapter 10: seven-field mechanism representation.
- Chapter 11: historical and modern corpus, E/D axes, and validity boundaries.
- Chapter 12: B1 and the distinction between memory accessibility and B3 workspace admission.
- Chapter 13: B2 typed recovery, parent state, typed return, and condition-safe compilation.
- Chapter 14: B3 typed-content competition, bounded workspace, broadcast, and learning.
- Chapter 15: B4 intention persistence, reconsideration, and goal/method authority.
- Chapter 16: B6 uncertainty, resource vectors, authorization, interruption, and stopping.
- Chapter 17: GraSP, the closed B5 case, skill-governance boundaries, and the handoff to synthesis.

### Attribution rules

- Use `\FanLanCite{...}` for source-specific theoretical claims.
- Cite GraSP's primary paper only for GraSP's own graph, algorithms, experiments, ablations, and limitations; Chapter 17 already establishes the exact reference key and scope.
- Do not import new frameworks as parallel theoretical foundations.
- Mark the four categories—source finding, chapter synthesis, engineering proposal, and experimental hypothesis—where a reader could otherwise confuse them.
- Do not describe proposed Java records, control interfaces, transaction boundaries, Product X transitions, or compositional experiments as implemented facts from the papers.

---

## Explicit exclusions and chapter boundaries

Chapter 18 will not:

- retell all ten historical architectures or the full forty-two-system modern corpus from Chapter 11;
- reproduce the detailed B1–B6 internals from Chapters 12–16;
- re-teach GraSP's node types and five repair operators from Chapter 17 except where needed to explain its role as a dependency;
- introduce a sixth residual bundle or reopen B5 without new evidence;
- propose a new cognitive architecture as a replacement for all modern runtimes;
- claim universal superiority, causal benefit, or cross-domain transfer from local benchmark results;
- invent a global E/D score for the five bundles or for the composite runtime;
- assume a fixed one-pass pipeline when the source describes iterative runtime control;
- collapse intention authority, recovery authority, workspace admission, skill governance, and risk/resource authorization into one unrestricted controller;
- turn the Product X teaching trace into an empirical result;
- pre-empt Part III by claiming that the proposed synthesis runtime has already been built or validated.

---

## Proposed depth and acceptance criteria

### 10.1 Expected depth

This is the capstone of Part II, not a short recap. It should be a substantial chapter, approximately **8,000–11,000 words**, excluding references and index entries. The engineering bridge should be detailed enough for a Java engineer to identify subsystem contracts and implement an instrumented experimental shell, while leaving the detailed internal implementation of each individual bundle in its dedicated chapter.

### 10.2 Required content checks

The draft is acceptable only if:

- it covers B1, B2, B3, B4, and B6 as the five residuals and B5/GraSP as a closed dependency;
- it faithfully explains the source's shared runtime state and proposal/governor/transition/learning distinction;
- the authority matrix does not assign the same state transition to incompatible owners;
- it includes all Figure 8 dependencies and the source's implementation order;
- it distinguishes B1 from B3, B2 from B5, B4 from B6, and skill execution from action authorization;
- it includes the Product X end-to-end example with no unauthorized retry/restart;
- it identifies every implementation detail as a book-level proposal;
- it contains a compositional experiment for each source-specified dependency/ablation, plus full-system comparisons;
- it preserves the required minimum three ablation types and Appendix D preregistration controls;
- it includes strong closest baselines and explicit falsification conditions;
- it reports the bounded corpus, provisional coding, and absence of full-composition causal validation;
- all claims about E/D remain case-specific and independent;
- it does not imply that B5 has reopened or that all five residual bundles are proven.

### 10.3 Technical and editorial checks

Before delivery:

1. cross-check every dependency claim against § VI-D and Figures 8–9;
2. compare all boundary claims with Chapters 12–17 to avoid contradictions;
3. verify every GraSP/B5 statement against Chapter 17 and its primary-source distinction;
4. ensure no E/D code is generalized beyond the source row it describes;
5. compile with the repository's XeLaTeX/Biber workflow after approval;
6. generate actual Mermaid PNGs through the pinned CI renderer, not placeholder panels;
7. inspect all diagrams and representative PDF pages visually;
8. run scaffold, diagram, bibliography, glossary, index, and PDF-text checks;
9. preserve the shared preamble byte-for-byte;
10. report local checks and GitHub Actions gates separately.

---

## Outline decision and approval record

**Outline version:** 1.0  
**Status:** Approved by the author on 15 November 2026 after one minor-issues review pass.  
**Batch:** 9 of the author-approved nine-batch Part II plan.  
**Chapter:** 18 — *How the Mechanisms Work Together*.  
**Theory-to-implementation assessment:** A substantial composition-level bridge is required and specified above.  
**Prose drafting:** Authorized and in progress following the author's instruction to perform one minor-issues review pass and begin immediately.

**Approval record:** The author approved Outline v1.0 on 15 November 2026 and requested one minor-issues review followed immediately by complete LaTeX drafting. The review confirmed the scope and source anchors. Two clarifications were retained in the manuscript: (1) component-local capacity limits are distinguished from the runtime-wide resource ledger; (2) the four-plane architecture is explicitly a book-level teaching view, not Fan and Lan's own layer decomposition.
