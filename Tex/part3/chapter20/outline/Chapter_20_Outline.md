# Chapter 20 Outline — CoALA in Code: Memory, Actions, and Planning

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — *Engineering a Simulated Supply-Chain Agentic Application with Java*  
**Chapter:** 20  
**Outline status:** explicitly approved by the author on 25 November 2026; Chapter 20 prose drafted from this outline  
**Implementation basis:** the supplied `supply-chain-agent-main` Java repository snapshot inspected for this chapter  
**Teaching role:** translate the CoALA concepts already taught in Part I into the actual memory, action, and planning contracts used by the supply-chain application, without re-teaching the theory or moving Fan & Lan's mechanism analysis into the CoALA chapter.

## 1. Chapter purpose and central question

Parts I and II have already explained the concepts. Chapter 20 answers a narrower implementation question:

> When the application stores information, retrieves it, reasons over it, proposes a recovery action, and evaluates that proposal, which Java components own those responsibilities—and what do their contracts actually guarantee?

The reader should finish this chapter able to move from the CoALA concepts in Chapters 2–8 to the corresponding repository types and tests. The chapter is a code-reading bridge, not a second theory chapter and not a tour of the complete runtime graph.

The teaching sequence is:

1. memory: what the application retains and retrieves;
2. internal actions: how it retrieves, reasons, updates and records experience;
3. external actions: how it observes and requests changes in the simulated world;
4. planning: how trusted action candidates are generated, simulated, evaluated and returned;
5. boundaries: why none of these steps, by itself, authorizes or executes a state-changing action.

## 2. Learning outcomes

By the end of the chapter, readers should be able to:

1. Map CoALA's information-storage, action-space and decision-procedure dimensions to the application's actual components without assuming a one-box/one-class mapping.
2. Explain the distinct responsibilities of working, episodic, semantic and procedural memory in the Java implementation.
3. Distinguish exact cross-store retrieval from B1 activation/utility selection and from B3 workspace admission.
4. Trace the typed internal actions for memory retrieval, reasoning, working-memory update and episode recording.
5. Explain why a reasoning result is a bounded assessment rather than an action, a memory write, or a private chain-of-thought transcript.
6. Distinguish read-only perception from state-changing grounding in the simulator, referring back to Chapter 19 for dispatch and concurrency details.
7. Follow a `PlanningRequest` through a simulator-backed planning world model, a selected planning strategy, deterministic replay/evaluation and an auditable `PlanCandidate`.
8. Distinguish planner-method selection, candidate evaluation/selection, and authorization/dispatch.
9. Identify the implementation's deliberate approximations and missing adapters without attributing them to CoALA.

## 3. Relationship to the surrounding chapters

### Material to reuse briefly from Part I

- **Chapter 2:** the three CoALA dimensions and the distinction between the structural map and the decision procedure.
- **Chapter 3:** working, episodic, semantic and procedural memory; why the categories are not interchangeable.
- **Chapter 4:** retrieval, reasoning and learning as internal actions; why retrieval is not the same as use and recording experience is not the same as changing future policy.
- **Chapter 5:** perception, grounding, external observations and the feedback path.
- **Chapter 6:** action candidates, proposal and simulator-backed candidate generation.
- **Chapter 7:** evaluation versus selection and the possibility of rejecting a candidate.
- **Chapter 8:** planning/execution, iteration and the difference between internal candidate simulation and environmental feedback.

Use short reminders and explicit cross-references. Do not reproduce the CoALA diagrams, re-explain the memory taxonomy at the same conceptual depth, or repeat the Product X examples. Product X remains the Part I/II teaching example; this chapter uses the actual supply-chain types and test fixtures.

### Material already established in Chapter 19

Chapter 19 already explains the supply-chain domain, deterministic simulator, `SupplyChainSimulationWorld`, the in-memory compare-and-set adapter, the perception/grounding distinction, the ActionDispatcher's broad authorization/idempotency/precondition sequence, the eleven Maven modules, and the technology boundaries. Chapter 20 must deepen the CoALA mapping, not repeat those explanations. Refer back to Section 19.4 for the simulator transition model, Section 19.5 for the action/perception/grounding gates, and Sections 19.6–19.7 for the module and framework boundaries.

### Material reserved for later Part III chapters

- **Chapter 21:** B1 memory activation/latency/value/maintenance and B3 competition, bounded workspace admission, broadcast and outcome feedback.
- **Chapter 22:** B2 typed impasses, protected recovery subgraphs, parent-state integrity and separately governed recovery-procedure promotion.
- **Chapter 23:** B4 persistent intention/method authority and B6 uncertainty/resource/interruption/stopping governance.
- **Chapter 24:** full LangGraph4j graph composition, LangChain4j adapter wiring, PostgreSQL persistence/checkpoint boundaries and complete test-backed simulated workflow.

Chapter 20 may identify these later responsibilities to orient the reader, but must not teach their mechanisms prematurely.

## 4. Detailed section outline

### 20.1 From CoALA's three dimensions to the code

Open with the familiar CoALA questions, not a new glossary:

- **What information is maintained?** The memory module provides typed working and long-term memory models/services; retrieval exposes their contents through a query/result contract.
- **What can the agent do?** The action module registers typed internal, perception and grounding handlers. The planning module proposes sequences of eligible grounding actions.
- **How are operations coordinated?** Planning strategies and the cognitive-cycle service layer provide the application's decision logic; Chapter 24 will explain the complete LangGraph4j schedule and checkpointing.

Make two distinctions explicit:

1. CoALA's conceptual components do not map one-to-one to Java classes, Maven modules or processes.
2. The memory/action/planning modules are capabilities and contracts. Their availability does not itself define the exact runtime schedule; the full composed schedule belongs to Chapter 24.

**Figure 20.1 — CoALA dimensions mapped to implementation responsibilities.** Reuse the conceptual labels from Chapter 2, but show only the relevant actual modules/packages. Mark this as a responsibility map, not a deployment or exact Maven dependency diagram.

### 20.2 Memory in the application: four distinct responsibilities

Begin with the practical problem: a request, an observation, a verified past event, a domain fact and a reusable procedure should not be collapsed into one generic text history. Then explain only the implemented contracts.

#### 20.2.1 Working memory: active, scoped and versioned

**Code anchors:**

- `supply-chain-agent-memory/src/main/java/dev/supplychain/agent/memory/working/WorkingMemoryService.java`
- `WorkingMemorySnapshot.java`, `WorkingMemoryEntry.java`, `MemoryValue.java`, `Hypothesis.java`
- `WorkingMemoryRepository.java`

Explain that a `WorkingMemorySnapshot` is an immutable, scope-bound active context with an identifier, version, creation/update/expiry times, typed slots, hypotheses and the evidence references associated with the current content. `WorkingMemoryService.put`/`remove` require an expected version, enforce expiry and use repository compare-and-set. Replacing/removing a slot recomputes the current evidence set; a stale writer cannot silently overwrite a newer snapshot.

Show one small typed slot update, not the full class. Explain that the stored values are typed values/references—not a promise to retain every prompt or transcript. A hypothesis remains provisional until its evidence/status changes; a supported hypothesis requires supporting evidence.

Keep the three forms of state separate:

- the CoALA working-memory model (`WorkingMemorySnapshot`);
- the graph's execution/routing state (`CognitiveCycleState`);
- the persisted LangGraph4j checkpoint.

They may refer to one another, but they are not interchangeable. Detailed graph-state/checkpoint persistence is deferred to Chapter 24.

#### 20.2.2 Episodic memory: record experience without treating it as truth

**Code anchors:** `Episode`, `EpisodeEvent`, `EpisodeOutcome`, `EpisodeStatus`, `EpisodicMemoryService`.

Explain the implemented lifecycle:

- `record` creates a `RECORDED` episode with scope, entities, bounded events, provenance, evidence and an unverified-retention boundary;
- a model-derived episode must carry supporting evidence;
- a separate reviewer/evidence transition can verify or reject it;
- verified episodes can later be superseded while preserving their historical knowledge interval;
- exact retrieval returns verified episodes, not every newly recorded episode.

Use `EpisodicMemoryServiceTest.newlyRecordedEpisodeIsNotReturnedAsTrustedExperience` and `onlyExplicitlyReviewedEpisodeBecomesRetrievableExperience` as the two contrasting test examples. State clearly that an episode is selected experience, not a general application log and not automatically a reusable rule.

#### 20.2.3 Semantic memory: facts have provenance, status and time

**Code anchors:** `SemanticFact`, `FactKey`, `FactValue`, `FactStatus`, `SemanticFactRevision`, `SemanticAdmissionPolicy`, `SemanticMemoryService`.

Explain the staged/active/rejected/superseded lifecycle. A proposed fact is not active knowledge. The conservative default admission policy allows activation without human review only for `AUTHORITATIVE_SYSTEM` and `HUMAN_VERIFIED` provenance; other provenance types require an explicit review path. Replacements and temporal amendments are version-checked and repository operations preserve the previous timeline.

Distinguish:

- **valid time:** when the fact is true in the modeled world;
- **knowledge time:** when the application knows/records the fact or revision.

Use one small, domain-relevant example (such as a supplier capability validity interval) but do not invent an actual supplier fact and present it as repository data. Use `SemanticMemoryServiceTest.validTimeFiltersFactsSeparatelyFromKnowledgeTime` and `modelDerivedFactCannotBeActivatedWithoutHumanReview` as evidence.

#### 20.2.4 Procedural memory: governed procedure versions, not an executable skill graph

**Code anchors:** `ProcedureVersion`, `ProcedureKind`, `ProcedureStatus`, `ProcedureArtifactReference`, `ProceduralMemoryService`.

Explain the explicit lifecycle `DRAFT → VALIDATED → ACTIVE`, followed by `RETIRED`, with `REJECTED` as a separate terminal review outcome. Validation and activation are distinct transitions with reviewer/approver identities and lifecycle revisions. A new version may replace an older active version under repository rules.

State the boundary precisely: this is versioned procedural knowledge/artifact governance. It is not GraSP's skill retrieval, typed-DAG compilation, node verification, local repair and fallback chain. B5/GraSP is the closed candidate from Part II, not a mechanism this application claims to implement.

Use `ProceduralMemoryServiceTest.draftProcedureIsNotAvailableAsAnActiveCapability` and `activationRequiresValidationAndExplicitApprover` as tests.

#### 20.2.5 Exact cross-store retrieval: the seam before B1 and B3

**Code anchors:** `MemoryRetrievalQuery`, `MemoryRetrievalResult`, `MemoryRetrievalService`, `MemoryRetrievalAction`.

Explain what the service actually returns:

- an optional working-memory snapshot after scope/expiry checks;
- verified episodic records;
- active semantic facts filtered by entity/predicate and valid/known times;
- active procedural versions at the requested knowledge time.

**Critical distinction:** `MemoryRetrievalService` is an exact, deterministic, scoped lookup. Its source comment explicitly says it does not implement B1 activation scoring. Retrieval does not itself rank candidates by B1 value/latency, create a B3 workspace, or automatically write every returned record into working memory. The later cognitive decision path transforms retrieved evidence into a candidate-selection/workspace flow; Chapter 21 explains B1 and B3.

Use `MemoryRetrievalServiceTest.exactRetrievalCombinesAllFourCoalaMemoryResponsibilitiesWithoutB1Scoring` as the principal test anchor. Explain its scope-isolation assertion as a memory boundary, not a relevance-quality benchmark.

**Figure 20.2 — Four memory responsibilities and exact retrieval result.** Show distinct write/review lifecycles and the typed retrieval result. Draw B1 selection and B3 workspace admission as later stages outside this figure (or faded/dashed and labelled “Chapter 21”).

### 20.3 Internal actions: retrieval, reasoning and learning are separate operations

Introduce an internal action as an operation over the agent's information/decision process, contrasting it with an external action that interacts with the simulated environment. The action descriptor/handler contract already introduced in Chapter 19 is reused here to show how CoALA's internal action types become callable, typed operations.

#### 20.3.1 Retrieval action

Show `MemoryRetrievalAction` as a read-only internal handler delegating to `MemoryRetrievalService`. Its descriptor identifies the internal category, read-only effect and memory-retrieval capability. The output is a typed `MemoryRetrievalResult`; retrieval alone is not a working-memory write.

#### 20.3.2 Reasoning action

**Code anchors:** `ReasoningAction`, `ReasoningProvider`, `ReasoningRequest`, `ReasoningAssessment`, `ReasoningConfidence`.

Explain the application-owned provider port and bounded request/response:

- the request supplies an explicit task, bounded context and a deduplicated list of evidence references;
- the assessment contains a summary, evidence-backed findings, hypotheses, assumptions, supporting evidence, information gaps, confidence and concise rationale;
- the action rejects citations not present in the request;
- the descriptor is internal and read-only; it cannot add a grounding capability or authorize a world change.

The assessment is not a private chain-of-thought transcript. It is a bounded, structured result. Do not imply that the application persists hidden model reasoning. A LangChain4j adapter exists for the `ReasoningProvider` port, but its wiring and provider configuration belong to Chapter 24. Do not confuse this reasoning provider with the separate `SequentialDecisionProvider` used by the sequential planner.

#### 20.3.3 Working-memory update and learning actions

Show that reasoning output does not mutate memory implicitly. `WorkingMemoryUpdateAction` is a separate memory-write action with scope, expected-version and expiry preconditions. `EpisodeLearningAction` records an episode as unverified; it cannot verify or promote its own record. The expanded `LearningActionCatalog` exposes separately authorized review/proposal/lifecycle operations for episodic, semantic and procedural memory.

The implementation has explicit persistent memory writes and governed review paths. Do not claim automatic model fine-tuning, self-modifying agent code, or that every experience automatically changes future policy. These distinctions connect directly to Part I Chapter 4's learning boundaries.

**Figure 20.3 — Internal action sequence.** Show retrieval → evidence-bounded reasoning → separate working-memory update and/or episode recording. Show review/admission as a separately authorized lifecycle, not as an automatic consequence of reasoning.

**Test anchors:** `CoalaInternalActionsTest` (especially `workingMemoryUpdateIsScopedVersionedAndIdempotent`, `episodeLearningRecordsButDoesNotSelfVerify`, and `reasoningActionRejectsEvidenceReferencesNotSuppliedByCaller`); `LearningActionCatalogTest`.

### 20.4 External actions in CoALA: perception and grounding in the modeled world

This section maps Chapter 5's terms to the existing action types without re-teaching the full grounding taxonomy or repeating Chapter 19's dispatcher sequence.

- Perception: `SupplyChainPerceptionActions` exposes read-only handlers for supplier, inventory lot, customer order, shipment, available inventory and quality disposition through `SupplyChainPerceptionPort`.
- Observation: `Observation<T>` carries the value, entity reference, evidence reference, provenance and source snapshot version. It is evidence about a particular modeled snapshot, not an unversioned assertion.
- Grounding: `SupplyChainGroundingActions` exposes typed state-changing requests (reserve/release inventory, place purchase order, reroute shipment) against `SupplyChainSimulationWorld`.

Use one paired example: reading lot availability produces a provenance-bearing observation; reserving the lot is a separate grounding action that asks the simulator-backed world adapter to apply a state transition. The latter is not committed merely because a planner produced a `PlanningAction`.

Refer back to Chapter 19 for the complete `ActionDispatcher`, capability, idempotency, expected-version and conditional human-approval sequence. Chapter 24 will show how the application graph composes those boundaries. Do not repeat those gates in full here.

**Figure 20.4 — Perception result versus grounding request.** Emphasize observation/evidence on one side and a typed state-changing request on the other; refer to the Chapter 19 figure for dispatch details.

**Test anchor:** `SupplyChainExternalActionsTest`, selected to demonstrate typed read-only observations and simulator-backed writes, not real ERP/carrier integration.

### 20.5 Planning: a candidate path over an isolated simulated state

Start with the Part I Chapter 6 question: how does the application turn a recovery objective and current evidence into possible action sequences?

**Core contracts:**

- `PlanningRequest`: binds an objective, initial snapshot, working-memory snapshot, evidence, permitted action definitions, hard constraints, scoring/risk/authority policies, complexity and a bounded `PlannerBudget`.
- `PlanningState`: holds the objective, root world version, current simulated snapshot, immutable action path and accumulated evidence. Its invariant requires the world version to advance exactly once per action in the path.
- `PlanningAction`: binds a planning identifier, action descriptor, typed recovery action, simulator command, impact estimate, supporting evidence and assumptions.
- `PlanningActionProvider`: supplies currently applicable actions deterministically for a versioned request/state.
- `PlanningWorldModel`: creates the initial state, lists eligible actions and applies one proposed transition.
- `SimulatorBackedPlanningWorldModel`: delegates branch transitions to the deterministic `SupplyChainSimulator`, validates the action against request definitions/proposal scope and checks that the domain action matches its simulator command. Domain/argument rejection is returned as `WorldTransition.Rejected` rather than committed to the current environment.

The central teaching distinction is between two uses of the same simulator logic:

1. **Planning rollout:** applies proposed transitions to immutable branch states while exploring candidates. It does not update the current `SupplyChainSimulationWorld`.
2. **Grounding execution:** later sends an authorized action through the action dispatcher and world adapter to change the current modeled environment.

Planning is therefore a decision-support procedure, not a side-effecting execution shortcut. The planner receives only request-scoped grounding/domain-write action definitions; it does not invent arbitrary operation types outside the trusted proposal scope.

**Code anchors:** `PlanningRequest.java`, `PlanningState.java`, `PlanningAction.java`, `PlanningWorldModel.java`, `PlanningActionProvider.java`, `SimulatorBackedPlanningWorldModel.java`, `WorldTransition.java`.

**Figure 20.5 — Candidate branch versus current world.** Show one root snapshot copied into isolated planning states; candidate transitions create child states through the simulator; only the later grounding path can advance the current world adapter.

### 20.6 Three planning strategies behind one contract

Present the implementations as three application algorithms that satisfy `PlanningStrategy`, not as three new theoretical foundations and not as algorithms prescribed by CoALA.

- **Sequential baseline — `SequentialReasoningPlanner`.** Repeatedly requests one next action from an injected `SequentialDecisionProvider` and constructs a linear path; it does not branch into a search tree. It explicitly does not support resumable search sessions. The provider is a port. The repository's planning module contains the interface and deterministic test providers, but no concrete production `SequentialDecisionProvider` adapter in the app/runtime main sources was found in the inspected snapshot. Do not claim that this planner automatically calls LangChain4j. A future/injected provider may declare itself model-backed, but that is a separate adapter decision.
- **Bounded alternative search — `ThoughtSearchPlanner`.** Expands a bounded number of structured successor actions, evaluates successors, and prunes by the configured branching factor/beam width and planner budget. `DeterministicThoughtActionRanker` is the default ranker in the source constructor; a different `ThoughtActionRanker` may be injected. Use “ToT-inspired” only as the code's descriptive label, not as a claim of reproducing a separate research system.
- **Domain-grounded MCTS — `MctsSearchPlanner`.** Performs bounded seeded expansion, UCT selection, simulator-backed transitions, rollouts and reward backpropagation. The class's result description explicitly says it is an adaptation and not a faithful RAP reproduction. Use “RAP-inspired” only as a descriptive implementation label.

All three implement the same `PlanningStrategy.plan(PlanningRequest)` contract and return `PlanningResult` with candidates, termination reason, statistics, session identity, selection explanation and trace. Explain the algorithm differences through one compact comparison table and one representative short code excerpt, not three full class listings.

**Planner-method routing:** `PlannerRouter` chooses one registered strategy through `DefaultPlannerSelectionPolicy`, based on planning complexity and budget, unless a request carries a planner-selection override. This is different from evaluating/selecting a candidate. B4's authority over persistent method changes is reserved for Chapter 23; here only identify the routing seam.

**Test anchors:** `SequentialReasoningPlannerTest.sequentialPlannerBuildsOneLinearCandidateWithoutBranching`; `ThoughtSearchPlannerTest.expandsStructuredAlternativesAndReturnsRankedCandidates`; `MctsSearchPlannerTest.runsSeededMctsWithBoundedRolloutsAndTraceStatistics`; `PlannerRouterTest`.

**Figure 20.6 — Common planner contract, different search behaviors.** Show one request/response contract with a linear path, bounded branching/beam, and MCTS exploration. Do not draw the planner as executing actions.

### 20.7 Evaluation and selection: a high score is not permission

Relate the implementation to Part I Chapter 7's separation between evaluation and selection.

**Code anchors:** `CandidateEvaluator`, `DeterministicCandidateEvaluator`, `PlanEvaluation`, `PlanCandidateFactory`, `PlanCandidate`, `PlanningResult`.

Explain the deterministic evaluator's important steps:

1. check the objective and root-world version;
2. replay the proposed action path from the trusted initial state through the world model;
3. require each action to remain available and match its trusted definition;
4. compare the replayed world against the state claimed by the candidate;
5. check hard constraints, deadline, risk and estimate consistency;
6. calculate a transparent weighted score from fulfillment progress, normalized cost, timeliness, risk and robustness.

Be precise about the difference between feasibility and governance. `PlanEvaluation.approvalRequired` records a downstream requirement; it is not itself a planning infeasibility violation. A feasible candidate remains only an auditable proposal. Approval, action capability authorization and dispatch occur later.

Include one explicit limitation: if `PRESERVE_PROTECTED_CUSTOMER_COMMITMENTS` is requested, the current domain model cannot verify it and the evaluator fails closed. This is an engineering limitation surfaced honestly by the implementation, not a guarantee that the objective was checked successfully.

Keep three distinct selections separate:

- **planner-method selection:** which strategy runs (`PlannerRouter`);
- **candidate evaluation/selection:** which proposal is feasible/preferred (planner/evaluator and later decision services);
- **execution authorization:** whether a particular candidate may proceed to dispatch (Chapter 19 boundary, composed in Chapter 24).

**Test anchors:** `DeterministicCandidateEvaluatorTest.acceptsSimulatorReplayedPlanAndMarksApprovalAsGovernanceRequirement`, `rejectsAPlanWhoseClaimedStateDoesNotMatchSimulatorReplay`, `rejectsPlanExceedingHardRiskThreshold`, and `failsClosedWhenProtectedCommitmentConstraintCannotBeVerifiedByCurrentDomainModel`.

**Figure 20.7 — Proposal, evaluation, candidate selection and authorization are separate.** The last authorization/dispatch box should be shown as a downstream boundary, not part of the planner.

### 20.8 One bounded code trace: from memory result to plan candidate

Do not claim that one unit test proves the entire integrated application path. Build a transparent, source-grounded trace by connecting focused test-backed operations:

1. open/load an execution-scoped working-memory snapshot;
2. issue an exact `MemoryRetrievalQuery` and inspect the four typed result groups;
3. pass an explicit context/evidence set to `ReasoningAction` and inspect the bounded assessment;
4. construct a `PlanningRequest` bound to the objective, snapshot, working memory, action definitions, constraints, policies and budget;
5. create the root `PlanningState`, request available actions and apply one candidate through `SimulatorBackedPlanningWorldModel`;
6. replay/evaluate the branch and construct an auditable `PlanCandidate`;
7. stop before approval or grounding execution.

The trace is a pedagogical composition of actual contracts and component-test fixtures, not a claim that these isolated tests jointly constitute one end-to-end run. The fully assembled application path and its precise test boundaries belong to Chapter 24.

### 20.9 Chapter recap and transition

Close with a compact table mapping each CoALA responsibility to its implementation contract and the boundary that remains important:

- memory is typed, scoped and governed;
- retrieval is exact and distinct from B1 selection;
- reasoning returns evidence-bounded assessment, while memory write-back is a separate action;
- perception returns provenance-bearing observations, while grounding requests a simulated state change;
- planners operate over isolated simulator-backed branches and return proposals;
- evaluation and selection do not grant execution permission.

Transition to Chapter 21 by explaining that exact retrieval supplies candidate memories, but the next question is which candidates should receive scarce context/workspace capacity and how downstream use/outcomes influence future retrieval. That is where B1 and B3 begin.

## 5. Code presentation plan

Follow the book's established teaching sequence: **problem → concrete supply-chain example → CoALA term recalled briefly → typed contract → selected implementation excerpt → call path → failure/boundary → test evidence**.

Use approximately 6–8 compact listings across the chapter:

1. `WorkingMemoryService.put` or the `WorkingMemorySnapshot` update contract (version/TTL/evidence).
2. The transition/status excerpt for one governed long-term memory type (prefer `Episode.verify` or `SemanticMemoryService.activateTrusted`).
3. `MemoryRetrievalService.retrieve` (exact retrieval boundaries).
4. `ReasoningAction.execute` (bounded provider call and evidence-citation validation).
5. One external action descriptor/observation record (only to map perception/grounding to CoALA; defer dispatcher mechanics to Chapter 19).
6. `PlanningState.advance` or `PlanningWorldModel` contract.
7. `SimulatorBackedPlanningWorldModel.apply` (branch transition, not world commit).
8. `DeterministicCandidateEvaluator.evaluate` score/feasibility outcome, with the full scoring code summarized rather than dumped.

Avoid full classes, source screenshots, and long listings of constructors/validation boilerplate. Prefer a short collaboration/sequence diagram and a compact “where to read it” table.

## 6. Tests and evidence boundaries

Use focused tests as executable examples:

| Test | What it supports | What it does not establish |
|---|---|---|
| `WorkingMemoryServiceTest` | Scoped versioning, typed slot/evidence updates, expiry and stale-write rejection | A universal memory architecture or a general memory-quality result |
| `EpisodicMemoryServiceTest` | Record/verify/reject/supersede lifecycle and evidence boundary | Automatic truth or automatic future-policy learning |
| `SemanticMemoryServiceTest` | Provenance admission, human review, revision and valid-time/known-time behavior | General truth of a fact beyond its supplied evidence |
| `ProceduralMemoryServiceTest` | Versioned draft/validate/activate/retire/reject lifecycle | GraSP skill-DAG execution or automatic skill discovery |
| `MemoryRetrievalServiceTest` | Exact scoped retrieval across four memory responsibilities without B1 scoring | B1 utility selection or B3 workspace admission |
| `CoalaInternalActionsTest` | Typed internal actions, scope/version/idempotency and evidence-citation checks | Live model quality or full application composition |
| `SupplyChainExternalActionsTest` | Typed perception/grounding actions against the simulator adapter | Real external supplier/carrier/ERP behavior |
| Planner component tests | Linear, bounded-search and seeded MCTS behavior within configured budgets | Empirical superiority of one strategy or a faithful reproduction of CoT/ToT/RAP research systems |
| `DeterministicCandidateEvaluatorTest` | Replay checks, hard-risk/deadline checks, scoring and fail-closed handling of unsupported constraints | That every possible business constraint is modeled |
| `CognitiveCycleGraphTest` | Graph control-flow behavior using scripted operations | The full service composition or the durable host's production wiring |

Use a full-graph/evaluation test only if a specific assertion is needed to illuminate the boundary. Do not use `M8B4FullGraphWorkflowTest` as proof that every real-model adapter or all production providers were exercised. Do not say the test `CognitiveCycleGraphTest` is the full application: it uses `ScriptedOperations` to test graph control flow.

## 7. Important implementation qualifications that must appear in the prose

1. `MemoryRetrievalService` performs deterministic exact lookup; it is not the B1 selector and does not implement activation, retrieval-latency or downstream-utility scoring.
2. Retrieved items are not automatically projected into `WorkingMemorySnapshot`. The integrated decision pipeline transforms retrieved evidence through later selection/admission services; Chapter 21 covers B1/B3.
3. `ReasoningAction` is read-only and evidence-bounded. `ReasoningAssessment` stores a structured result and concise rationale, not private chain-of-thought traces. Updating working memory and recording an episode are distinct actions.
4. Episodic records are unverified on creation; semantic facts require the configured admission path; procedures require validation and activation. No automatic memory promotion or model fine-tuning should be implied.
5. The `SequentialDecisionProvider` is an injected planner port. The inspected app/runtime/planning main sources do not contain a concrete production LangChain4j implementation for it; tests use deterministic providers. Do not write that the sequential planner automatically invokes LangChain4j.
6. The LangChain4j `ReasoningProvider` adapter and the sequential planner's `SequentialDecisionProvider` are separate interfaces and must not be conflated.
7. `DurableCognitiveApplicationHost` receives the `PlanningWorldModel`, `CandidateEvaluator` and `List<PlanningStrategy>` through its `Ports`; it routes among supplied strategies rather than constructing all planner implementations itself. Chapter 24 will explain that composition boundary.
8. `PlanningRequest` limits planning action definitions to registered `GROUNDING` actions with `DOMAIN_WRITE` effects inside the trusted proposal scope. The planner does not authorize or execute those actions.
9. `approvalRequired` is a downstream governance flag on `PlanEvaluation`; it is not a reason by itself to mark a candidate infeasible.
10. The evaluator fails closed when the current domain model cannot verify `PRESERVE_PROTECTED_CUSTOMER_COMMITMENTS`.
11. Planner labels `COT_SEQUENTIAL`, `TOT_BOUNDED_SEARCH`, and `RAP_INSPIRED_MCTS` are implementation identifiers. They do not introduce additional theoretical foundations and do not assert canonical reproductions of those research approaches.
12. The deterministic simulator determines modeled domain transitions. A model-backed provider used for reasoning/planning is not thereby deterministic.

## 8. Source and theory boundary

The theoretical reminders in this chapter must be grounded in [CoALA], principally the structural/decision procedure in Section 4 and the memory/action/planning subsections introduced in Chapters 2–8. Cite the original sections/figures, not Part II's later mechanism vocabulary, when describing CoALA.

The Java classes, data contracts, exact memory retrieval, action catalog, planning algorithms, simulator-backed world model, scoring policy and tests are engineering decisions in the supplied repository. CoALA does not prescribe these class names, APIs, Maven modules, planner algorithms, action dispatcher, score weights, LangGraph4j topology or PostgreSQL schema. Fan & Lan bundles must not be used to reinterpret the original CoALA framework in this chapter.

Use only the book's formal source labels `[CoALA]` and `[Fan & Lan]`. Chapter 20's primary source citation should be `[CoALA]`; reference later Fan & Lan chapters only as a roadmap, not as the theoretical basis for the CoALA explanation.

## 9. Author decision and drafting status

**Approved:** the author explicitly approved this detailed outline on 25 November 2026. Chapter 20 prose was drafted from this approved scope. No additional outline decision remains open.
