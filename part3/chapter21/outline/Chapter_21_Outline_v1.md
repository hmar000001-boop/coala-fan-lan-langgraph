# Chapter 21 Outline — Memory Selection and Workspace Competition: B1 and B3

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — proposed six-chapter structure  
**Outline status:** proposed for individual author approval; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** explain the evidence path from cross-store memory retrieval through B1 selection into B3's bounded workspace competition, admission and broadcast.

## 1. Purpose and teaching contract

Part II Chapters 12 and 14 explain B1 and B3; Chapter 18 explains their dependency and the risk of treating them as duplicate rankers. This chapter must make their distinct control questions concrete in the Java application:

- the base CoALA retrieval service produces memory candidates from the available stores;
- B1 evaluates which memory candidates should be accessible to the current cycle under latency, utility, maintenance-cost and context constraints;
- B3 evaluates which heterogeneous evidence/candidate content should enter a bounded workspace and be made available to designated consumers;
- downstream use and outcome evidence are recorded separately from retrieval, selection and admission.

B1 and B3 are grouped because they form a useful evidence-flow teaching sequence, not because they are the same selector. The chapter must show where the handoff occurs and where the purposes diverge. B2 protected recovery is deliberately reserved for Chapter 22.

## 2. Learning outcomes

Readers should be able to:

1. Apply Part II Chapter 10's seven-field S/C/T/P/F/L/R reading lens to the B1 and B3 Java implementations.
2. Trace cross-store CoALA memory retrieval into B1 candidate construction and bounded selection.
3. Explain B1's accessibility, cognitive-latency, infrastructure-latency, downstream-utility, maintenance-cost and outcome-feedback signals.
4. Explain the B1-to-working-memory projection and distinguish it from copying source memory records.
5. Trace B3's competition, admission, cycle-scoped workspace snapshot, broadcast, consumer receipt and verified outcome evidence.
6. Explain why B1 memory selection is not B3 workspace admission and why B3 broadcast is not action authorization.
7. Identify which B1 maintenance and B3 workspace data are not durable in the same way as the PostgreSQL-backed evidence records.

## 3. Relationship to earlier chapters

- **CoALA:** Chapters 3–4 provide memory and internal retrieval/learning vocabulary; Chapter 8 supplies the cycle context. Chapter 20 explains the application's general CoALA memory and action contracts.
- **Fan & Lan:** Chapter 12 is the B1 source analysis; Chapter 14 is the B3 analysis; Chapter 10 supplies the seven fields; Chapter 18 explains the B1/B3 relationship and composition boundaries.
- Do not repeat ACT-R or LIDA history. Refer to the source analysis and explain only what is needed to read the implementation.

## 4. Detailed section outline

### 21.1 Read B1 and B3 through the seven mechanism fields

Briefly recall S (state), C (control), T (trigger), P (persistence), F (failure), L (learning) and R (resource/governance). Use these questions to inspect the source without forcing a field where implementation evidence is absent. Keep the Part II review's evidence/depth classifications distinct from the Java implementation's test status.

### 21.2 Base retrieval and B1 candidate construction

Explain the pipeline's first boundary:

1. `MemoryRetrievalService` retrieves records from the available CoALA stores under the active memory scope/query.
2. `B1MemoryCandidateFactory` turns retrieved records/references into typed B1 candidates with identity, access history, cue associations, expected downstream utility, context units and a maintenance profile.
3. `CognitiveCycleDecisionServices.retrieveEvidence` composes retrieval with candidate construction and B1 selection.

Explain why a memory record, a retrieval candidate and an item ultimately selected for active context are three different things.

**Code anchors:**

- `supply-chain-agent-memory/src/main/java/dev/supplychain/agent/memory/retrieval/MemoryRetrievalService.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1MemoryCandidateFactory.java`
- `B1MemoryCandidate.java`, `B1SelectionRequest.java`
- `supply-chain-agent-runtime/.../decision/CognitiveCycleDecisionServices.java` — `retrieveEvidence`.

### 21.3 B1: accessibility, latency, utility, cost and bounded selection

Walk through `B1RetrievalSelector.select` using a small worked candidate table. Explain the distinct scoring terms:

- activation/accessibility estimate from `RecencyFrequencyActivationEstimator`;
- predicted cognitive retrieval latency from `ExponentialActivationLatencyModel`;
- measured infrastructure latency, which is not the same as cognitive retrieval time;
- expected downstream utility;
- estimated maintenance cost from `MaintenanceProfile`;
- bounded outcome-feedback adjustment;
- context units, maximum candidate count and configured selection thresholds;
- an uncertainty directive that may impose a minimum diversity of memory kinds.

Explain the engineering score as implemented in the selector. Do not label it as ACT-R's exact activation equation, an empirically calibrated probability or a faithful reproduction of the entire B1 hypothesis. Accessibility is represented numerically, but calibration is not established by representation alone.

**Primary code anchors:**

- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1RetrievalSelector.java`
- `RecencyFrequencyActivationEstimator.java`, `ExponentialActivationLatencyModel.java`
- `B1CandidateScore.java`, `B1SelectionResult.java`, `B1SelectionPolicy.java`
- `B1MemoryCandidate.java`, `MaintenanceProfile.java`.

### 21.4 Project selected references into CoALA working memory

Explain the post-selection step in `CognitiveCycleDecisionServices.retrieveEvidence`:

- verify that selected candidates belong to the active scope and came from the retrieval result;
- separate working-memory candidates from selected long-term-memory candidates;
- project stable, scope-bound references into the current working-memory snapshot;
- retain the authoritative episodic/semantic/procedural source records in their own repositories;
- reject stale or mismatched working-memory versions rather than silently merging them.

**Code anchor:** private `projectSelectedMemoryReferences` in `CognitiveCycleDecisionServices`. This is a valuable implementation detail because it makes retrieval-to-working-memory transfer explicit without treating working memory as a duplicate of all long-term records.

### 21.5 B1 feedback and maintenance: distinguish implemented paths

Show the verified feedback path precisely:

- `B1MemoryFeatureLearningService.recordSelected` records selection/access history and cue associations under idempotency constraints;
- `B3OutcomeEvidenceService` verifies receipt/outcome evidence before `B1MemoryFeatureLearningService.applyVerifiedOutcome` can use it;
- `PostgresB1MemoryFeatureRepository` persists B1 feature state in the durable host.

State the maintenance caveat prominently: B1 selection scores estimated maintenance cost through each candidate's `MaintenanceProfile`, and `MemoryMaintenanceAccountingService`/`MemoryMaintenanceLedger` exist and are used by the evaluation ablation path. However, the standalone maintenance-accounting service is not wired into `DurableCognitiveApplicationHost` in this source snapshot. Do not describe full runtime maintenance-event accounting as part of the durable application path.

**Tests:** `B1MemoryCandidateFactoryTest`, `B1RetrievalSelectorTest`, `B1MemoryFeatureLearningServiceTest`, `PostgresM7B1PersistenceIntegrationTest`. The ablation runner is a separate evaluation/utility path, not the main application host.

### 21.6 B3: heterogeneous competition, workspace admission and broadcast

Start from the different question B3 asks: which content should be available to the next bounded reasoning/workspace cycle? Explain the implemented stages:

- typed workspace candidates are prepared by the application/domain boundary;
- `WorkspaceAdmissionService` applies the admission policy;
- `WorkspaceCoalitionCompetitionPolicy` handles competition/coalition selection under capacity constraints;
- the selected content is represented in a bounded workspace snapshot;
- `WorkspaceBroadcastService` makes admitted content available to designated downstream consumers;
- consumer receipts and verified downstream outcome evidence preserve whether the content was received/used and what followed.

Follow one item through competition → admission → snapshot → broadcast → consumer receipt → outcome evidence. Broadcast makes selected content available; it does not execute or authorize the action described by that content.

**Persistence boundary:** `DurableCognitiveApplicationHost` composes an in-memory per-cycle workspace repository. Workspace snapshots are ephemeral in this composition; B3 receipt/outcome evidence is persisted through PostgreSQL adapters. Do not call the workspace a durable global memory store.

**Primary code anchors:**

- `supply-chain-agent-mechanisms/.../b3/WorkspaceAdmissionService.java`
- `WorkspaceCoalitionCompetitionPolicy.java` and workspace candidate/snapshot/admission records
- `WorkspaceBroadcastService.java` and consumer receipt contracts
- `B3OutcomeEvidenceService.java`, `VerifiedDownstreamOutcomeEvidence.java`
- `supply-chain-agent-app/.../durable/DurableCognitiveApplicationHost.java`
- B3 receipt/outcome repositories under `supply-chain-agent-infrastructure-postgres`.

**Tests:** `WorkspaceAdmissionServiceTest`, `B3OutcomeEvidenceServiceTest`, `M8B4FullGraphWorkflowTest.fullGraphB3BroadcastPersistsReceiptAndSupportsVerifiedOutcomeLearningEvidence`.

### 21.7 The B1 → B3 boundary: related, not interchangeable

Use one sequence diagram and a responsibility table:

- cross-store retrieval constructs the memory candidate set;
- B1 selects useful memory candidates under its scoring and context constraints;
- selected long-term memory references are projected into working memory;
- B3 receives typed workspace content and decides what competes for bounded admission and broadcast;
- receipts/outcome evidence provide a later feedback path; they do not collapse selection and admission into one decision.

Explain that B1 selects memories while B3 governs the workspace contents for a cycle. A retrieved or B1-selected item may still fail B3 admission. A B3-admitted/broadcast item still has no external-action permission.

### 21.8 Seven-field implementation summary, recap and exercises

Provide separate B1 and B3 tables with S/C/T/P/F/L/R and an implementation status column. Recommended wording:

- **B1:** integrated candidate construction, selection and verified feature-feedback path; estimated maintenance cost participates in selection; standalone maintenance-event accounting is not wired into the durable host.
- **B3:** integrated bounded workspace admission/broadcast with durable receipts/outcome evidence; the workspace snapshot itself is ephemeral in the current durable-host composition.

Ask readers to identify (a) a memory retrieved but not selected by B1, (b) a B1-selected reference not admitted by B3, and (c) a B3 broadcast that still cannot authorize an external action.

## 5. Recommended diagrams

1. Cross-store CoALA retrieval → B1 candidate factory → B1 selector → selected references.
2. B1 score decomposition and bounded context selection.
3. Selected long-term references projected into working memory, with source records remaining authoritative in their stores.
4. B3 competition → workspace admission → ephemeral snapshot → broadcast → receipts → verified outcome evidence.
5. A side-by-side authority map: B1 memory selection, B3 workspace admission and external action authorization.

## 6. Code presentation standards

For each mechanism, show the control question, smallest state/contract types, method that owns the decision, runtime caller/trigger, persisted versus ephemeral state, one rejection/failure case, and exact test assertion. Prefer short Java excerpts plus one sequence diagram over broad package dumps.

## 7. Boundaries to preserve

- B1 is not simply vector retrieval and is not ACT-R reproduced exactly.
- B1 selection and B3 workspace admission are distinct control decisions.
- B3 broadcast does not confer action capability or approval.
- B1 outcome learning requires verified downstream evidence, not retrieval/admission alone.
- Estimated maintenance-cost scoring is implemented; full durable maintenance-event accounting is not wired into the host.
- These Java services are engineering realizations, not mechanisms prescribed by Fan & Lan.
