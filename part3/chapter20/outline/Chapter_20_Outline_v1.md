# Chapter 20 Outline — Enterprise Supply-Chain Disruption Management

**CoALA implementation focus:** memory, actions and planning in the supply-chain application.

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — proposed six-chapter structure  
**Outline status:** proposed for individual author approval; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** make the Part I CoALA architecture tangible in the actual Java application: information storage, internal/external action space, and decision procedure.

## 1. Why this chapter exists

Part I already explains CoALA's conceptual architecture, four memory types, internal actions, grounding, planning, evaluation/selection, and iteration. Chapter 20 must not repeat those explanations. It must answer a more concrete question: **where, in this application, do those responsibilities live, what contracts connect them, and what does the code actually do?**

This is the first deep code-reading chapter. It should let a beginner move from the familiar CoALA diagram to repository packages and typed Java contracts without needing to understand LangGraph4j internals yet. The complete runtime graph and persistence assembly are examined in Chapter 24.

## 2. Learning outcomes

By the end of the chapter, readers should be able to:

1. Map CoALA's three architectural dimensions to the actual application modules and services.
2. Distinguish working memory from episodic, semantic and procedural memory in the Java model.
3. Trace internal retrieval, reasoning and learning actions without confusing them with external grounding.
4. Explain how perception and grounding actions are represented and dispatched.
5. Follow a planning request through candidate generation, world-model simulation, evaluation and selection.
6. Explain why a selected planning candidate is not yet an authorized action.
7. Recognize the implementation's engineering choices and approximations rather than attributing them to CoALA.

## 3. Relationship to earlier chapters

- Chapter 2 supplies the CoALA structural map and three dimensions.
- Chapter 3 supplies working, episodic, semantic and procedural memory.
- Chapter 4 supplies retrieval, reasoning and learning as internal actions.
- Chapter 5 supplies external perception and grounding.
- Chapters 6–7 supply proposal, evaluation and selection.
- Chapter 8 supplies the iterative decision procedure.

Use brief reminders and explicit cross-references. Do not reproduce the theory, re-derive CoALA's whole decision-cycle figure, or import Fan & Lan's mechanism bundles into the CoALA explanation. B1's selection overlay is introduced only as an application-specific extension and is fully explained in Chapter 21.

## 4. Detailed section outline

### 20.1 Start from CoALA's three dimensions, then locate the code

Reintroduce the three questions in one compact mapping:

- What information is maintained? → the memory module and active context references.
- What can the agent do internally and externally? → action interfaces and handlers.
- How are operations coordinated over time? → planners, lifecycle services and the cognitive-cycle controller.

Warn that the conceptual CoALA boxes do not require one Java class or one Maven module each. The mapping is a responsibility map, not a literal one-box/one-class translation.

**Diagram:** CoALA's three dimensions overlaid with the actual module/package boundaries. Use distinct visual treatment for conceptual CoALA roles and application-specific components.

### 20.2 Working memory: the active information hub

Explain the problem of maintaining context across steps without treating the LangGraph state map as the entire memory system.

**Code anchors:**

- `supply-chain-agent-memory/.../memory/working/WorkingMemoryService.java`
- `WorkingMemoryRepository.java`
- `WorkingMemorySnapshot.java`
- `WorkingMemoryEntry.java`, `MemoryValue.java`, `Hypothesis.java`
- PostgreSQL implementation in `supply-chain-agent-infrastructure-postgres/.../memory/`

Show the working-memory contract: scope, identifier, version, values/references, update operation and optimistic version check. Explain why observations and evidence references are written as typed values/references rather than unbounded copied transcripts.

Explicitly distinguish:

- CoALA working memory as an application-managed information store;
- `CognitiveCycleState` as graph execution/routing state containing small scalars and references;
- a PostgreSQL graph checkpoint as a persisted snapshot of the graph runtime.

These are related but not interchangeable.

### 20.3 Long-term memory: four kinds, different responsibilities

Use one compact comparison table and then walk through representative contracts:

- **Episodic:** `Episode`, `EpisodeEvent`, `EpisodeOutcome`, `EpisodicMemoryService`. A stored episode is evidence of a past interaction, not automatically a verified reusable rule.
- **Semantic:** `SemanticFact`, `SemanticFactRevision`, `SemanticAdmissionPolicy`, `SemanticMemoryService`. Knowledge has provenance, status and revision/admission boundaries.
- **Procedural:** `ProcedureVersion`, `ProcedureKind`, `ProcedureStatus`, `ProceduralMemoryService`. This stores explicit procedure artifacts; it is not the same as a GraSP skill-DAG execution engine.
- **Working:** recap only as needed to explain interaction with long-term stores.

Explain persistence and retention where the services actually define it. Do not imply every memory item is automatically promoted or that every memory store is used in every test scenario.

**Code anchors:** `supply-chain-agent-memory/.../memory/{episodic,semantic,procedural}/` and the PostgreSQL repository implementations.

### 20.4 Internal actions: retrieval, reasoning and learning

Map the actions from Part I Chapter 4 to code:

- `MemoryRetrievalAction` and `MemoryRetrievalService`: request and retrieve memory candidates across the available stores.
- `ReasoningAction`, `ReasoningProvider`, `ReasoningRequest` and `ReasoningAssessment`: make the reasoning boundary explicit. The provider is an application-owned contract; a LangChain4j adapter is one implementation.
- `WorkingMemoryUpdateAction`: update active information under the relevant version/control checks.
- `EpisodeLearningAction` and `LearningActionCatalog`: record episode outcomes through an explicit learning action path.

Show the action contracts and the registry/catalog boundary. Clarify that reading a memory is not equivalent to using it, and that an episode record is not the same as promoting semantic/procedural knowledge.

**Code anchors:**

- `supply-chain-agent-actions/.../actions/internal/MemoryRetrievalAction.java`
- `.../ReasoningAction.java`, `ReasoningProvider.java`, `ReasoningAssessment.java`
- `.../WorkingMemoryUpdateAction.java`
- `.../EpisodeLearningAction.java`, `.../learning/LearningActionCatalog.java`
- `supply-chain-agent-actions/.../SupplyChainActionCatalog.java`

### 20.5 External actions: perception and grounding in the simulated world

Relate to Part I Chapter 5 without repeating its general taxonomy. Use the supply-chain ports:

- `SupplyChainPerceptionPort` and `SupplyChainPerceptionActions` for observations (supplier, inventory lot, customer order, shipment, quality and available inventory as represented by the current code).
- `SupplyChainSimulationWorld` and `SupplyChainGroundingActions` for state-changing simulation requests.
- `ActionDescriptor`, `ActionHandler`, `ActionRegistry`, `ActionDispatcher`, `ActionReceipt` and the execution ledger for dispatch and result boundaries.

Explain the distinction between an external action candidate and its execution. Show that the action dispatcher, not the planner or model, owns the execution path. Explain expected-version checks, typed failures and idempotency at a high level; the deeper approval and unknown-outcome lifecycle belongs to Chapter 24.

**Important boundary:** the environment is the simulator. The code does not call real supplier/carrier APIs.

### 20.6 Planning: how candidates are generated in this application

Begin with Part I Chapter 6's question: how do possible actions become candidates? Then show the application contracts:

- `PlanningRequest`, `PlanningState`, `PlanningAction`, `PlanCandidate`, `PlanningResult`.
- `PlanningWorldModel` and `SimulatorBackedPlanningWorldModel`.
- `PlanningActionProvider` and `PlanCandidateFactory`.
- `PlannerBudget`, `PlannerExecutionContext` and `PlannerTraceNode` where they materially illuminate control.

Show one small candidate-generation path and how a simulator-backed world model predicts domain transitions. Distinguish internal simulation used to evaluate a candidate from an external observation received after grounding.

### 20.7 Three planner strategies: application algorithms, not new theories

Present the three strategies as separate Java implementations behind the same planning contract:

- `SequentialReasoningPlanner` (sequential reasoning / CoT-style label in the repository).
- `ThoughtSearchPlanner` (bounded tree/search strategy; “ToT-inspired” is a descriptive engineering label, not a claim to reproduce a separate research framework).
- `MctsSearchPlanner` (domain-grounded Monte Carlo tree search; “RAP-inspired” is a descriptive label, not a claim of canonical RAP reproduction).

Explain their shared inputs/outputs, search bounds and resource constraints. The `PlannerRouter`, `DefaultPlannerSelectionPolicy` and `PlannerMethodResolver` select a strategy; they do not become part of the strategies' search algorithms.

The book's formal foundations remain CoALA and Fan & Lan. Do not create a Tree of Thoughts or RAP theory section, and do not claim CoALA prescribes these specific algorithms.

### 20.8 Evaluation and selection: a candidate is not yet an action

Map Part I Chapter 7 onto:

- `CandidateEvaluator`, `DeterministicCandidateEvaluator`, `PlanEvaluation`;
- hard domain constraints and infeasible/blocked candidates;
- selection of a candidate for the next control stage.

Make three distinctions explicit:

1. Proposal generates possibilities; evaluation assesses them; selection chooses or rejects.
2. Planner selection chooses a method; candidate selection chooses a proposed action. These are different selections.
3. Selecting a plan does not authorize it. Approval/capability checks and dispatch are later boundaries, covered in Chapter 24.

### 20.9 CoALA's iterative procedure: preview the concrete graph

Give a compact mapping from Part I Chapter 8 to the application: retrieve/prepare context, reason and propose, evaluate, respond to impasse or new evidence, execute an authorized external action or internal learning action, observe and continue. Do not teach the complete graph topology here; Chapter 24 owns the graph nodes, conditional edges and checkpoint/resume behavior.

The application graph is one engineering schedule for the CoALA capabilities. It is not a claim that CoALA mandates the same fixed sequence.

### 20.10 Worked code trace: from request to evaluated candidate

Use a deterministic full-graph scenario/test to trace only the CoALA-relevant portion:

1. request enters the host;
2. request interpretation produces a normalized intent or clarification outcome;
3. working context is loaded;
4. memory is retrieved and selected;
5. evidence is made available for the reasoning/planning step;
6. planner strategy proposes candidates;
7. deterministic evaluator identifies selected, rejected or infeasible candidates.

Stop before the full approval/dispatch/reconciliation story; Chapter 24 will trace that complete lifecycle. Use exact test names only where their assertions demonstrate the described step.

### 20.11 Recap and repository reading map

Close with a compact CoALA-to-code table and a “read next” path into Chapters 21–24. Include short exercises asking the reader to distinguish a memory record, an internal action, a planning candidate, an external action descriptor and an authorization decision.

## 5. Key source files and symbols to prioritize

- Memory: `supply-chain-agent-memory/src/main/java/dev/supplychain/agent/memory/working/WorkingMemoryService.java`; corresponding `episodic/`, `semantic/`, `procedural/` services; `memory/retrieval/MemoryRetrievalService.java`.
- Actions: `supply-chain-agent-actions/src/main/java/dev/supplychain/agent/actions/SupplyChainActionCatalog.java`; `actions/internal/`; `actions/external/perception/`; `actions/external/grounding/`; `actions/api/ActionRegistry.java`; `ActionDispatcher.java`.
- Planning: `supply-chain-agent-planning/src/main/java/dev/supplychain/agent/planning/api/`; `cot/SequentialReasoningPlanner.java`; `tot/ThoughtSearchPlanner.java`; `mcts/MctsSearchPlanner.java`; `routing/PlannerRouter.java`.
- Runtime bridge for the cycle preview: `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/CognitiveCycleGraph.java`; `CognitiveCycleState.java`; `CognitiveCycleOperations.java`.

## 6. Tests to use—and what they do not prove

Use unit/component tests as focused executable examples:

- `supply-chain-agent-memory/src/test/java/dev/supplychain/agent/memory/working/WorkingMemoryServiceTest.java`, `episodic/EpisodicMemoryServiceTest.java`, `semantic/SemanticMemoryServiceTest.java`, `procedural/ProceduralMemoryServiceTest.java`, and `retrieval/MemoryRetrievalServiceTest.java`.
- `supply-chain-agent-actions/src/test/java/dev/supplychain/agent/actions/CoalaInternalActionsTest.java`, `LearningActionCatalogTest.java`, `SupplyChainActionCatalogTest.java`, `SupplyChainExternalActionsTest.java`, and `ActionDispatcherTest.java`.
- `supply-chain-agent-planning/src/test/java/dev/supplychain/agent/planning/cot/SequentialReasoningPlannerTest.java`, `ThoughtSearchPlannerTest.java`, `MctsSearchPlannerTest.java`, `DeterministicCandidateEvaluatorTest.java`, and `PlannerRouterTest.java`.
- `supply-chain-agent-runtime/src/test/java/dev/supplychain/agent/runtime/cognitive/CognitiveCycleGraphTest.java` for graph-level behavior.

Use `M8B4FullGraphWorkflowTest` only to demonstrate the exact workflow path it asserts; do not treat it as proof that every real-model adapter was exercised. In the principal durable end-to-end test, the request interpreter and reasoning provider are deterministic test implementations, not live LangChain4j model calls.

## 7. Diagrams and code presentation

Recommended figures:

1. CoALA three-dimension-to-code map.
2. Four memory stores and their read/write paths.
3. Internal versus external action path.
4. Candidate generation → simulation/evaluation → candidate selection.
5. Three planner strategies behind one contract.
6. Distinction among planner selection, candidate selection and action authorization.

Use short listings for records/interfaces and one or two key methods. For larger collaboration paths, prefer a sequence diagram plus a small “where to look” table. Do not reproduce full classes or use source screenshots.

## 8. Boundaries

- CoALA supplies the conceptual categories; repository classes are this application's implementation.
- CoALA does not prescribe the exact Java class/module split, planner algorithms, LangGraph4j graph topology or PostgreSQL schema.
- Cross-store memory retrieval and B1 selection are distinct; Chapter 21 explains their combined pipeline.
- B3 workspace admission is distinct from B1 memory selection; Chapter 21 explains the handoff. B2 protected recovery is developed separately in Chapter 22.
- Graph state/checkpoints are not the complete CoALA memory system.
- Planning and selection never bypass domain feasibility or authorization.
- “ToT-inspired” and “RAP-inspired” labels do not create additional theoretical foundations.
