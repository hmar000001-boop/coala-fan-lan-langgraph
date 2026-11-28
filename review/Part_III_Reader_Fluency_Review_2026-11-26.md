# Part III — Complete Review of Learning Fluency, Reader Comprehension, and Code Alignment

**Review date:** 26 November 2026  
**Scope:** Chapters 19–24 only. Chapter 24 is the final chapter of Part III.  
**Book repository:** `coala-fan-lan-langgraph-main`  
**Application repository:** `haythemabr/supply-chain-agent`  
**Application snapshot reviewed:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Review type:** editorial, pedagogical, structural, source/code-alignment, and repository-structure review.

> **Important qualification:** The learning-fluency scores below are editorial judgements based on chapter structure, concept sequencing, code density, worked examples, exercises, and the observed implementation. They are not results from a controlled learner study. A short reader-comprehension test is proposed near the end of this report.

---

## 1. Executive verdict

Part III has the right overall teaching sequence and a technically credible application. It moves from the modeled supply-chain world, to CoALA's architecture in code, to the mechanism families, and finally to the composed application and its recovery evidence. The order is sound and should be preserved.

The main weakness is **learning fluency inside the chapters**, not the high-level order. The reader is asked to carry too many labels, state owners, persistence boundaries, mechanism qualifications, and test caveats at once. Several chapters explain the right things but do not always establish a sufficiently simple mental model before introducing implementation detail. Chapter 21 and Chapter 23 are the heaviest. Chapter 24 is a strong integrative ending, but it needs a more explicit capstone that makes the reader demonstrate the complete system model.

My overall assessment for a reader who has completed Parts I and II is **7.3/10 for learning fluency**:

- **Strong:** architectural progression, fidelity to the supplied Java code, explicit limits on what tests prove, separation of theoretical mechanisms from engineering choices, and source traceability.
- **Needs work:** reader orientation, concept hierarchy, terminology control, code-navigation guidance, repetition, and active synthesis at the end.
- **Not recommended:** reducing technical depth, rewriting the six chapters from scratch, or splitting Part III into more chapters. The existing six-chapter progression is coherent.

The central editorial recommendation is to retain the engineering detail but add a clearer teaching layer: one stable mental model, a repeated explanation pattern for each mechanism, short transitions that state what the reader already knows and what is new, and a final capstone based on the actual test evidence.

## 2. Exact scope and repository correction

Part III consists of exactly these six chapters:

| Chapter | Title | Primary learning responsibility |
|---|---|---|
| 19 | Engineering Foundations for Request-Driven Enterprise Agentic Systems | Understand the business domain, deterministic simulator, invariants, action boundary, modules, and evidence limits. |
| 20 | CoALA in Code: Memory, Actions, and Planning | Map CoALA's memory, internal/external action, and decision procedure dimensions to the application. |
| 21 | Memory Selection and Workspace Competition: B1 and B3 | Understand memory selection (B1), then workspace admission/broadcast/feedback (B3). |
| 22 | Typed Impasses and Protected Recovery: B2 | Understand typed impasses, bounded child investigation, parent protection, return validation, and governed recovery knowledge. |
| 23 | Persistent Intention and Resource Governance: B4 and B6 | Understand objective/method persistence (B4) and uncertainty/resource governance (B6), including their separate authorities. |
| 24 | Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution | Understand the compiled graph, durable host, storage boundaries, approval, dispatch, reconciliation, and the five distinct restart paths. |

### Repository cleanup performed

The supplied book archive contained two Part III indexes:

- `Tex/part3/content.tex`, used by the authoritative `Tex/main.tex` build, already included Chapters 19–24.
- Root-level `part3/content.tex`, a legacy secondary outline workspace, still listed Chapters 19–30.

The six placeholder chapter directories 25–30 have now been deleted from **both** locations:

- `Tex/part3/chapter25` through `Tex/part3/chapter30`
- `part3/chapter25` through `part3/chapter30`

The legacy root `part3/content.tex` index now lists only Chapters 19–24. The authoritative `Tex/part3/content.tex` remains the build source and also lists only Chapters 19–24. Historical change logs and deletion manifests still mention Chapters 25–30 because they record earlier work; those archival mentions are not active chapter inputs.

No Chapter 19–24 manuscript was changed as part of this review beyond retaining the already accepted Chapter 24 revision from the prior delivery. The supply-chain application repository was inspected read-only and was not modified.

## 3. Learning-fluency scorecard

The scores are comparative editorial estimates, not measured outcomes. They reflect five dimensions: prerequisite readiness, clarity of the main mental model, example continuity, code-navigation burden, and reinforcement through recap/exercises.

| Chapter | Fluency estimate | Assessment | Main reason |
|---|---:|---|---|
| 19 | 8.0/10 | Strong foundation, slightly premature runtime detail | The domain/simulator explanation is concrete, but the early restart-test inventory introduces runtime complexity before the reader understands the mechanisms and full graph. |
| 20 | 7.8/10 | Strong conceptual bridge, high information load | CoALA maps cleanly to code, but four memory types, internal/external actions, planning strategies, and evaluation are introduced in one chapter. |
| 21 | 6.5/10 | Most difficult chapter | B1 and B3 are correctly sequenced, but the chapter is the longest and densest; formula, lifecycle, testing, feedback, workspace competition, and persistence boundaries compete for attention. |
| 22 | 7.6/10 | Good single-mechanism focus | B2 has a clear lifecycle and a useful boundary story; the dependency on B4 authority needs a more explicit forward-reference for readers. |
| 23 | 6.9/10 | Technically strong, cognitively demanding | B4 and B6 are complementary, but 11 code listings and two separate governance models make the chapter dense. |
| 24 | 7.9/10 | Strong synthesis, incomplete learning closure | It integrates the application well and qualifies restart evidence carefully, but the main REQ-09 scenario does not traverse B2 and there is no fully guided capstone exercise. |

### What the reader can learn successfully today

A careful reader can explain the purpose of each layer, distinguish the four CoALA memory roles, describe B1 and B3 as different selection problems, follow the B2 child-investigation lifecycle, explain B4's objective/method distinction, describe B6's uncertainty and resource controls, and understand why graph checkpoints are not the same thing as the domain world or CoALA memory.

The reader can also understand the approval/dispatch/reconciliation safety boundary and why a lost acknowledgement must not automatically trigger another state-changing action.

### Where comprehension is likely to become fragile

The reader may still confuse:

1. **A graph checkpoint with durable application state.** The graph stores identifiers and versions that point to authoritative stores; it is not the full memory, simulator, approval, or evidence database.
2. **B1 with B3.** B1 selects memories/evidence for retrieval and projection; B3 admits items into a bounded shared workspace and broadcasts them to consumers. They are consecutive but distinct decisions.
3. **A B2 case being resolved with the parent objective being satisfied.** A child case can close with a positive disposition while the parent task still requires validation, a method change, approval, or escalation.
4. **B4 with action permission.** B4 retains an objective and governs its method; it does not itself authorize a domain write.
5. **B6 uncertainty with B6 resource accounting.** The uncertainty assessment, optional calibration profile, and resource-budget ledger have different owners and persistence paths.
6. **An action-ledger `UNKNOWN_OUTCOME` with an unknown business outcome.** The transport/action record can remain unknown while authoritative simulator evidence establishes that the business effect occurred.
7. **The primary REQ-09 integration test with a complete demonstration of every mechanism.** It does not enter the B2 child-investigation branch.
8. **Same-JVM host replacement with process restart.** Only one of the five featured restart paths is a focused forked-JVM write/reconcile probe, and another is a fresh-JVM full-graph checkpoint resume at clarification before an external effect.

These are not reasons to remove detail. They are reasons to foreground a short statement of each distinction before the long technical explanation.

## 4. Is the chapter sequence fluent?

### The macro-sequence is correct

The six-chapter progression is one of the strongest parts of Part III:

**Business truth → agent architecture → memory/workspace selection → impasse recovery → intention/resource governance → composed runtime.**

This order builds prerequisites rather than teaching isolated framework features. Chapter 19 teaches why domain rules and simulator truth must not be delegated to a model. Chapter 20 adds the CoALA architecture. Chapter 21 adds selection and shared-workspace control. Chapter 22 adds bounded recovery when the current decision is blocked. Chapter 23 adds persistence of task intention and constraints on continued reasoning/execution. Chapter 24 finally shows how those pieces are scheduled and persisted by the application.

Do not reorder the chapters. In particular, keep B1 before B3, keep B2 before the full B4/B6 treatment, and keep the graph/runtime integration last.

### The micro-sequence needs smoothing

The main problem is that some chapters ask the reader to learn a mechanism while simultaneously learning its terminology, its state schema, the service decomposition, its persistence strategy, the test architecture, and its evidence limitations. The prose is careful, but cautionary detail sometimes arrives before the underlying mechanism has become intuitive.

A recurring explanatory pattern would make the learning path more fluent:

1. **Problem:** What fails or becomes inefficient without this mechanism?
2. **Decision:** What exact decision does the mechanism make?
3. **Inputs and output:** What typed information enters and what new state/reference is produced?
4. **Authority:** Which component is allowed to make or validate the decision?
5. **Persistence:** What is durable, ephemeral, or supplied through a port?
6. **Code path:** Which small number of classes implement the decision?
7. **Test evidence:** Which exact test proves the path, and what does it not prove?

Use this same sequence for B1, B3, B2, B4, and B6. It gives readers a predictable map without flattening the differences between the mechanisms.

## 5. Chapter-by-chapter review and recommendations

### Chapter 19 — Build the world before the agent

**What works well**

The chapter starts with the right question: what is the application actually modeling? It introduces typed quantities, immutable/versioned snapshots, business invariants, deterministic transitions, and the distinction between proposed commands and applied simulator effects. Its central teaching point is exactly right: the model may interpret or propose, but business truth and state transitions remain in domain and simulator code.

The transition from domain model to agent-facing actions is also effective. It helps readers understand why perception/grounding and state-changing operations are separate, and why an action is not simply a tool invocation.

**Main fluency problem**

The chapter introduces an extensive five-path persistence/restart inventory and focused B6 reliability tests before Chapters 20–24 have taught the reader the memory, B2, B4, B6, and graph concepts needed to understand those paths. The discussion is technically accurate and intentionally caveated, but it is placed too early. Chapter 24 then returns to those paths in greater detail, creating repetition and weakening the sense that the last chapter is where the application finally comes together.

**Recommendations**

1. Keep the domain, invariant, simulator, action-boundary, and Maven-module explanation in Chapter 19.
2. Replace the detailed five-path restart inventory with a short preview: PostgreSQL supports selected runtime/memory records and checkpoints; the simulated world remains behind an injected in-memory adapter; the different recovery tests will be compared in Chapter 24.
3. Move the focused B6 lease-recovery description to Chapter 23, where B6 resource reservation, leases, fencing, and conservative accounting are actually taught. Chapter 19 can mention that further runtime reliability evidence exists without explaining the lease algorithm.
4. Keep the “what this application does not claim” section. It protects the reader from equating a deterministic simulator with a production ERP or live supplier network.

**Why**

Chapter 19 should establish the world and its hard rules. It should not ask readers to memorize the runtime's restart taxonomy before they know the architecture being restarted. Deferring that inventory reduces early cognitive load and gives Chapter 24 a meaningful final synthesis task.

### Chapter 20 — Give the reader one stable CoALA map

**What works well**

This is a good bridge from Parts I and II to implementation. It does not claim that CoALA prescribes the exact Java module layout. It introduces working, episodic, semantic, and procedural memory, explains internal versus external actions, and distinguishes planning, evaluation, and permission. The warning that cross-store retrieval is not yet B1 selection or B3 admission is especially important and correctly prepares Chapter 21.

**Main fluency problem**

The reader moves quickly through a large number of components. Four memory stores, internal retrieval/reasoning/learning actions, external observation and grounding, planning over isolated simulation state, three planner strategies, and candidate evaluation are all legitimate topics, but the chapter lacks a single compact model that readers can repeatedly use to locate each new detail.

**Recommendations**

1. Add a one-page “CoALA-to-application map” near the beginning. Show the three CoALA dimensions and, beneath them, the four memory roles, internal actions, external actions, and the decision procedure.
2. Add one continuing example (a disrupted customer order) and use it to illustrate where a fact is first observed, where it is stored, how it is retrieved, how a plan is proposed, and where permission is still absent.
3. Put a short “not yet B1/B3” reminder at the point where cross-store retrieval is explained, then use that as the transition into Chapter 21.
4. End with a concise “what you should now be able to trace” list: one memory read, one internal action, one planning result, and one external action boundary.

**Why**

Readers need a mental map before they need class names. A single example carried through Chapters 20–24 reduces the cost of learning new terminology because each chapter adds one new decision to a familiar scenario.

### Chapter 21 — Teach B1 and B3 as two consecutive but different decisions

**What works well**

The order is conceptually correct: first decide which memories/evidence are useful enough to retrieve and project (B1); then decide which prepared items should enter the shared workspace and be broadcast to consumers (B3). The chapter carefully distinguishes selection history, verified use, receipts, downstream outcomes, and feedback attribution. Its detailed explanation is valuable for an advanced reader.

**Main fluency problem**

This is the longest chapter (approximately 11.5k whitespace-separated source words) and the most demanding. It contains two mechanisms, several lifecycle stages, a scoring formula, latency/cost distinctions, maintenance, feedback training, optional feature enrichment, workspace constraints, coalitions, status layers, broadcast receipts, verified outcomes, persistence boundaries, tests, and the seven-field traceability lens. The recap is also disproportionately long, restating many details instead of helping the reader compress them into a durable mental model.

The chapter risks making B1 look like “a complicated score” and B3 look like “another complicated score,” when the important learning is that they solve different questions at different boundaries.

**Recommendations**

1. Divide the chapter into two visibly balanced teaching arcs: **B1 — which memories should be brought forward?** and **B3 — which candidates should enter the shared workspace?** Keep them in the same chapter because the handoff is important.
2. Begin each arc with a simple input → decision → output diagram and a small worked example before presenting implementation classes or formulas.
3. For B1, introduce the score in plain language first: accessibility estimate × expected downstream utility, less cognitive latency, infrastructure latency, and estimated maintenance, plus a bounded optional outcome adjustment. Only then show the formula and implementation. State clearly that the logistic accessibility value is an engineering proxy, not a calibrated probability, and that the feature-learning path preserves the provider's task scale rather than silently normalizing it into selector utility.
4. For B3, make the distinction between hard admission constraints, singleton ranking, bounded coalition alternatives, broadcast, receipt, and verified downstream outcome visible as six separate steps. Do not present a receipt as proof of usefulness.
5. Add one trace with a concrete memory candidate moving through retrieval → B1 selection → workspace candidate → B3 admission → consumer receipt → verified outcome. Reuse the same candidate identifiers throughout the example.
6. Shorten the recap to roughly 250–350 words. Retain the detailed test/evidence table, but let it serve as evidence rather than repeating the chapter body.
7. Move advanced caveats into visually distinct “Implementation limit” notes so that first-time readers can follow the core path before reading every qualification.

**Why**

B1 and B3 are the first point where readers must understand two separate optimization/selection boundaries. If the distinction is intuitive, the code becomes easier to navigate. If the reader has to infer the distinction from many score and state details, the mechanisms blur together.

### Chapter 22 — Make B2's lifecycle and authority boundary explicit

**What works well**

A single mechanism receives a full chapter, which is good for fluency. The chapter follows a natural lifecycle: typed impasse → versioned case/parent snapshot → child investigation → return validation → recovery draft → approval/staging/review/activation. It also distinguishes the B2 subgraph from the authoritative case and separates B2 parent-child fencing from B6 resource-budget lease fencing.

The chapter is also appropriately careful that a recovery-procedure draft is not an executable skill and that later promotion has separate governance.

**Main fluency problem**

The chapter relies on B4 delegation authority before Chapter 23 has fully explained B4. This is defensible—the reader has encountered intention concepts in Part II—but the forward dependency is not obvious enough for someone who follows chapters sequentially.

There is also a semantic trap in the word `RESOLVED`. In the implementation, `ImpasseResolutionCase.resolve(...)` marks the child case `RESOLVED` for any non-`UNRESOLVED` disposition. The disposition can be `HYPOTHESIS_PROPOSED` as well as `EVIDENCE_CONFIRMED`. That status does not by itself establish that the parent task's objective is satisfied.

**Recommendations**

1. Before the B4 delegation subsection, add a two-sentence forward-reference: “B2 may delegate the parent intention, but B4 remains the authority over that intention. Chapter 23 develops the full B4 state model; here we need only the protection rule that prevents child investigation from silently replacing the parent objective.”
2. Add a compact three-column table distinguishing **child disposition**, **child case status**, and **parent objective status**. Include `EVIDENCE_CONFIRMED`, `HYPOTHESIS_PROPOSED`, and `UNRESOLVED` as separate child dispositions.
3. State in a highlighted implementation note that `RESOLVED` is a terminal lifecycle status for the child case after a non-unresolved result; it is not equivalent to proof that the hypothesis is true or that the parent objective is satisfied.
4. Keep the current qualification that the `HYPOTHESIS_PROPOSED` positive-return mapping is not covered by the same direct full-graph evidence as an evidence-confirmed return. Do not silently describe it as empirically validated.
5. End the chapter with a short “what goes back to the parent” trace: parent identity, evidence, disposition, draft reference, and B4 method decision.

**Why**

B2's central learning is not simply “delegate a subtask.” It is “investigate within a bounded child context without losing parent identity or granting the child authority over the parent's goal.” The `RESOLVED` label can undermine that message unless the three levels of status are separated visually.

### Chapter 23 — Teach B4 and B6 in two lanes, then compose them

**What works well**

B4 and B6 are appropriately paired because both influence what happens before the next planning/execution decision, but they answer different questions. B4 protects the objective while allowing a method to change. B6 assesses uncertainty and resource limits, returning a typed control decision. The chapter correctly preserves the difference between intention governance, meta-control, authorization, and action execution.

It also does a good job keeping B5/GraSP outside the implemented scope rather than treating the absence of B5 as an unspoken success.

**Main fluency problem**

The chapter is conceptually split into two lanes but the reader has to hold both simultaneously: persistent intention, versioned method, reconsideration, B2 delegation/termination, uncertainty assessment, calibration, resource vectors, typed governor decisions, reservation, leases, fencing, and usage accounting. With 11 code listings, the chapter carries high local code density even though it is shorter than Chapter 21.

**Recommendations**

1. Open with two questions in parallel: **B4 asks “what objective must remain protected, and which method is current?”; B6 asks “how uncertain is the current decision, and what resources may the next step consume?”**
2. Keep all B4 explanations together and all B6 explanations together; do not interleave their persistence details. Then add one combined trace showing both decisions applying to the same subsequent planner call.
3. Add a one-page ownership/persistence map distinguishing:
   - B4 recovery intention and versioned method binding;
   - base uncertainty assessment supplied through the lifecycle-domain port;
   - optional calibration profile repository;
   - PostgreSQL-backed resource budget ledger/leases;
   - action authorization and approval, which remain separate.
4. Clarify that the `CognitiveCycleState` carries an assessment reference, not the full authoritative assessment. The host's lifecycle-domain contract must resolve the exact execution/scope/revision. Do not imply that the host creates a PostgreSQL repository for base assessments.
5. Move the focused B6 lease-recovery explanation that currently appears early in Chapter 19 here, near lease/fencing/accounting.
6. Add a brief final paired trace: B4 keeps the objective and updates the method; B6 constrains whether to continue, gather evidence, downshift, ask a human, or stop; neither alone authorizes the external action.

**Why**

The reader needs to retain the complementarity without confusing the mechanisms. Two side-by-side lanes followed by one composition trace teach this better than one long blended sequence.

### Chapter 24 — Finish with composition and learner synthesis

**What works well**

The chapter is a genuine integration chapter. It explains the graph as a scheduler/orchestrator, not as the owner of all policy. It distinguishes LangGraph4j's graph routing/checkpoint/resume responsibilities from application-owned services, domain authority, action authorization, and LangChain4j-facing adapters. The durable-host and PostgreSQL discussion is careful and more precise after the accepted revision. The REQ-09 walkthrough is especially valuable because it demonstrates an approved effect, a lost acknowledgement, reconciliation without redispatch, memory update, intention completion, and a later cycle that consumes prior context.

The five restart paths are correctly treated as different evidence, rather than collapsed into a single overbroad durability claim.

**Main fluency problem**

The principal REQ-09 path is not a demonstration of every mechanism branch. In `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest`, the fixture's B2 planner returns an empty `UNRESOLVED` child plan and its child-step executor throws if called. That is deliberate: the success fixture must not invent child-investigation evidence. The path demonstrates B1/B3, B4/B6, approval, dispatch, reconciliation, observation, and memory reuse, but it deliberately does not exercise the B2 child-investigation branch. B2 has separate full-graph evidence in `M8B4FullGraphWorkflowTest.fullGraphResolvedB2ReturnCreatesTypedRecoveryDraftAndCarriesReference`.

This nuance is present in the code and tests, but a learner can still overgeneralize from the phrase “full durable end-to-end workflow” unless Chapter 24 explicitly shows which branches are traversed and which are not.

The chapter is also the final chapter, but its exercises are review questions rather than a fully scaffolded capstone that asks the reader to reconstruct and explain the actual system.

**Recommendations**

1. Add a “REQ-09 exercises these paths / does not exercise these paths” table. Explicitly mark B2 child investigation as outside the REQ-09 success fixture and cross-reference the separate B2 full-graph test.
2. Add a compact coverage map for all five mechanisms: chapter where taught, code owner, primary test, and what the test actually demonstrates. Avoid implying that a single integration test proves all five mechanisms.
3. Retain the five restart-path comparison, but use a consistent evidence table with columns: process boundary, graph scope, external effect already applied?, state restored, and claim not established.
4. Add a capstone exercise with an answer key or model solution outline. The student should reconstruct the REQ-09 flow from request to planning, approval, simulator transition, lost acknowledgement, reconciliation, observation, working-memory update, and second-cycle reuse. They must also identify where B2 would branch and cite its separate test evidence.
5. Require the learner to classify each important record as PostgreSQL-backed, graph-checkpointed, in-memory/ephemeral, injected external authority, or simulator/world adapter state. This forces the reader to prove that they understand the persistence model.
6. Finish with a “what the application demonstrates / does not demonstrate” table, including no live-model evaluation in the primary REQ-09 path, no PostgreSQL persistence of the simulated world snapshot, no production deployment claim, and no empirical effectiveness claim.
7. Keep the `Phase0Application` disclaimer. It is a smaller intake smoke program using a fixed-response model and in-memory `MemorySaver`; it is not a runnable entry point for the complete cognitive application.

**Why**

The final chapter should not merely explain how components are wired. It should test whether the reader can reconstruct the system boundaries without confusing graph, memory, domain, simulator, approval, or evidence. An explicit capstone also gives Part III a satisfying educational endpoint.

## 6. Codebase review: what the reader is being asked to learn

The supplied application snapshot is sizeable:

- 11 Maven modules;
- 585 Java main-source files;
- 89 Java test-source files;
- approximately 40,633 lines of Java main source.

The book includes approximately 46 Java code listings across the six chapters (4, 7, 7, 8, 11, and 9 respectively). That is a selective tour, not a complete line-by-line explanation of the repository. The book should say this explicitly and direct readers to the smallest useful set of classes for each concept.

### Code-reading route recommended for the reader

| Chapter | Start with | Then inspect | Do not ask the beginner to read linearly |
|---|---|---|---|
| 19 | `Quantity.java`, `SupplyChainSnapshot.java` | `SupplyChainSimulator.java`, `SimulationCommand.java`, `InMemorySupplyChainSimulationWorld.java`; simulator and external-action tests | Every domain aggregate and every action implementation. |
| 20 | The four memory-role interfaces/models and their owning services | Retrieval, episodic/semantic/procedural lifecycle, and the planning contracts | Every repository adapter before the conceptual CoALA map is understood. |
| 21 | `B1RetrievalSelector.java` | `WorkspaceAdmissionService.java`, broadcast/receipt/outcome services, B1/B3 tests | The full feedback training/evaluation subsystem in one sitting. |
| 22 | `ImpasseResolutionCase.java`, `ImpasseResolutionService.java` | `B2ResolutionSubgraph.java`, child-step receipts/fencing, recovery draft/promotion services and tests | The entire lifecycle service before understanding the parent/child state model. |
| 23 | `RecoveryIntentionService.java`, `MetaControlGovernor.java` | `CognitiveCycleLifecyclePort.java`, `ResourceBudgetExecutionGuard`, `PostgresResourceBudgetLedger.java`, B4/B6 tests | All lease-recovery SQL and every governor policy implementation on the first pass. |
| 24 | `CognitiveCycleApplicationGraph.java`, the graph's node/edge map | `CognitiveCycleGraph.java`, `DurableCognitiveApplicationHost.java`, `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.java`, and the separate B2/restart tests | The 800–1,000-line service classes line by line before understanding the request-cycle trace. |

### The code-level complexity is concentrated in a few large orchestrators

Some important classes are substantially larger than the small mechanism classes the reader first meets:

| Class | Approximate source lines | Learning implication |
|---|---:|---|
| `CognitiveCycleGraph` | 801 | Teach the graph by named functional regions and route map, not by a continuous source listing. |
| `CognitiveCycleDecisionServices` | 832 | Separate retrieval/B1/B3/planning responsibilities in the prose; do not portray this class as one policy. |
| `CognitiveCycleLifecycleServices` | 1,040 | Explain it as a coordinator of lifecycle services, not as a monolithic owner of every policy. |
| `DurableCognitiveApplicationHost` | 473 | Teach composition and injected ports first; then show only the storage wiring needed for the chapter's claim. |
| `CognitiveCycleState` | 163 | Use it to teach references and routing state, not as the full CoALA memory model. |
| `B1RetrievalSelector` | 98 | A useful focused example of a testable mechanism service. |
| `WorkspaceAdmissionService` | 323 | Explain the sequence of admission constraints before the coalition implementation detail. |
| `ImpasseResolutionService` | 35 | The small service is not the complete B2 mechanism; lifecycle, subgraph, repositories, and validation matter. |
| `RecoveryIntentionService` | 175 | A focused B4 service, but the graph/lifecycle handoff still matters. |
| `MetaControlGovernor` | 30 | The governor delegates policy decisions; the surrounding B6 inputs/ledger are not inside this short class. |

**Recommendation:** each code-heavy section should say “start here” and identify one principal class, one collaborating contract, and one test. This reduces repository navigation overhead and prevents readers from mistaking a small class for the whole mechanism or a large orchestrator for the sole policy owner.

## 7. Code-backed distinctions that should remain explicit

These are high-value conceptual boundaries, not optional implementation trivia.

### 7.1 Mechanism identifiers versus application pipeline labels

The Java enum `MechanismId` contains exactly `B1`, `B2`, `B3`, `B4`, and `B6`. These are the five residual bundles discussed in the book. Names such as `M2`, `M3`, and `M5` are used in the application/manuscript for pipeline or workstream roles (for example, base retrieval, reasoning/action dispatch, and planning); `M7`/`M8` labels appear in milestone/test identifiers. These are not additional Fan and Lan mechanism bundles. The manuscript should define this nomenclature once in Chapter 20 and use qualified labels thereafter. This matters because Part II also uses an `M2` label in a separate illustrative method sequence; bare `M2` is therefore easy to misread.

### 7.2 B1's accessibility value is an engineering estimate

`B1RetrievalSelector` applies a logistic transform to total activation and uses the result as an accessibility estimate in its net-utility score. The code does not make that a calibrated probability merely by naming the field `accessibilityProbability`. The chapter correctly warns against treating it as calibrated; that warning should appear before the formula and in the worked example. Expected downstream utility and feedback adjustment also have different meanings and should not be silently normalized into one scale.

### 7.3 B3 snapshot durability is not implied by durable host naming

`DurableCognitiveApplicationHost` constructs `WorkspaceAdmissionService` with `InMemoryWorkspaceRepository`. Its comment explicitly says B3 workspace snapshots are per-cycle and ephemeral, while receipts/outcomes are durable. Chapter 24 must keep this distinction highly visible: durable host does not mean every object reachable from the host is persisted.

### 7.4 B2's `RESOLVED` status is not a synonym for objective satisfaction

`ImpasseResolutionCase.resolve(...)` marks the child case `RESOLVED` for any positive/non-unresolved disposition. Since `HYPOTHESIS_PROPOSED` is a positive disposition distinct from `EVIDENCE_CONFIRMED`, child lifecycle completion must not be described as independent proof or parent goal completion. The book should retain its limitation note and make the three statuses visible.

### 7.5 B4 objective governance is not authorization

The intention identifies the objective and the current method. Approval, capability authorization, action dispatch, and simulator truth remain separate. The reader should meet this distinction in Chapter 23 and see it again in Chapter 24's execution diagram.

### 7.6 B6 has three distinct state/persistence concepts

The report should keep separate: (a) the base uncertainty assessment accessed through the injected lifecycle-domain port; (b) the optional calibration-profile repository; and (c) the PostgreSQL-backed resource-budget ledger/lease accounting. The lifecycle contract requires exact, durable assessment resolution, but the durable host does not create a base-assessment PostgreSQL repository itself. The graph state holds a reference, not the authoritative assessment. These distinctions were sharpened in the accepted Chapter 24 revision and should be preserved throughout Chapter 23.

### 7.7 REQ-09 deliberately excludes the B2 child route

In `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest`, the success fixture returns an empty `UNRESOLVED` child plan. Its child-step executor throws `UnsupportedOperationException` if invoked, because the success fixture must not invent child-investigation evidence. Therefore, the main REQ-09 success path is not evidence that B2's child investigation completed. The separate `M8B4FullGraphWorkflowTest.fullGraphResolvedB2ReturnCreatesTypedRecoveryDraftAndCarriesReference` test supplies evidence for a resolved B2 child return and draft reference in the parent state. Chapter 24 should put this distinction in the main walkthrough, not only in a footnote or source note.

### 7.8 Five restart paths prove five different things

Keep the paths distinct:

1. **REQ-09 two-cycle host reconstruction:** three host instances in one JVM; the simulator and approval authority adapters remain alive outside those host objects. It proves the tested business flow can reconcile after host replacement without a second simulator effect; it does not prove fresh-JVM world persistence.
2. **Durable-host clarification resume:** same-JVM host replacement at a clarification boundary, before planning or external effects.
3. **M8B4C focused pool replacement:** same-JVM replacement of pool/repositories around a smaller workflow; provider simulator retained by the test.
4. **M8B4D focused forked-JVM action-ledger probe:** two child JVMs around a deliberately narrow ambiguous-write/reconcile flow; this is genuine process-boundary evidence but not a full application restart.
5. **Full-graph child-JVM clarification resume:** full cognitive graph checkpoint/resume across processes, but paused before authorization or world effect.

The simulator snapshot itself remains in-memory in the supplied application. The book must not turn these separate test scopes into a claim that PostgreSQL persists the simulated supply-chain world across JVM restarts.

## 8. Priority-ranked recommendations

### P0 — Required for a fluent, accurate final Part III

| Recommendation | Why it matters | Expected reader benefit |
|---|---|---|
| Move detailed restart taxonomy out of Chapter 19 and consolidate it in Chapter 24. | It arrives before the mechanisms and graph are known, then repeats later. | Less early cognitive overload; stronger ending. |
| Add the one-page CoALA-to-code map in Chapter 20. | Readers currently meet many classes before holding one stable map. | Easier navigation and fewer mental-model resets. |
| Reframe Chapter 21 as B1 decision followed by B3 decision, with one shared worked trace. | Two different selection boundaries can blur into one scoring story. | Better conceptual discrimination and transfer. |
| Clarify B2 child `RESOLVED` versus parent objective satisfaction. | The implementation's lifecycle label could be read as a truth claim. | Prevents a safety/semantics misconception. |
| Present B4 and B6 as separate lanes before their combined trace. | Their pairing is correct but dense. | Better retention of what each mechanism controls. |
| Add a REQ-09 traversed/not-traversed table and separate B2 evidence. | REQ-09 deliberately does not enter B2 child investigation. | Accurate understanding of test coverage. |
| Add a final Chapter 24 capstone with a model-solution outline. | Review questions do not yet require complete system reconstruction. | Makes Chapter 24 a genuine learning endpoint. |

### P1 — Strongly recommended

| Recommendation | Why it matters | Expected reader benefit |
|---|---|---|
| Standardize the seven-step mechanism explanation pattern. | Reduces the cost of switching between chapters. | Predictable reading rhythm. |
| Add a compact persistence/authority table at the start of Chapters 21, 23, and 24. | Graph, memory, workspace, assessment, ledger, authority, and world state are easy to conflate. | Stronger system-boundary comprehension. |
| Reduce Chapter 21 recap to a short synthesis and preserve a separate evidence matrix. | The recap currently repeats too much technical detail. | Better retrieval of the main ideas after reading. |
| Add “start with these classes/tests” navigation cues. | The repository is much larger than the book's 46 snippets. | Less unproductive code-search time. |
| Define M2/M3/M5 and B1/B2/B3/B4/B6 separately once. | Similar-looking labels are used for different taxonomies. | Fewer naming errors and incorrect attributions. |
| Mark advanced caveats as “implementation limit” notes. | Important cautions sometimes interrupt the first explanation of a mechanism. | Better balance between first-pass comprehension and expert precision. |

### P2 — Production and editorial polish

| Recommendation | Why it matters | Expected reader benefit |
|---|---|---|
| Rebuild the full book after generated Mermaid images are present. | Source validation cannot establish figure placement, float order, code-page breaks, or QR readability in the final PDF. | Reliable final reading experience. |
| Inspect pages with the densest code and reference strips. | The code-heavy chapters can be visually tiring even if LaTeX compiles. | Improved page rhythm and legibility. |
| Run the learner comprehension test below before final publication. | Editorial estimates should be validated with actual readers. | Evidence-based final adjustment rather than intuition alone. |

## 9. Suggested final capstone for Chapter 24

The capstone should use the real REQ-09 integration test and ask the learner to create five artefacts:

1. **Sequence diagram:** request → interpretation/context → B1 → B3 → planner → B4/B6 governance → approval → action dispatch → simulator effect → lost acknowledgement → reconciliation → observation → working-memory update → second cycle.
2. **Authority map:** identify who owns graph routing, memory facts, workspace admission, persistent intention, uncertainty assessment, budget, approval, action ledger, and simulator truth.
3. **Persistence map:** classify each record as PostgreSQL-backed, checkpointed reference, in-memory/ephemeral, or injected external adapter state.
4. **Evidence table:** for each mechanism and restart path, name the test and the strongest claim it supports; include the B2 full-graph test separately from REQ-09.
5. **Non-claims:** explain why the demonstration does not prove live-model effectiveness, production deployment readiness, or process-durable simulation-world state.

The answer key should emphasize that the action batch can remain `UNKNOWN_OUTCOME` at the transport layer after the simulator has applied the effect, while authoritative simulator evidence allows the business result to be reconciled without redispatch. This is one of the most valuable system-level lessons in the entire Part III.

## 10. How to measure reader comprehension before final publication

Use 3–5 readers who have completed Parts I and II and have ordinary Java experience. Do not ask whether they “liked” the chapter as the principal measure. Ask them to explain or reconstruct the system without looking back.

### Checkpoints after each chapter

- **After 19:** Can the reader explain why a typed command, a simulation result, an applied world transition, and an observation are four different things?
- **After 20:** Can the reader map working, episodic, semantic, and procedural memory, and distinguish internal action, external interaction, and the decision procedure?
- **After 21:** Can the reader explain B1 and B3 in one sentence each and correctly trace one candidate through both?
- **After 22:** Can the reader explain why a child investigation cannot replace the parent objective and what a recovery draft is not allowed to do yet?
- **After 23:** Can the reader explain B4 and B6 independently, then show how they influence the next planner call without becoming action authorization?
- **After 24:** Can the reader reconstruct the REQ-09 flow, name what it tests and does not test, and distinguish all five restart paths?

### Scoring rubric

Score each checkpoint from 0 to 2:

- **0 — Incorrect or conflated:** The reader confuses state owners, authorities, mechanisms, or evidence claims.
- **1 — Partial:** The reader has the gist but misses a key distinction, handoff, or limitation.
- **2 — Accurate and transferable:** The reader can explain the distinction and apply it to a new example without prompting.

Record time-to-answer, number of look-backs, and the exact confusion—not just the numeric score. The most important failure signals are: treating the graph checkpoint as memory, treating B1 and B3 as the same decision, calling a B2 child `RESOLVED` case proof of parent goal completion, treating B4 as authorization, treating uncertainty assessments as the budget ledger, claiming REQ-09 traverses B2, or claiming PostgreSQL persists the simulated world across process restart.

A reasonable publication target is that most readers score 2 on the core distinction questions after one read, and can complete the Chapter 24 capstone with at most minor reference lookups. If readers repeatedly score 0 on a distinction, revise the teaching explanation before adding more detail.

## 11. Source and build verification

### Code-source alignment

The active six chapters contain 121 commit-pinned source-link occurrences pointing to 81 unique application source paths. All link paths and cited line ranges were checked against the supplied application snapshot. The source commit is consistent: `fa8cd5ec0742d7010dbba2c3646852e95062a419`.

The code review confirmed the class/test relationships described in this report, including the deliberate B2 exclusion in the main REQ-09 fixture and the separate full-graph B2 resolved-return test.

### Repository checks after deleting Chapters 25–30

| Check | Result |
|---|---|
| `bash scripts/check-scaffold.sh` | Passed — Part I 8, Part II 10, Part III 6. |
| `python scripts/check-source-qrs.py` | Passed — 35 QR assets match their commit-pinned PDF links. |
| `bash scripts/check-diagrams.sh --sources-only` | Passed — 131 Mermaid sources, accessible descriptions, sequence syntax guard, and Chapter 1–24 figure references. |
| Chapter 25–30 directories in both Part III trees | Removed. |
| Chapter 25–30 active inputs in both Part III content indexes | None. |

### What was not verified

A complete production PDF was not rendered in this review. Generated Part III Mermaid PNGs are absent from the supplied working archive and the Mermaid CLI is not available locally; the install attempt timed out. Therefore, page-by-page visual layout, final diagram placement, float order, code breaks, and QR size in the complete PDF remain unverified. Passing Mermaid source validation does not replace the visual PDF check.

The Java application was reviewed against the supplied frozen snapshot; no application code, tests, Maven files, migrations, CI, or application documentation were changed.

## 12. Final recommendation

Keep the six-chapter Part III structure and preserve the engineering depth. Do not split or restart the work. Make a focused pedagogical revision in this order:

1. simplify Chapter 19's early runtime/restart detail;
2. add the CoALA map in Chapter 20;
3. reframe Chapter 21 around the B1/B3 distinction and shorten its recap;
4. sharpen Chapter 22's child-status versus parent-objective distinction;
5. teach Chapter 23 in two parallel lanes before recombining them;
6. finish Chapter 24 with an explicit coverage map and capstone.

The application and the six chapters already contain the substance needed to teach a coherent production-oriented agent architecture demonstration. The final improvement is to make that substance easier to learn in the order it is encountered, without weakening the evidence boundaries or pretending that the simulator is a deployed enterprise system.
