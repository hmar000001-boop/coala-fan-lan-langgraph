# Chapter 21 — Memory Selection and Workspace Competition: B1 and B3

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — Engineering a Simulated Supply-Chain Agentic Application with Java  
**Outline status:** explicitly approved by the author on 25 November 2026; Chapter 21 prose drafted from this outline  
**Implementation baseline:** `supply-chain-agent-main (9).zip`, supplied source snapshot, SHA-256 `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`  
**Accepted source correction:** the two-file B1 utility-scale fix preserves provider-supplied task-scale utility during feature enrichment; the author confirmed GitHub Actions CI green on 25 November 2026. The maintenance profile and B3 coalition implementation remain unchanged from the supplied snapshot. Accepted change-only ZIP SHA-256: `ceff62bd7b459bf6b8472f1b02ad77be593f836dd444a3dc5adb533bd313f93d`.
**Book source snapshot:** `coala-fan-lan-langgraph-main (1).zip`, SHA-256 `57ad1dc0ab694e7818b62a05a40a876b50313296cd6947b0a3b582572e144143`  
**Verification scope:** the book source, the supplied application snapshot plus the accepted two-file B1 correction, and named test methods were inspected. The author confirmed the B1 correction passed GitHub Actions CI; this LaTeX reconciliation did not modify or rerun the application.  
**Chapter role:** explain two connected but distinct evidence-control decisions in the as-built application: B1 selects retrieved memory candidates for a cognitive cycle; B3 admits separately prepared heterogeneous content into a bounded workspace, broadcasts it to designated consumers and records later evidence without conflating acknowledgement with usefulness.

---

## 1. Purpose and teaching contract

Chapter 20 ends at the seam between CoALA's base memory retrieval and the later selection/admission controls. It establishes that `MemoryRetrievalService` retrieves records and that its result is not, by itself, a B1 ranking, a B3 workspace, or an automatic reasoning pipeline. Chapter 21 begins at that seam. It must not repeat Chapter 20's explanation of the four CoALA memory types or re-teach the implementation of the base retrieval service.

The chapter follows one connected evidence path while preserving two different control questions:

- **B1:** given memory candidates returned by base retrieval, which memories should be made accessible to the current cycle under accessibility, latency, expected downstream utility, maintenance-cost and context-budget constraints?
- **B3:** given a separately prepared set of typed workspace candidates, which content should be admitted to a bounded cycle workspace, and which designated consumers should receive it?

The two mechanisms are related, but they are not duplicate rankers and the second candidate set is not automatically the first candidate set copied forward. The application/domain adapter prepares the B3 request and may explicitly attribute a B3 candidate to exact B1-selected memory revisions. That mapping is optional, validated and separate from both selection decisions.

The chapter must distinguish at least these states and events:

1. a memory record exists in its authoritative store;
2. base retrieval returns that record as a candidate;
3. B1 selects or rejects the candidate;
4. selected long-term references may be projected into CoALA working memory;
5. a separately prepared B3 workspace candidate competes for admission;
6. B3 admits the candidate into a workspace snapshot;
7. a designated consumer receives and acknowledges some admitted content;
8. independently verified downstream outcome evidence may later update an exact attributed B1 memory revision or contribute to a separately governed B3 coalition-feedback path.

These are not interchangeable meanings of “selected”, “admitted”, “broadcast”, “consumed”, “used” or “helpful”.

## 2. Learning outcomes

By the end of the chapter, readers should be able to:

1. Apply Fan & Lan's seven-field S/C/T/P/F/L/R analytical lens to the implemented B1 and B3 control paths without treating the tuple as a required software architecture or filling unsupported fields by assumption.
2. Trace the runtime sequence from M2 cross-store retrieval through `B1MemoryCandidateFactory`, optional feature enrichment, `B1RetrievalSelector`, evidence-set persistence and selected-reference projection.
3. Explain the implemented B1 score as an engineering objective, identify its separate latency and cost terms, and explain its bounded selection constraints.
4. Distinguish trusted candidate-feature inputs from values derived by the selector itself.
5. Explain how selected long-term memory references are projected into working memory while authoritative source records remain in their original stores.
6. Distinguish selection-access history, verified downstream-use history, per-memory feature learning, generic candidate-score feedback, and maintenance-cost accounting.
7. Trace how the domain/runtime boundary prepares typed B3 candidates, and explain why the B3 candidate set is not automatically identical to the B1-selected memory list.
8. Explain B3 mandatory-content protection, singleton/coalition competition, capacity and conflict constraints, bounded coalition enumeration, and incomplete-admission outcomes.
9. Distinguish an ephemeral workspace snapshot from durable broadcast receipts and verified outcome records in the current durable-host composition.
10. Explain why an accepted broadcast receipt is not a verified useful outcome, why verified outcomes must be bound to a consumed candidate and its exact evidence, and how a verified outcome can update only its explicitly attributed B1 memory revision.
11. Identify what the current unit, graph and PostgreSQL integration tests prove—and what remains untested, especially direct PostgreSQL round-trip coverage for B1 feature state.

## 3. Relationship to Parts I and II

### 3.1 Continuity from CoALA

- Chapters 3–4 establish the vocabulary of memory and internal retrieval/learning actions.
- Chapter 8 establishes the wider decision-cycle context.
- Chapter 20 maps the application's memory records and basic internal actions to CoALA.
- Chapter 21 narrows its attention to the decisions that occur **after base retrieval**: B1 candidate selection and B3 bounded workspace admission/broadcast.

Do not repeat the memory taxonomy, the basic retrieval explanation, or the general CoALA cycle. Briefly recall only the concepts needed to understand why selected long-term references are placed into working memory and why downstream evidence is a distinct learning event.

### 3.2 Continuity from Fan & Lan

- Chapter 10 defines the seven fields: operative state substrate (S), control locus (C), transition trigger (T), persistence boundary (P), failure semantics (F), learning operator (L), and resource/governance policy (R).
- Chapter 12 analyzes B1's activation/accessibility, retrieval latency, downstream value and maintenance-cost concerns.
- Chapter 14 analyzes B3's typed-content competition, workspace, broadcast and admission learning.
- Chapter 18 explains why B1 and B3 must retain distinct candidate domains and decision objectives when composed.

The implementation discussion should refer to those earlier analyses instead of repeating the ACT-R or LIDA historical accounts. The Java implementation is an engineering realization for this simulated application, not an implementation prescribed by Fan & Lan. Preserve the difference between the paper's mechanism hypothesis, the book's proposed designs in Part II, and the as-built Java services in Part III.

### 3.3 Why B1 and B3 share a chapter

The grouping follows a useful teaching path—memory candidates become selected references, then selected evidence can be explicitly represented among workspace candidates—but it does **not** assert that B1 and B3 are one mechanism or that Fan & Lan prescribe a single linear implementation. The prose and figures must show the explicit application/domain handoff between them.

## 4. Detailed section outline

### 21.1 Two different selection problems follow retrieval

**Teaching question:** after the application retrieves relevant memories, why is another decision needed—and why is that decision not the same as deciding what enters a workspace?

- Open with a small supply-chain request in which the system can retrieve several records: a current working-memory fact, an episodic record of a previous disruption, a semantic supplier constraint and an approved procedural record. These are illustrative candidate types, not claims that all four must be returned in every cycle.
- Recall that Chapter 20's M2 service performs exact, scope/time-aware base retrieval; it does not assign B1 activation/utility scores or assemble a B3 workspace.
- Introduce B1's memory-candidate decision and B3's heterogeneous workspace-content decision as separate questions.
- Establish the vocabulary distinction: retrieved, B1-selected, projected, B3-admitted, broadcast, consumed, and verified useful outcome.
- Introduce S/C/T/P/F/L/R as a reading checklist for the two implementations, not as a scoring rubric or a checklist that every field must be fully implemented.

**Boundary:** do not repeat Fan & Lan's full B1/B3 theory or the seven-field definitions from Chapter 10. Refer readers back to those chapters and immediately move to the source code.

### 21.2 From base retrieval to B1 candidates: the exact runtime sequence

**Teaching question:** what actually happens between the M2 retrieval result and the B1 selector?

Trace the real call path in `CognitiveCycleDecisionServices.retrieveEvidence`:

1. obtain the active cycle time, memory scope, M2 `MemoryRetrievalQuery`, B1 `B1SelectionRequest` and current B6 uncertainty directive;
2. reject inconsistent retrieval/selection scopes;
3. call `MemoryRetrievalService.retrieve`;
4. adapt the returned records/references through `B1MemoryCandidateFactory.from`;
5. obtain candidate features through the injected `B1CandidateFeatureProvider` port;
6. optionally enrich candidates from persisted `B1MemoryFeatureLearningService` state;
7. call `B1RetrievalSelector.select`;
8. reject the evidence result if a B6 minimum-distinct-memory-kind requirement is not met;
9. persist the selected evidence-set artifact through the domain port;
10. project selected long-term references into the active CoALA working-memory snapshot;
11. record selected-access history through `B1MemoryFeatureLearningService.recordSelected`.

Explain three important implementation details:

- The feature provider is an application-supplied sidecar port. It supplies access history, cue-association strengths, expected downstream utility, context units, measured infrastructure latency and a maintenance profile. The selector does not derive these values from the memory record; the values are estimates/features, not memory contents or authority.
- B1 selection occurs only after M2 retrieval. B1 does not replace the base retrieval service or search every memory store independently.
- The sequence is composed by the runtime; the individual contracts do not imply that every application must use this exact schedule.

Explain fail-closed behavior at the actual boundaries: scope mismatch, invalid/duplicate candidates, unmet evidence-diversity requirement, missing persisted evidence-set identity, invalid/stale working-memory projection, and projection version conflict.

**Code anchors:**

- `supply-chain-agent-memory/src/main/java/dev/supplychain/agent/memory/retrieval/MemoryRetrievalService.java` — use only as the already-taught M2 boundary; do not reproduce its internals.
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1MemoryCandidateFactory.java`
- `B1CandidateFeatureProvider.java`, `B1CandidateFeatures.java`, `B1MemoryCandidate.java`, `B1SelectionRequest.java`
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/decision/CognitiveCycleDecisionServices.java` — `retrieveEvidence`.

**Tests:**

- `B1MemoryCandidateFactoryTest.adaptsWorkingEpisodicSemanticAndProceduralMemoryWithoutChangingM2Records`
- `B1MemoryCandidateFactoryTest.refusesWorkingMemoryFromDifferentScope`
- `B1MemoryCandidateFactoryTest.expiredWorkingMemoryCannotEnterActivationSelection`
- `B1MemoryCandidateFactoryTest.historicalUnverifiedEpisodeIsNotAdmittedToB1Candidates`
- `CognitiveCycleDecisionServicesTest.retrievalUsesM2BeforeB1AndPersistsTheSelectedEvidenceSet`

### 21.3 B1 scoring: what the implemented score actually measures

**Teaching question:** how does the selector compare memory candidates when context is limited?

Introduce the selector's score term by term. Present the actual implementation as an engineering objective, not as ACT-R's equation and not as a calibrated probability model:

\[
U_{B1}(m)=P_{access}(m)\,V_{downstream}(m)
-\lambda_c L_{cognitive}(m)
-\lambda_i L_{infrastructure}(m)
-C_{maintenance}(m)
+A_{outcome}(m)
\]

Define every symbol directly from the code:

- **Activation/accessibility:** `RecencyFrequencyActivationEstimator` combines an access-history strength derived from age/recency and frequency with query-cue association strengths. The selector maps total activation through a bounded logistic transform to an accessibility estimate.
- **Predicted cognitive retrieval latency:** `ExponentialActivationLatencyModel` estimates a cognitive-time term from activation and applies configured lower/upper bounds.
- **Measured infrastructure latency:** a separately supplied duration for the retrieval infrastructure. It is not the same thing as predicted cognitive retrieval time.
- **Expected downstream utility:** a task-scale feature supplied by the trusted candidate-feature provider. The accepted B1 enrichment path preserves this value; the persisted normalized [0,1] outcome-quality statistic is not copied into the candidate utility because no calibration between the scales is defined.
- **Estimated maintenance cost:** the actual `MaintenanceProfile` contains `admissionValidationCost`, `refreshCost`, `recurringCostPerDay`, `refreshInterval` and `lastMaintainedAt`. `estimateCost(evaluatedAt, horizon)` always adds admission-validation cost, adds refresh cost when the configured interval is due, and adds recurring cost over the horizon. The code does not clarify whether admission-validation cost represents repeated selection-time work or a historical one-time admission expense. If the latter, repeated charging would conflict with Chapter 12's sunk-cost rule; do not claim the implementation enforces amortization. The selector does not schedule or execute maintenance, and the separate maintenance event ledger is not wired into the durable host.
- **Outcome adjustment:** an optional trusted `CandidateOutcomeAdjustment`, bounded by the selector; it is not the same object as the persisted per-memory feature state or B3 coalition adjustment.

Then explain the bounded selection procedure:

- sort by descending net utility with candidate ID as deterministic tie-breaker;
- enforce maximum selected-candidate count;
- enforce minimum accessibility and minimum net utility thresholds;
- enforce total context-unit budget;
- when the active B6 uncertainty directive requires distinct memory kinds, the first selection pass avoids already represented kinds while the diversity floor is unmet; a second bounded pass may fill remaining slots with other eligible kinds. If the floor still cannot be met, the result reports `diversitySatisfied == false`, and the runtime fails the evidence step before persistence/projection.

Use a small worked table with a few candidates and illustrative numeric values to show why a high-accessibility memory can still lose because of low expected downstream utility, high measured I/O latency, maintenance cost, or context size. Clearly label invented values as **[Book example]**; do not present them as measurements from the application or empirical findings.

Explicit limitations:

- the recency/frequency estimator is not a literal ACT-R activation implementation;
- the bounded logistic value is not calibrated merely because it lies in [0,1];
- the selector uses candidate ID as its deterministic tie-breaker after descending net utility; this stabilizes equal-score ordering but does not establish relevance or quality;
- `ExponentialActivationLatencyModel` is a selected engineering model, not a measured human retrieval law;
- infrastructure latency, cognitive latency and maintenance cost use distinct meanings and must not be merged;
- no independent experimental conclusion about B1 effectiveness is established in this chapter. The archived M8-B3-v1 fixture results predate the accepted 25 November B1 utility-scale correction and were not rerun against the accepted enrichment behavior. They therefore do not validate that correction. The maintenance profile and B3 coalition-search implementation were not changed by the accepted patch; their historic fixture outputs still describe those code paths but do not resolve the admission-validation cost ambiguity or establish a strict bound on all recursive search operations.

**Code anchors:**

- `B1RetrievalSelector.java`
- `RecencyFrequencyActivationEstimator.java`
- `ExponentialActivationLatencyModel.java`
- `B1ScoringPolicy.java`, `B1CandidateScore.java`, `B1SelectionResult.java`
- `MaintenanceProfile.java`

**Tests:**

- `B1RetrievalSelectorTest.recentAndFrequentAccessProducesGreaterActivation`
- `B1RetrievalSelectorTest.cueAssociationContributesToActivation`
- `B1RetrievalSelectorTest.strongerActivationReducesPredictedCognitiveLatency`
- `B1RetrievalSelectorTest.selectorRanksByExpectedDownstreamValueAndFitsContextBudget`
- `B1RetrievalSelectorTest.measuredInfrastructureLatencyIsSeparateFromCognitiveLatency`
- `B1RetrievalSelectorTest.maintenanceCostIsIncludedInNetUtility`
- `B1RetrievalSelectorTest.scopeMismatchIsRejected`
- `B1RetrievalSelectorTest.duplicateCandidateIdsAreRejected`
- `B1RetrievalSelectorTest.maintenanceProfileChargesRefreshWhenDueAndRecurringHorizonCost`

### 21.4 The B1 result is projected as references, not copied memory documents

**Teaching question:** once B1 selects a long-term memory, what changes in CoALA working memory?

Explain the exact behavior of `projectSelectedMemoryReferences`:

- selected candidates are checked against the original M2 retrieval result and active memory scope;
- working-memory candidates are not projected again;
- selected episodic/semantic/procedural records are represented in working memory by stable, scope-bound references;
- original long-term records remain authoritative in their own repositories;
- the projection uses the active working-memory identity and expected version;
- stale scope, expired working memory, invalid candidate provenance or a concurrent version change causes a fail-closed result;
- a narrowly identified retry after the exact prior projection may be recognized as idempotent, while an unrelated later write is not treated as a replay.

Clarify that projection is a runtime composition step following B1 selection; it is not an automatic side effect of `MemoryRetrievalService` or `B1RetrievalSelector` in isolation.

**Code anchor:** `CognitiveCycleDecisionServices.projectSelectedMemoryReferences` and the working-memory service/repository contracts it calls.

**Tests:**

- `CognitiveCycleDecisionServicesTest.selectedLongTermMemoryIsProjectedAsVersionedEvidenceReferencesIntoWorkingMemory`
- `CognitiveCycleDecisionServicesTest.selectedLongTermMemoryCannotBeProjectedAcrossWorkingMemoryVersionConflict`
- `CognitiveCycleDecisionServicesTest.selectedLongTermMemoryProjectionIsIdempotentAfterGraphCheckpointInterruption`.

### 21.5 B1 learning and maintenance are related but different lifecycles

**Teaching question:** how does a memory's future selection profile change, and what does the application really account for?

Split the section into three separate paths.

#### 21.5.1 Selection and access history

- `B1MemoryFeatureLearningService.enrich` incorporates persisted per-memory access history, verified-use history and cue strengths while preserving the trusted provider's task-scale `expectedDownstreamUtility`. The persisted [0,1] outcome-quality EWMA is diagnostic and is not substituted for candidate utility.
- `recordSelected` writes selection/access information with an idempotency identity tied to execution, evidence set and candidate, so a checkpoint retry does not inflate access frequency.
- Distinguish candidate retrieval, candidate selection and later verified downstream use; they must not be counted as the same event.

#### 21.5.2 Verified outcome feedback

- B3's receipt and outcome subsystem is the route through which verified downstream evidence can update B1 memory features.
- A receipt is bound to one workspace/consumer; only an accepted receipt with the candidate recorded as consumed can support a candidate outcome.
- Outcome evidence is checked by the configured verifier, tied to the candidate fingerprint and experiment-unit fingerprint, and revalidated when verified training evidence is read.
- B1 attribution identifies exact memory kind/scope/record/revision and candidate fingerprint. Only that exact attributed revision may receive the update.
- Updates are idempotent by verified outcome key. `USEFUL`, `HARMFUL` and `NEUTRAL` map to 1.0, 0.0 and 0.5 for a normalized [0,1] outcome-quality EWMA stored under the legacy component/JSON field name `expectedDownstreamUtility`; later outcomes use `0.8 × old + 0.2 × reward`. The accepted B1 fix preserves the provider's task-scale candidate utility during enrichment; the normalized EWMA remains in the persisted feature state and is not fed to the selector as candidate utility. Cue associations move by +0.1, −0.1 or 0.0 and remain within [0,1]; the matching outcome counter and verified-use history are updated. Explain these rules as bounded feature bookkeeping, not as calibrated task-utility learning, adaptive selector-weight learning or a general learning guarantee.

#### 21.5.3 Maintenance cost versus maintenance-event accounting

- `MaintenanceProfile.estimateCost(evaluatedAt, horizon)` literally adds `admissionValidationCost` on every estimate, adds `refreshCost` when `lastMaintainedAt + refreshInterval` is not later than `evaluatedAt`, and adds `recurringCostPerDay × horizonDays`. The source does not disambiguate whether `admissionValidationCost` represents work repeated at selection time or a historical sunk admission cost; state that ambiguity rather than claiming a marginal/amortized redesign. The profile estimates cost only and does not execute maintenance.
- `MemoryMaintenanceAccountingService` and its ledger record/aggregate actual maintenance events in a distinct accounting path used by `MechanismAblationRunner`.
- The standalone accounting service is not wired into `DurableCognitiveApplicationHost` in this source snapshot. Do not say that the durable application automatically logs all maintenance events or that the cost estimate is an observed cost.

#### 21.5.4 Persistence and test limits

- The durable host constructs `PostgresB1MemoryFeatureRepository`, so B1 feature-state persistence is part of the host composition. In the same composition, it creates `WorkspaceAdmissionService` with `InMemoryWorkspaceRepository`, while `B3OutcomeEvidenceService` receives the PostgreSQL B3 receipt/outcome repository and is also used as the `WorkspaceReceiptRecorder`.
- Be explicit that the current repository does **not** contain a focused PostgreSQL integration test that round-trips `PostgresB1MemoryFeatureRepository`/B1 feature-state updates.
- Do **not** cite `PostgresM7B1PersistenceIntegrationTest` as proof of B1 feature-state persistence. Its tests cover semantic-fact lifecycle/conflicts, procedural version activation and planner-session persistence; the test name is not evidence that B1 features are tested.
- `B1MemoryFeatureLearningServiceTest.selectedAccessesAreDurableAndEnrichTheNextB1Candidate` and `B1MemoryFeatureLearningServiceTest.verifiedDownstreamOutcomeUpdatesPersistedUseUtilityAndCueStatistics` are mechanism-level tests using the in-memory repository test double; they are not PostgreSQL integration evidence.

**Code anchors:**

- `B1MemoryFeatureLearningService.java`
- `B1MemoryFeatureState.java`, `B1MemoryFeatureRepository.java`
- `MemoryMaintenanceAccountingService.java`, `MemoryMaintenanceLedger.java`
- `MechanismAblationRunner.java` — maintenance accounting use in the separate evaluation/ablation path
- `PostgresB1MemoryFeatureRepository.java` and migration `V014__b1_memory_feature_learning.sql`
- host construction in `DurableCognitiveApplicationHost.java`.

**Tests:**

- `B1MemoryFeatureLearningServiceTest.selectedAccessesAreDurableAndEnrichTheNextB1Candidate`
- `B1MemoryFeatureLearningServiceTest.verifiedDownstreamOutcomeUpdatesPersistedUseUtilityAndCueStatistics`
- `B1RetrievalSelectorTest.maintenanceLedgerIsIdempotentAndAggregatesActualCost`
- `PostgresM7B1PersistenceIntegrationTest` only in a short “what this test does not prove” note, if needed to prevent a misleading citation.

### 21.6 B3 begins with a separately prepared heterogeneous candidate set

**Teaching question:** why can the next workspace not simply be the B1-selected memory list?

Explain that `CognitiveCycleDecisionServices.prepareWorkspace` calls `domainPort.workspaceAdmissionRequest(context, at)`. The domain/application adapter constructs a typed `WorkspaceAdmissionRequest`; the request is not automatically created by copying every B1-selected candidate.

Describe the candidate data that B3 can evaluate: kind, utility points, reliability, risk, context units, coverage tags, conflicts, mandatory status, evidence references and optional B1 memory attributions. The set can represent different kinds of useful content, not only memory records.

Then describe the optional B1 attribution bridge:

- the domain port supplies both an explicit mapping from workspace candidate IDs to B1 memory references and the selected B1 candidate list associated with the active evidence-set reference;
- the port contract says that this list represents the exact candidates recorded by the persisted B1 evidence set. The runtime validates the mapping keys against the B3 request, checks scope, parses exact kind/record/revision identities and requires each mapped reference to occur in the list returned by the port. It does not independently query a PostgreSQL evidence-set table to reconstruct that list; the domain adapter owns that lookup/contract;
- the runtime then creates attribution records binding the B3 candidate fingerprint to the exact B1 memory revisions and query cues;
- absent mapping means there is no B1 attribution; it must not be inferred from textual similarity, candidate ordering or shared labels.

Clarify that B6's uncertainty directive and the experiment-unit fingerprint are attached/validated at the workspace request boundary. Detailed B6 governance belongs in Chapter 23; explain only the concrete B3 input consequence here.

**Code anchors:**

- `CognitiveCycleDecisionPort.workspaceAdmissionRequest` and `workspaceCandidateMemoryAttributions`
- `CognitiveCycleDecisionServices.prepareWorkspace` and private `attachB1MemoryAttributions`
- `WorkspaceAdmissionRequest.java`, `WorkspaceCandidate.java`, `WorkspaceCandidateKind.java`.

### 21.7 B3 admission: mandatory protection, singleton/coalition competition and bounded capacity

**Teaching question:** what makes workspace admission more than sorting candidates by a score?

Explain the boundary between request construction and the admission algorithm. `WorkspaceAdmissionRequest` and `WorkspaceCandidate` validate their own typed inputs before `admit` runs: positive capacity/count, finite nonnegative coverage values, required-tag/value consistency, candidate scope equality and unique IDs; each candidate also validates its numeric ranges, positive context units, non-self-conflict and scope-bound non-duplicate memory attributions. Then explain the actual `WorkspaceAdmissionService.admit` stages in order:

1. process the already-validated request and establish the remaining count/capacity budget;
2. admit mandatory candidates first, subject to count, conflicts and context capacity;
3. if mandatory content cannot fit or mandatory candidates conflict, return `INSUFFICIENT_MANDATORY_CAPACITY` without creating a partial snapshot;
4. repeatedly form feasible singleton choices and, when possible, complementary coalition proposals;
5. calculate the base score using `utilityPoints × reliability − riskPenaltyPoints × risk`; this is a distinct objective from B1 and uses B3 candidate fields rather than memory activation;
6. add coverage bonus for newly covered required tags and bounded individual outcome adjustment;
7. evaluate alternative coalitions under the configured maximum coalition size and total proposal budget; only complementary coalitions that add at least two fresh coverage tags are proposed;
8. choose among feasible singleton and coalition options under free capacity, candidate-count limits and conflict rules, then repeat the competition in another admission round;
9. if coalition enumeration is truncated, retain trace information but discard the partial coalition choice set and fall back to singleton comparison for that and later rounds;
10. save a bounded `WorkspaceSnapshot` and report whether required coverage and B6-driven distinct-kind requirements were satisfied.

Important distinctions:

- `WorkspaceCoalitionCompetitionPolicy` is a **configuration record**, not the algorithm. The standard policy limits coalition size to 3 and evaluated complete coalition combinations to 512 per workspace admission. The counter increments when enumeration reaches a complete combination, before aggregate-capacity and fresh-coverage checks; branches pruned earlier because an individual candidate cannot fit or conflicts with selected/partial members are not counted. `WorkspaceAdmissionRequest.maximumCandidates` limits the number of entries admitted, not the number of incoming candidates. There is no separate input-candidate cap, and the combination counter is not a strict bound on every recursive branch or total CPU work.
- Mandatory-content protection is not the same as ranking: mandatory items are processed before optional competition.
- `INSUFFICIENT_MANDATORY_CAPACITY` returns no snapshot. `INCOMPLETE_COVERAGE` and `INCOMPLETE_EVIDENCE_DIVERSITY` return a snapshot plus a non-complete admission outcome. The snapshot lifecycle enum is separate: the created snapshot still has `WorkspaceStatus.ADMITTED`. In the current runtime, that snapshot is broadcast when consumers are configured; after all consumers acknowledge it, the runtime reports `WorkspaceDisposition.INCOMPLETE`. Do not collapse the three status types into one label.
- The B6 directive can impose a minimum number of distinct workspace kinds. Only state what this directive concretely changes in B3; defer B6's rationale and full uncertainty/resource lifecycle to Chapter 23.
- Candidate input order is not intended to determine the winner; deterministic tie-breaking and coalition traces are part of the implementation. The repeated bounded greedy rounds are an engineering heuristic, not an exact global optimizer over every possible workspace subset.

**Code anchors:**

- `WorkspaceAdmissionService.java`
- `WorkspaceScoringPolicy.java`
- `WorkspaceCoalitionCompetitionPolicy.java`
- `WorkspaceCoalitionProposal.java`, `WorkspaceCoalition.java`
- `WorkspaceAdmissionOutcome.java`, `WorkspaceAdmissionStatus.java`, `WorkspaceSnapshot.java`.

**Tests:**

- `WorkspaceAdmissionServiceTest.mandatoryContentIsAdmittedBeforeOptionalContent`
- `WorkspaceAdmissionServiceTest.mandatoryContentExceedingCapacityFailsWithoutPartialSnapshot`
- `WorkspaceAdmissionServiceTest.mandatoryContentExceedingMaximumCountFails`
- `WorkspaceAdmissionServiceTest.conflictingCandidatesAreNeverAdmittedTogether`
- `WorkspaceAdmissionServiceTest.complementaryCoverageCanMakeARequiredCandidateWorthAdmitting`
- `WorkspaceAdmissionServiceTest.complementaryCandidatesAreRecordedAsAnExplicitWorkspaceCoalition`
- `WorkspaceAdmissionServiceTest.alternativeCoalitionsCompeteAsFirstClassOptionsAndRecordTheWinner`
- `WorkspaceAdmissionServiceTest.incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation`
- `WorkspaceAdmissionServiceTest.coalitionCompetitionIsDeterministicAcrossCandidateInputOrder`
- `WorkspaceAdmissionServiceTest.coalitionGenerationNeverCombinesConflictingCandidates`
- `WorkspaceAdmissionServiceTest.reportsIncompleteCoverageWhenCapacityCannotCoverAllRequiredTags`
- `WorkspaceAdmissionServiceTest.mandatoryCapacityOverflowIsReportedAsInsufficientWithoutCreatingSnapshot`.

### 21.8 Broadcast, consumer receipts and verified downstream outcomes

**Teaching question:** after B3 admits content, what exactly does “broadcast” establish?

Explain the current `WorkspaceBroadcastService` as a synchronous in-process adapter:

- only an admitted snapshot in the expected scope can be broadcast;
- calls are made directly to configured consumers, not through a durable asynchronous broker/outbox;
- each consumer returns a receipt identifying the workspace and the candidate IDs it consumed; unknown consumer IDs produce rejected receipts, while consumer exceptions or identity/subset violations produce failed receipts;
- the service validates receipt identity and rejects acknowledgements for candidates outside the snapshot;
- receipts are recorded through `WorkspaceReceiptRecorder`; if durable receipt recording fails, the call fails with a stable receipt identity that must be reconciled rather than silently reported as success or by automatically replaying the consumer call.

Clarify the three B3 status layers in the prose: `WorkspaceAdmissionStatus` describes coverage/mandatory/diversity completion; `WorkspaceStatus` describes the snapshot lifecycle (`ADMITTED` or `CLOSED`); and the runtime's `WorkspaceDisposition` describes what the graph should do next (`ADMITTED`, `INCOMPLETE`, `INSUFFICIENT_CAPACITY` or `FAILED`). An incomplete admission result may still have a snapshot that is broadcast; `INCOMPLETE` is returned only after the broadcast succeeds and all configured consumers acknowledge it. If no consumers are configured, the runtime returns `FAILED` and does not attempt a broadcast.

Then distinguish receipt from outcome:

- an accepted receipt indicates consumer acknowledgement/consumption according to that consumer contract;
- it does not establish that the candidate was correct, useful or causally responsible for a later result;
- `B3OutcomeEvidenceService` requires an accepted receipt, an exact consumed candidate, a later verified outcome report, evidence accepted by the configured verifier and the bound candidate/experiment fingerprints;
- persisted outcomes are re-read and revalidated before the service mints verified evidence for training;
- where explicit B1 attributions exist, the verified outcome can update only those exact memory revisions through `B1MemoryFeatureLearningService`;
- coalition-level outcome evidence is keyed to the exact selected coalition receipt, proposal fingerprint, preference key, member IDs and experiment-unit fingerprint. Its feedback is separate from B1 per-memory updates and from the per-candidate `CandidateOutcomeAdjustment`; describe its shadow/holdout/activation governance without claiming that it is automatically active.

Persistence boundary in the current durable host:

- `WorkspaceAdmissionService` is constructed with `InMemoryWorkspaceRepository`; the workspace snapshot is per-cycle and ephemeral in this composition.
- `B3OutcomeEvidenceService` records receipts and verified downstream outcomes through `PostgresB3OutcomeEvidenceRepository`.
- Therefore, do not call the workspace snapshot a durable PostgreSQL workspace. The durable evidence records do not imply that the workspace itself is persisted as an equivalent object.

**Code anchors:**

- `WorkspaceBroadcastService.java`, `WorkspaceConsumer.java`, `WorkspaceConsumerReceipt.java`, `WorkspaceBroadcastReport.java`
- `B3OutcomeEvidenceService.java`, `VerifiedDownstreamOutcomeEvidence.java`
- `PostgresB3OutcomeEvidenceRepository.java`
- `DurableCognitiveApplicationHost.java` — actual wiring of in-memory workspace repository and PostgreSQL receipt/outcome repository.

**Tests:**

- `B3OutcomeEvidenceServiceTest.broadcastPersistsReceiptButDoesNotTreatReceiptAsAUsefulOutcome`
- `B3OutcomeEvidenceServiceTest.verifiedOutcomeMustReferenceAnAcceptedConsumedCandidateAndVerifiedSourceEvidence`
- `B3OutcomeEvidenceServiceTest.outcomeForUnconsumedCandidateOrUnverifiedEvidenceIsRejected`
- `B3OutcomeEvidenceServiceTest.persistedOutcomeIsReverifiedBeforeTrainerCapabilityIsMinted`
- `B3OutcomeEvidenceServiceTest.verifiedDownstreamOutcomeUpdatesOnlyTheExactAttributedB1MemoryRevision`
- `B3OutcomeEvidenceServiceTest.selectedCoalitionOutcomesAreReceiptBoundAndProduceOnlyShadowFeedbackUntilHeldOutApproval`
- `B3OutcomeEvidenceServiceTest.broadcastDoesNotReportSuccessWhenDurableReceiptRecordingFails`
- `WorkspaceAdmissionServiceTest.broadcastReturnsReceiptForEachRegisteredAndUnknownConsumer`
- `WorkspaceAdmissionServiceTest.broadcastRejectsConsumerReceiptForUnadmittedCandidate`
- `WorkspaceAdmissionServiceTest.broadcastCapturesConsumerFailureInsteadOfLosingOtherReceipts`
- `CognitiveCycleDecisionServicesTest.workspaceMustBeAdmittedAndAcknowledgedByEveryConfiguredConsumer`
- `CognitiveCycleDecisionServicesTest.workspaceAdmissionRejectsARequestBoundToAnotherUncertaintyRevision`
- `CognitiveCycleDecisionServicesTest.broadcastFailureCannotBeReportedAsAnAdmittedWorkspace`
- `R2OutcomeEvidencePostgresIntegrationTest.b3ReceiptsAndVerifiedOutcomesSurviveRepositoryReplacementAndRemainAppendOnly` — PostgreSQL evidence for B3 receipt/outcome persistence only.

### 21.9 The as-built B1/B3 handoff: connected responsibilities, not one pipeline of automatic conversions

Use a single sequence diagram with an explicit domain-adapter boundary:

`M2 MemoryRetrievalService` → `B1MemoryCandidateFactory` + trusted feature inputs → optional B1 feature enrichment → `B1RetrievalSelector` → evidence-set persistence → selected long-term reference projection into working memory → **domain/application constructs a separate B3 `WorkspaceAdmissionRequest`** → optional exact B1 memory attribution → B3 mandatory protection and singleton/coalition admission → ephemeral `WorkspaceSnapshot` → synchronous consumers → receipt recorder/PostgreSQL evidence → separately verified downstream outcome → optional exact-revision B1 feature update and/or separately governed coalition feedback.

The figure and prose must mark the B1-to-B3 candidate bridge as an explicit, validated mapping, not an automatic conversion. It must also distinguish B3's workspace candidate score adjustment, coalition adjustment, and B1 per-memory feature learning.

Add a compact responsibility table. Before the table, explicitly separate three feedback pathways: (1) per-memory B1 feature learning keyed by exact memory revision; (2) the bounded generic per-candidate adjustment injected into B1/B3 scoring when its policy is activated; and (3) B3 coalition-level feedback keyed by an exact coalition receipt. These are not interchangeable signals or storage records. Then show:

| Question | B1 | B3 |
|---|---|---|
| Candidate domain | Retrieved memory candidates | Separately prepared heterogeneous workspace candidates |
| Decision | Which memories should be selected for the current cycle? | Which content should enter the bounded workspace and be broadcast? |
| Main constraints | Accessibility, expected value, separate latency costs, maintenance estimate, context budget, diversity directive | Mandatory protection, capacity, count, conflict, coverage, coalition bounds, diversity directive |
| Output | Selected memory candidates and scores/evidence set | Admitted workspace snapshot and competition trace |
| Feedback | Selection/access history and verified downstream outcomes for exact memory revisions | Consumer receipts, verified item outcomes and separate coalition outcomes |
| Authority boundary | Does not authorize action | Broadcast does not authorize action |

### 21.10 Seven-field implementation reading, recap and exercises

Give separate B1 and B3 summaries, preferably in one compact S/C/T/P/F/L/R comparison table with a short evidence/status column. Do not force symmetry where the code does not support it; mark partial, injected, externally owned or untested items rather than filling them by inference:

- **B1:** explicit memory-candidate state, selector-controlled scoring and bounded admission, runtime retrieval trigger, selected references projected into working memory, feature state stored through an injected repository (PostgreSQL in the durable host), scoped failure behavior, verified learning loop; maintenance profile cost participates in selection, while event accounting is a separate ablation path.
- **B3:** typed workspace candidates and snapshots, `WorkspaceAdmissionService` controls admission, runtime workspace trigger after persisted evidence set, bounded in-memory snapshot in current host, receipt/outcome persistence through PostgreSQL, explicit incomplete/failure outcomes, verified item and coalition feedback paths.

State unknown or absent items explicitly. Do not infer calibration from a score range, durability from the existence of a repository interface, or a learning effect from an update method.

Review questions/exercises should ask readers to:

1. Trace one episodic memory from M2 retrieval to B1 score and selection.
2. Explain why a memory with strong activation can still be rejected by the B1 policy.
3. Identify the point at which a selected long-term record becomes a working-memory reference, and explain why the record itself is not copied.
4. Explain why B3's workspace candidate set is not mechanically identical to B1's selected memory set.
5. Construct a [Book example] where a singleton is less valuable than a complementary coalition, then identify the search bounds, capacity, candidate-count and conflict conditions that could prevent the coalition from being considered.
6. Distinguish `INCOMPLETE_COVERAGE`, `INCOMPLETE_EVIDENCE_DIVERSITY` and `INSUFFICIENT_MANDATORY_CAPACITY`.
7. Explain why an accepted consumer receipt is not a positive learning signal.
8. Identify which PostgreSQL test demonstrates B3 receipt/outcome persistence and which B1 PostgreSQL test is still missing.

## 5. Recommended figures

All figures should have accessible `accTitle` and `accDescr` metadata **after** the Mermaid diagram declaration, following the existing repository convention.

1. **`b1-runtime-evidence-path.mmd`** — M2 retrieval → feature-provider port → B1 candidate factory/enrichment → selector → evidence persistence → working-memory reference projection. Mark runtime composition and optional enrichment.
2. **`b1-score-decomposition.mmd`** — separate activation/accessibility, predicted cognitive latency, measured infrastructure latency, downstream utility, maintenance estimate and bounded outcome adjustment; show context/diversity selection after scoring.
3. **`b1-memory-reference-projection.mmd`** — selected long-term record references projected into working memory; source records remain authoritative in their own stores; working-memory candidates are not reprojected.
4. **`b3-workspace-admission.mmd`** — validated typed candidates → mandatory-content gate → singleton/coalition competition → bounded snapshot; distinguish admission completeness from snapshot lifecycle status and show the bounded-search fallback.
5. **`b3-broadcast-outcome-evidence.mmd`** — synchronous consumer calls → accepted/rejected/failed receipts → durable receipt record → separately verified outcome → exact attributed B1 update / separate coalition feedback; show that an incomplete admission snapshot may still be broadcast.
6. **`b1-b3-responsibility-boundary.mmd`** — compare B1 and B3 candidate domains, decisions and outputs; visibly show that action authorization is outside both mechanisms.
7. **Optional combined sequence figure only if it remains readable at print size:** an end-to-end B1-to-B3 handoff emphasizing the domain adapter's explicit mapping. Do not create a second figure that duplicates Figures 1 and 6.

The final chapter should normally use five or six figures, not all seven automatically. Prefer clarity at print size over coverage by diagram count.

## 6. Code presentation plan

Use short, selected Java excerpts. Each excerpt must answer one teaching question and be introduced before the code appears.

| Teaching moment | Source to show | Why it deserves a listing |
|---|---|---|
| Runtime composition | `CognitiveCycleDecisionServices.retrieveEvidence` (selected lines only) | Shows actual call order and the B1 integration point without reproducing the full service. |
| Candidate contract | `B1MemoryCandidate` and `B1CandidateFeatures` (small record excerpts) | Makes the candidate domain and trusted feature boundary concrete. |
| B1 score | Core `B1RetrievalSelector.select` expression plus the latency/activation interfaces | Lets beginners read the implemented formula directly. |
| Reference projection | `projectSelectedMemoryReferences` (shortened to validation, selection and CAS portions) | Shows why references—not memory documents—enter working memory. |
| B1 feedback | `B1MemoryFeatureLearningService.applyVerifiedOutcome` (selected validation/update lines) | Shows exact revision attribution and idempotency. |
| B3 admission | `WorkspaceAdmissionService.admit` excerpts for mandatory candidates and singleton/coalition competition | Shows the actual admission algorithm; do not present the policy record as the algorithm. |
| B3 outcome evidence | `WorkspaceBroadcastService.broadcast` and `B3OutcomeEvidenceService.record/verifiedOutcomes` (short excerpts) | Separates consumer receipt from verified outcome and trainer capability. |
| Host persistence boundary | small constructor excerpt from `DurableCognitiveApplicationHost` | Proves the current split between in-memory workspace snapshots and PostgreSQL B1/B3 evidence repositories. |

Avoid package-wide listings, long constructors, generated migrations, or copying full tests into the prose. Use test names and a few focused assertion excerpts instead.

## 7. Test-to-claim map and evidence limits

The prose must use tests as evidence for specific contracts, not as a substitute for the source implementation or as experimental proof.

| Claim in the chapter | Best test evidence | What it does **not** establish |
|---|---|---|
| B1 factory adapts the four CoALA memory kinds and rejects invalid scope/expiry/unverified input | `B1MemoryCandidateFactoryTest` focused tests | Does not prove general retrieval relevance. |
| B1 selector uses the declared score inputs and bounded context policy | `B1RetrievalSelectorTest` | Does not establish calibration or comparative effectiveness. |
| B1 feature state enriches the next selection and accepts verified downstream evidence | `B1MemoryFeatureLearningServiceTest` | These are service/repository tests, not proof of PostgreSQL round-trip for the B1 feature repository. |
| Runtime calls M2 before B1 and projects selected references into working memory | `CognitiveCycleDecisionServicesTest` retrieval/projection tests | Does not prove every host/domain adapter produces a suitable B3 candidate mapping. |
| B3 mandatory, conflict, coverage and coalition behavior | `WorkspaceAdmissionServiceTest` | Does not demonstrate empirical superiority of coalitions. |
| B3 receipts and verified outcomes are separate; exact B1 attribution is updated | `B3OutcomeEvidenceServiceTest` | Unit/service tests do not establish end-to-end causal benefit. |
| Runtime refuses an unacknowledged or stale-bound workspace | `CognitiveCycleDecisionServicesTest.workspaceMustBeAdmittedAndAcknowledgedByEveryConfiguredConsumer`, `CognitiveCycleDecisionServicesTest.workspaceAdmissionRejectsARequestBoundToAnotherUncertaintyRevision`, and `CognitiveCycleDecisionServicesTest.broadcastFailureCannotBeReportedAsAnAdmittedWorkspace` | Does not prove asynchronous delivery, retries, or a durable message broker. |
| B3 receipts and outcomes persist append-only across repository replacement | `R2OutcomeEvidencePostgresIntegrationTest.b3ReceiptsAndVerifiedOutcomesSurviveRepositoryReplacementAndRemainAppendOnly` | Does not prove B1 feature-state PostgreSQL persistence. |
| Full graph executes B3 broadcast/outcome evidence path with the configured in-memory repository | `M8B4FullGraphWorkflowTest.fullGraphB3BroadcastPersistsReceiptAndSupportsVerifiedOutcomeLearningEvidence` | The test composition uses an in-memory B3 evidence repository; do not describe it as PostgreSQL persistence. |
| A paired/holdout feedback overlay is consumed by both scoring paths in a compiled full-graph test | `M8B4FullGraphWorkflowTest.authorizedFeedbackOverlayIsConsumedByB1AndB3DuringTheCompiledFullGraphRun` | This is a synthetic in-memory test composition; it is not empirical proof that adaptive policies improve performance or a PostgreSQL B1 feature-state round-trip. |
| A durable-host end-to-end test exercises a PostgreSQL-backed cycle that includes B1 retrieval, B3 workspace preparation/broadcast and cross-cycle working memory | `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory` | This test does not assert a persisted B1 feature update; the domain test adapter also supplies its selected-candidate mapping in memory. |

**Explicit test gap:** the current source snapshot has a `PostgresB1MemoryFeatureRepository` and migration `V014__b1_memory_feature_learning.sql`, and the durable host wires the adapter, but no focused PostgreSQL integration test was found that round-trips B1 memory feature state or a verified B1 update. `PostgresM7B1PersistenceIntegrationTest` is not that test: it covers semantic facts, procedural versioning and planner-session persistence. The chapter must say this plainly if it discusses the adapter.

## 8. Boundaries and claims the chapter must preserve

- B1 is not a synonym for vector search or base memory retrieval.
- The B1 engineering score is not ACT-R's exact activation law, not a validated calibration model, and not a universal B1 formula.
- B1 candidate features include trusted injected values; do not imply every feature is computed from the memory object by the selector.
- B1 selected-memory projection is an explicit runtime step. It stores stable references in working memory; it does not duplicate the long-term record.
- Working-memory retrieval does not share the same historical-time semantics as the long-term stores; do not call the whole service a uniform bitemporal memory engine.
- B1 maintenance-profile scoring and actual maintenance-event accounting are distinct. The latter is not wired into the durable application host.
- B3 gets a separately prepared heterogeneous candidate set. B1 attribution is an explicit exact-reference mapping, not automatic conversion.
- `WorkspaceCoalitionCompetitionPolicy` supplies bounds; `WorkspaceAdmissionService` implements the competition/admission algorithm.
- B3's workspace snapshot is in-memory/ephemeral in the current durable host; receipts/outcomes are separately persisted in PostgreSQL.
- Synchronous broadcast is not a durable asynchronous message broker or outbox.
- An accepted receipt is not a positive downstream outcome. Only a separately verified outcome can support the described learning path.
- B3 coalition-level feedback is distinct from B1 per-memory feature updates and from generic per-candidate outcome adjustment.
- Neither B1 nor B3 authorizes external actions. Broadcast does not grant capability or approval.
- No claims of empirical improvement, causal benefit, production deployment or comprehensive B1 PostgreSQL validation are made here.
- Part III's implementation choices are engineering decisions created for this application, not mechanisms mandated by either paper.

## 9. Source and bibliography anchors to preserve during drafting

Use only the established formal source labels `[CoALA]` and `[Fan & Lan]` and the shared `\CoALACite{...}` / `\FanLanCite{...}` macros in the final LaTeX chapter.

- **[CoALA]** Chapters 3–4 and Chapter 8 are recalled only for the memory/action/decision-cycle vocabulary already taught in Part I. Chapter 20 owns the as-built CoALA memory/action implementation overview.
- **[Fan & Lan]** Chapter 12 / B1: cite the paper sections and appendices used in Part II Chapter 12 for activation, retrieval latency, memory value/maintenance and the B1 mechanism hypothesis (including the B1 mapping in §VI-C and the corresponding appendix/experiment template cited there).
- **[Fan & Lan]** Chapter 14 / B3: cite the paper sections and appendices used in Part II Chapter 14 for content competition, workspace/broadcast and admission learning (including the B3 mapping and evaluation template cited there).
- **[Fan & Lan]** Chapter 18: cite its B1/B3 distinction and cross-bundle composition/dependency discussion when explaining why the candidate domains and control authorities remain separate.

During drafting, verify the exact footnote section/table/appendix anchors against the source citation notes in Chapters 12, 14 and 18. Do not invent page numbers or imply that the Java source implements the full paper mechanism.

## 10. Approval and drafting record

The author explicitly approved this source-verified outline on 25 November 2026 and authorized prose drafting. Chapter 21 has now been drafted in `Tex/part3/chapter21/chapter.tex`; six chapter-specific Mermaid sources are stored under `Tex/diagrams/source/part3/chapter21/`. The draft was checked against the supplied Java source snapshot and named tests. The standalone LaTeX build and page-level visual inspection are recorded in `review/Chapter_21_Drafting_Review_v1.md`. The combined book build and the pinned Mermaid CLI render remain repository/CI validation steps; no local result is represented as a successful run of those unavailable build stages.
