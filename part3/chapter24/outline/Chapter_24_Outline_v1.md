# Chapter 24 Outline — Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — proposed six-chapter structure  
**Outline status:** proposed for individual author approval; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** connect the application services into the actual cognitive graph and durable host, then demonstrate the simulated supply-chain workflow through separate, accurately bounded integration tests.

## 1. Purpose and teaching contract

Chapters 20–23 explain the CoALA capabilities and the B1/B2/B3/B4/B6 control responsibilities in the source. Chapter 24 shows how the repository composes those capabilities into one application. The reader should be able to follow a request from host ingress through the graph, memory, planning, mechanism governance, exact approval, simulated execution, observation/reconciliation and outcome recording.

This is not a deployment chapter or a framework tutorial. It is a guided explanation of one application-specific composition. LangGraph4j, LangChain4j and PostgreSQL are explained only to the extent needed to understand the actual code. The primary supply-chain walkthrough is deterministic and test-backed; it is not a claim of live-model execution or production deployment.

## 2. Learning outcomes

By the end of this chapter, readers should be able to:

1. Explain the separation between the application composition root, cognitive graph definition, application-owned operations/services and durable host.
2. Trace the full cognitive graph's principal nodes, conditional routes, loops and human interruption points.
3. Explain the distinct roles of LangGraph4j, LangChain4j, Java domain/planning/mechanism services and PostgreSQL adapters.
4. Distinguish CoALA memory stores, mechanism/runtime records, simulator state and LangGraph4j checkpoints.
5. Explain the exact approval/revalidation/dispatch/observe/reconcile sequence for a simulated state-changing action.
6. Interpret the REQ-09 two-cycle durable-host test precisely, including the three host instances, deterministic adapters and same-JVM limitation.
7. Distinguish the focused fresh-JVM action-ledger probe from the fresh-JVM full-cognitive-graph clarification test.
8. Synthesize Parts I and II through actual code while identifying approximate, conditional, ephemeral and unimplemented boundaries.

## 3. Relationship to earlier chapters

- **Part I Chapter 8** provides CoALA's conceptual decision cycle. This chapter shows one concrete graph schedule and must not imply CoALA requires this exact graph topology.
- **Part II Chapter 18** provides the proposed responsibility/dependency composition. Compare that proposal with what the source actually wires; the presence of related services does not prove every proposed dependency is composed or validated.
- **Part III Chapters 20–23** already explain component-level behavior. This chapter focuses on interactions, graph scheduling, durability and end-to-end traces rather than repeating the internal algorithms.

## 4. Detailed section outline

### 24.1 From contracts and services to one application

Start with the separation of concerns:

- `CognitiveCycleOperations` is an application-owned interface describing operations used by the graph.
- `CognitiveCycleDecisionServices` composes retrieval, B1 selection, B3 admission/broadcast, planner routing and candidate evaluation.
- `CognitiveCycleLifecycleServices` composes memory lifecycle, B2 recovery, B4 intention, B6 meta-control, authorization, execution and observation services.
- `CognitiveCycleServiceOperations` adapts the service objects to the graph's operations port.
- `CognitiveCycleApplicationGraph` assembles the full graph using decision/lifecycle ports and the shared execution guard.
- `DurableCognitiveApplicationHost` constructs stores/adapters, builds and compiles the graph, and exposes start/resume APIs.

Show why the host/composition root is not a “god object”: distinguish dependency assembly from policy ownership, and identify which service retains each domain, mechanism and authorization decision.

**Code anchors:**

- `supply-chain-agent-runtime/.../cognitive/CognitiveCycleOperations.java`
- `.../decision/CognitiveCycleDecisionServices.java`
- `.../lifecycle/CognitiveCycleLifecycleServices.java`
- `.../cognitive/CognitiveCycleServiceOperations.java`
- `supply-chain-agent-app/.../cognitive/CognitiveCycleApplicationGraph.java`
- `.../app/durable/DurableCognitiveApplicationHost.java`

### 24.2 Read the actual `CognitiveCycleGraph`

Use the graph's named constants and conditional routes to build the runtime picture. Group nodes by purpose rather than listing every constant:

1. **Ingress and interpretation:** initialize, interpret, clarification.
2. **Context and evidence:** load context, uncertainty assessment, retrieval, evidence request/acceptance.
3. **Workspace and planning:** B3 admission/broadcast, candidate proposal and evaluation, bounded planning loop.
4. **Recovery and governance:** B2 subgraph, B4 intention node, B6 meta-control and human-control interruptions.
5. **Execution boundary:** action authorization, approval interrupt, plan/approval revalidation and action dispatch.
6. **Feedback and completion:** observe/reconcile, working-memory update/retry, episode learning, complete or escalate.

Explain the important conditional edges and loops, and use the source's counters/terminal routes to show how the graph is bounded. Do not claim every cycle visits every node: actual routes depend on evidence, candidate feasibility, human input, approval and outcome.

**Primary code anchor:** `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/CognitiveCycleGraph.java`; graph state contract in `CognitiveCycleState.java`; nested B2 flow in `B2ResolutionSubgraph.java`.

### 24.3 What LangGraph4j owns—and what it does not

Ground the discussion in the source class comments and graph construction:

- LangGraph4j provides graph construction/compilation, node/edge routing, interruption and checkpointing.
- `CognitiveCycleState` carries graph execution references and routing values; it is not the complete CoALA working-memory system.
- `CognitiveCycleOperations` invokes application services. Planner strategies, memory stores, mechanism services and domain rules remain separate Java components.
- A graph checkpoint preserves graph execution state; it does not replace the authoritative records referenced by graph state.

Show one small graph fragment and the corresponding application-owned operation. Do not turn this into a general LangGraph4j tutorial.

### 24.4 LangChain4j is the model-facing adapter boundary

Explain `RequestInterpreter` and `ReasoningProvider` as application-owned interfaces. Show:

- `LangChain4jRequestInterpreter` and its request-classification adapter;
- `LangChain4jReasoningProvider`;
- `BudgetedReasoningProvider` and its resource-guard integration.

The full durable REQ-09 integration test deliberately supplies deterministic test implementations for request interpretation and reasoning. It demonstrates the composed application graph and domain workflow without requiring a live model provider. The chapter may show where a real LangChain4j adapter plugs in, but must not say the primary two-cycle trace is live-model execution.

### 24.5 Durable host composition and PostgreSQL responsibilities

Walk through `DurableCognitiveApplicationHost.open` at a high level. Cover only the persistence families needed to understand the application:

- PostgreSQL migrations and `PostgresAgentPersistence`;
- four CoALA memory repositories/services;
- B1 feature repository and feature-learning service;
- B2 impasse/case/child-step/draft/artifact persistence;
- B3 receipt/outcome evidence persistence while workspace snapshots remain per-cycle and ephemeral;
- B4 recovery-intention store;
- B6 resource/uncertainty stores and the shared execution guard (the uncertainty-calibration service is optional according to host port/codec configuration);
- action plans/batches/observations and other runtime stores;
- graph-specific PostgreSQL checkpoint saver.

Do not say simply that “PostgreSQL stores the agent memory.” Distinguish stores by owner and semantics; not every state family is CoALA memory.

### 24.6 Persistence is several different boundaries

Provide a table that distinguishes:

| State | What it represents | Owner/persistence boundary |
|---|---|---|
| CoALA working/episodic/semantic/procedural memory | Agent-managed information | Memory services and PostgreSQL memory repositories |
| B1 feature/access/outcome state | Retrieval accessibility and feedback features | B1 feature repository |
| B2 cases, child steps and procedure artifacts | Recovery subproblem and governed reuse workflow | B2 services and runtime/PostgreSQL adapters |
| B3 workspace snapshot | Bounded current-cycle competition result | Ephemeral in the current durable-host composition |
| B3 receipts/outcomes | Evidence of downstream consumption/outcome | Durable B3 evidence repository |
| B4 intention | Persistent objective/method commitment | Recovery-intention repository |
| B6 budget/uncertainty state | Resource reservations and versioned assessment records | Runtime stores, with uncertainty calibration conditionally configured |
| Action plans, approvals, batches and observations | Authorization and external-effect lifecycle | Runtime repositories/ledgers and trusted authority boundary |
| LangGraph4j checkpoint | Graph continuation state | PostgreSQL checkpoint saver |
| Simulated supply-chain snapshot | Authoritative state of the example world | Simulator/world adapter; not graph checkpoint or CoALA memory |

Explain that restart recovery requires reloading each authoritative record from its owner; the checkpoint is not a substitute for the simulator's world or the action-operation ledger.

### 24.7 Exact approval, simulated dispatch and reconciliation

Present this as a safety-critical sequence:

1. planning selects a candidate, but it remains a proposal;
2. the graph prepares a plan-bound approval request for a state-changing action;
3. the graph pauses before dispatch;
4. the trusted host/authority supplies an approval response bound to the exact plan/candidate/version and actor;
5. the graph revalidates approval binding, candidate freshness, feasibility and intention authority;
6. `ActionDispatcher` executes through capability, idempotency/fencing and resource boundaries;
7. an acknowledgement/transport ambiguity is recorded as `UNKNOWN_OUTCOME`, not interpreted as business failure;
8. observation/reconciliation uses authoritative simulator evidence and does not blindly resend the action;
9. the observation updates working memory and outcome/episode handling follows its own trust boundary.

Emphasize that cancellation or restart does not undo a simulator effect already applied. The system reconciles an ambiguous outcome before considering a replay.

**Code anchors:** `ActionDispatcher`, `CapabilityAuthorizer`, `FencedActionExecutionLedger`, `AuthorizedActionPlan`, action batch/observation stores, and the graph nodes `authorize-candidate`, `await-approval`, `revalidate-plan-and-approval`, `execute-authorized-actions`, and `observe-and-reconcile`.

### 24.8 Primary walkthrough: the durable two-cycle REQ-09 scenario

Use the exact test:

`DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory`

The test uses two independently identified top-level cycles under a shared memory scope. Present the three distinct host instances in Cycle 1 explicitly:

**Cycle 1**

1. The `REQ-09` authorized-write fixture is loaded.
2. Host instance A starts the durable cognitive graph and pauses before any simulator mutation because explicit plan-bound approval is required.
3. The external test approval authority supplies the exact approval response and authenticated approver while host A is closed.
4. Host instance B resumes. The simulated world applies the effect, but the test deliberately loses the acknowledgement.
5. The action batch is recorded as `UNKNOWN_OUTCOME`; the injected interruption occurs before reconciliation, then host B closes.
6. Host instance C is opened from PostgreSQL-backed state and resumes at reconciliation.
7. Host C reconciles against the simulator's authoritative state. The simulator transition count remains one, so no duplicate dispatch occurs.
8. The observation is written to CoALA working memory, and the B4 intention reaches `COMPLETED` only after the simulator-backed satisfaction proof is reconciled.

**Cycle 2**

1. A second independently identified disruption/request starts in the same memory scope, using host C.
2. The deterministic test adapter imports the prior-cycle observation into the new context before planning.
3. The second cycle independently pauses for its own exact approval.
4. The approval authority supplies a distinct approval response/approver; the cycle resumes and the second simulated effect completes.
5. The simulator transition count reaches two; the second cycle stores its own observation and verifies that the prior-cycle observation was available/consumed.

**Critical limitations to state beside the trace:**

- The test reconstructs host instances in the **same JVM process**; it is not a fresh-JVM restart.
- Simulator and approval-authority adapters remain alive outside the host instances, representing external systems in the test.
- Request interpretation and reasoning are deterministic test implementations, not live LangChain4j model calls.
- The test uses test-only opaque registry codecs that deliberately do not claim cross-process serialization.
- The action ledger remains `UNKNOWN_OUTCOME` at the transport level even after authoritative simulator evidence resolves the business outcome; do not collapse those two kinds of status.
- The primary test is built around `REQ-09`; do not attach unrelated route-blocked or quality-hold behavior to its timeline.

This is the principal supply-chain application walkthrough because it crosses approval, simulated state change, acknowledgement loss, reconciliation, CoALA working-memory persistence and a subsequent cycle's memory reuse.

### 24.9 Supporting full-graph traces: each test proves a different behavior

Use these as short sidebars or focused subsections; do not combine them into the REQ-09 chronology:

- **B4 method change:** `M8B4FullGraphWorkflowTest.b4MethodChangeControlsTheNextFullGraphPlannerWithoutChangingTheCommittedObjective`.
- **B4 + B6 interaction:** `b4MethodAuthorityAndB6DownshiftComposeOnTheSameSubsequentPlannerCall`.
- **B6 downshift:** `b6LowMarginDownshiftsTheNextPlannerRequestWithoutChangingTheSharedExecutionCeiling`.
- **B2 typed return:** `fullGraphResolvedB2ReturnCreatesTypedRecoveryDraftAndCarriesReference`.
- **B3 receipt/outcome path:** `fullGraphB3BroadcastPersistsReceiptAndSupportsVerifiedOutcomeLearningEvidence`.
- **B1/B3 verified feedback:** `authorizedFeedbackOverlayIsConsumedByB1AndB3DuringTheCompiledFullGraphRun`.
- **Approval and constraints:** `deniedAndRevokedApprovalsNeverReachTheActionRegistry`, `changedTrustedActionDefinitionRequiresFreshApprovalBeforeDispatch`, `demandChangeAfterApprovalInvalidatesTheOldPlanAndRequiresASecondApproval`, `newInventoryQualityObservationInvalidatesApprovedPlanAndForcesFullGraphReplanning`.
- **Domain/feasibility protections:** `qualityHeldInventoryIsNeverDispatchedAndPartialFulfillmentIsNotReportedAsComplete`, `blockedRouteEvidenceRemainsBoundToTheProposalAndDoesNotDispatch`, `conflictingInventoryEvidenceIsPreservedAsDistinctReferencesAndCannotDispatchByItself`, and `readOnlyAndInfeasibleFixturesFailClosedWithoutAWrite`.
- **Other durable-host test:** `DurableCognitiveApplicationHostPostgresIntegrationTest.durableHostPersistsMemoryRestoresInterruptedCycleAndAcceptsANewTopLevelCycle` demonstrates memory persistence/interrupted-cycle restoration and a new top-level cycle; its adapters do not demonstrate the complete planning-to-simulator-write journey.
- **Focused pool/host replacement test:** `M8B4CRestartReconciliationIntegrationTest.interruptedWorkflowReloadsApprovalIntentionBudgetAndReconcilesAmbiguousWriteAfterPoolReplacement` rebuilds the graph/host-side objects against a replacement PostgreSQL pool in the same JVM, restores approval/intention/B6 budget/action-ledger state and reconciles an ambiguous write without redispatch. It is not a separate-JVM test and is not the complete supply-chain host workflow.
- **Safe retry after definitive evidence:** `M8B4CRestartReconciliationIntegrationTest.authoritativeNotAppliedReconciliationAllowsOneSafeRetryAfterHostReplacement` shows that a retry is permitted only after authoritative provider evidence confirms the first attempt was not applied. Do not generalize this to retrying an arbitrary `UNKNOWN_OUTCOME`.

For each test, state one exact assertion and one limit. CI acceptance is implementation/build evidence; it is not independent experimental validation.

### 24.10 A focused fresh-JVM action-ledger and unknown-outcome probe

Use the exact test `M8B4ForkedJvmProcessRestartIntegrationTest.independentJvmRestartRestoresWorkflowAuthorityBudgetAndExternalOutcome` and its `M8B4ForkedJvmProbe`. This test launches two independent JVM processes. The first process persists a LangGraph4j checkpoint and durable intention, exact approval binding, B6 budget reservation and action-operation record; a deterministic provider writes an external marker and then times out, leaving the operation `UNKNOWN_OUTCOME`. The replacement JVM reconnects to PostgreSQL, verifies restored authority/budget/operation state, prevents blind redispatch, reads the deterministic provider marker as external evidence, reconciles the operation as completed and confirms replay returns `ALREADY_COMPLETED` without executing the handler again.

**Limit:** this is a focused infrastructure/action-ledger process-boundary probe built around a small test graph and a file-marker provider. It is not the full `DurableCognitiveApplicationHost`, not the REQ-09 supply-chain simulator workflow, and not evidence that the main cognitive graph's complete business flow restarts after an external effect.

**Code anchors:** `supply-chain-agent-infrastructure-postgres/src/test/java/dev/supplychain/agent/infrastructure/postgres/runtime/M8B4ForkedJvmProcessRestartIntegrationTest.java` and `M8B4ForkedJvmProbe.java`.

### 24.11 A separate fresh-JVM full-graph clarification test

Discuss `M8B4FullGraphWorkflowTest.completeApplicationGraphResumesFromPostgresCheckpointInFreshJvmAfterAbruptDeath`. It launches the full cognitive graph in forked JVMs with the `FAIL-11` fixture, halts the first process after checkpointing at a clarification boundary, and resumes in a replacement process to an `ESCALATED` terminal state. It demonstrates fresh-JVM checkpoint/resume for the full graph, but it is **not** the REQ-09 business-effect/reconciliation test and does not demonstrate a full-graph restart after an already-applied simulator effect.

**Limit:** the fixture's result is escalation after clarification resume; do not present it as a successful completed supply-chain recovery.

**Code anchor:** `supply-chain-agent-evaluation/src/test/java/dev/supplychain/agent/evaluation/M8B4FullGraphWorkflowTest.java`, with the forked probe implemented by its nested `R1DefFullGraphForkedProbe`.

Do not merge these three distinct recovery/restart narratives: same-JVM host-instance reconstruction (REQ-09), fresh-JVM focused action-ledger/unknown-outcome probe, and fresh-JVM full-graph clarification resume (FAIL-11).

### 24.12 What the repository does and does not expose as a runnable application

State the executable surface accurately:

- `Phase0Application` is a local deterministic intake smoke program using `SupplyChainIntakeGraph`, a fixed-response chat model and `MemorySaver`; it is not the full cognitive graph.
- The full cognitive graph is composed via `CognitiveCycleApplicationGraph` and operated through `DurableCognitiveApplicationHost` APIs.
- The most complete current business-flow demonstration is test-backed. The supplied app module does not contain a full standalone UI or a simple full-application CLI main program.

This is not a blocker for the book's purpose: Part III demonstrates the architecture and mechanisms through a coherent, deterministic simulated application. Do not invent a user interface or command-line product absent from the repository.

### 24.13 Final synthesis: Parts I and II through the code

Finish with two accurate matrices:

- **CoALA:** memory stores/services; internal action contracts; external perception/grounding; planner candidates and evaluation; graph control of the selected application cycle.
- **Fan & Lan:** B1 retrieval selection/feature feedback; B2 bounded child recovery; B3 ephemeral workspace plus durable receipts; B4 intention/method authority; B6 uncertainty/resource governance; B5/GraSP not implemented because it is a closed candidate in Part II and is not part of the five residual bundles.

Show partial, approximate, optional and unwired boundaries rather than using a checklist that implies every source mechanism is fully reproduced. Explicitly state that Part II Chapter 18's proposed bounded-synthesis composition is not automatically proven by the existence of connected modules or passing tests.

## 5. Code and diagram presentation plan

Use a zoom-in/zoom-out sequence:

1. application/service composition diagram;
2. actual graph flow with key conditional routes and loops;
3. graph state references versus authoritative stores;
4. PostgreSQL persistence map (memory, runtime/mechanism records and checkpoint separated);
5. approval → simulated dispatch → lost acknowledgement → reconciliation sequence;
6. two-cycle memory reuse timeline;
7. comparison of same-JVM host-instance reconstruction, same-JVM replacement-pool recovery, focused fresh-JVM action-ledger recovery and full-graph fresh-JVM clarification resume.

For each diagram, name the exact implementation class(es) represented. Every code excerpt must state its repository-relative path, the responsibility demonstrated and the exact test assertion that supports the explanation.

## 6. Claims and exclusions

- Do not claim a production deployment or live supplier/carrier integration.
- Do not claim the main REQ-09 two-cycle test invokes a live model.
- Do not claim that same-process host reconstruction is a fresh-JVM restart.
- Do not claim the REQ-09 test's opaque registry codec is cross-process serialization evidence.
- Do not claim the focused M8B4 forked-JVM action-ledger probe is the full supply-chain application or the full cognitive graph.
- Do not call M8B4C's replacement-pool/host-side reconstruction a fresh-JVM process restart.
- Do not claim the FAIL-11 full-graph clarification test demonstrates recovery after an already-applied simulator effect.
- Do not equate graph checkpoint with CoALA memory or simulator world state.
- Do not equate selected candidate with approved action or unknown transport outcome with business failure.
- Do not claim tests independently validate the research hypotheses or the effectiveness of the five-bundle composition.

## 7. Exercises

1. Draw the actual request-to-completion control path and identify every durable boundary.
2. Explain which record is authoritative after the simulator applied an action but the acknowledgement was lost.
3. Explain the difference among host-instance reconstruction, the focused fresh-JVM action-ledger probe and the full-graph fresh-JVM clarification test.
4. Identify which control owns the objective, resource ceiling, capability permission, approval identity and business feasibility.
5. Find one place where the application implements a paper-inspired control concern approximately or conditionally, and describe what evidence would be needed to strengthen the claim.
