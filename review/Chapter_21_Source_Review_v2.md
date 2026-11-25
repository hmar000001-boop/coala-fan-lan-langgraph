# Chapter 21 source review — v2 (accepted frozen baseline)

**Date:** 25 November 2026  
**Status:** Final source alignment after the accepted B1 utility-scale fix and author-confirmed green CI.  
**Chapter:** `Tex/part3/chapter21/chapter.tex`  
**Approved outline:** `Tex/part3/chapter21/outline/Chapter_21_Outline.md`  
**Application base:** `supply-chain-agent-main (9).zip`, SHA-256 `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`.  
**Accepted patch:** two modified B1 files; file hashes appear in `B1_LEARNED_UTILITY_SCALE_FIX_CI_INVENTORY_FIX_CHANGESET_ONLY.zip`'s source manifest. The author confirmed GitHub Actions CI green. Accepted change-only ZIP SHA-256: `ceff62bd7b459bf6b8472f1b02ad77be593f836dd444a3dc5adb533bd313f93d`. The application is frozen after this patch.

## Source and claim review

| Chapter claim | Frozen source checked | Final qualification |
|---|---|---|
| M2 retrieval precedes B1 adaptation and scoring | `CognitiveCycleDecisionServices.retrieveEvidence`; `MemoryRetrievalService`; `B1MemoryCandidateFactory` | The runtime composes base retrieval, candidate adaptation, feature enrichment, B1 selection, evidence-set persistence and selected-reference projection. B1 does not replace M2. |
| B1 task-scale utility comes from the candidate feature provider | `B1CandidateFeatureProvider`; `B1CandidateFeatures`; `B1MemoryCandidateFactory`; accepted `B1MemoryFeatureLearningService.enrich` | The accepted patch preserves `candidate.expectedDownstreamUtility` when enriching histories and cues. Values above 1.0 are valid for the candidate feature. |
| Persisted outcome statistic is separate from candidate utility | `B1MemoryFeatureState`; accepted `B1MemoryFeatureLearningService` | The persisted component still has the legacy name `expectedDownstreamUtility` and is constrained to [0,1]. First verified outcome maps USEFUL/HARMFUL/NEUTRAL to 1.0/0.0/0.5; subsequent outcomes use `0.8 × old + 0.2 × reward`. The accepted `enrich` method does not copy it into the candidate utility field. No scale calibration is defined. |
| B1 accessibility enrichment still uses access/verified-use histories and cue strengths | accepted `B1MemoryFeatureLearningService.enrich`; `B1MemoryFeatureState` | Histories are merged, deduplicated, sorted and bounded; persisted cue strengths overlay candidate cue strengths. The accepted change is limited to preserving provider utility. |
| B1 cognitive and infrastructure latency are distinct | `B1RetrievalSelector`; `RecencyFrequencyActivationEstimator`; `ExponentialActivationLatencyModel`; `B1ScoringPolicy` | The score is an engineering objective. The bounded accessibility transform is not calibrated merely because it is bounded; the cognitive-latency mapping is not a measured human retrieval law. |
| Maintenance estimate follows the original profile | `MaintenanceProfile`; `B1RetrievalSelector`; `B1RetrievalSelectorTest` | The five-field profile adds admission-validation cost every estimate, refresh cost when due, and recurring cost over the requested horizon. The source does not clarify whether admission-validation cost is repeated selection-time work or historical one-time admission cost. Do not claim a marginal/amortized redesign. |
| Actual maintenance-event accounting is separate | `MemoryMaintenanceAccountingService`; `InMemoryMemoryMaintenanceLedger`; `MechanismAblationRunner` | The ledger is in-memory and used in the evaluation/ablation path. The accounting service is not wired into the durable host as automatic maintenance-event measurement. |
| B3 workspace candidates are independently prepared | `CognitiveCycleDecisionPort.workspaceAdmissionRequest`; `CognitiveCycleDecisionServices.prepareWorkspace`; `WorkspaceAdmissionRequest`; `WorkspaceCandidate` | The domain/application adapter prepares a typed request. Optional B1 attribution is exact, explicit, validated and not an automatic copy of B1 selection. |
| B3 protects mandatory candidates | `WorkspaceAdmissionService`; `WorkspaceAdmissionStatus`; `WorkspaceAdmissionServiceTest` | Mandatory content is processed before optional competition and checked against candidate count, conflicts and capacity. Failure to admit mandatory content returns no partial snapshot. |
| B3 coalition budget counts complete combinations, not all recursion | `WorkspaceAdmissionService.evaluateCoalitions`; `WorkspaceAdmissionService.enumerate`; `WorkspaceCoalitionCompetitionPolicy` | Standard policy: max coalition size 3, max evaluated complete combinations 512 per admission. Counter increments at a complete combination before aggregate capacity/fresh-coverage rejection. Earlier pruned partial branches are not counted. There is no separate incoming-candidate cap; `WorkspaceAdmissionRequest.maximumCandidates` is the admission output limit. |
| B3 truncation falls back to singleton comparison | `WorkspaceAdmissionService`; `WorkspaceAdmissionServiceTest.incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation` | The partial coalition set is discarded as incomplete; feasible singleton options remain. The limit is not a strict bound on all recursive operations or CPU work. |
| Incomplete admission can still carry a snapshot | `WorkspaceAdmissionService`; `WorkspaceAdmissionOutcome`; `WorkspaceSnapshot`; runtime workspace operation | Admission status, snapshot lifecycle status and graph disposition are separate. Incomplete coverage/diversity can accompany a snapshot. |
| A consumer receipt is not proof of usefulness | `WorkspaceBroadcastService`; `WorkspaceReceiptEvidence`; `B3OutcomeEvidenceService` | A receipt is an accepted consumer acknowledgement/consumption record. Downstream usefulness requires separately verified evidence tied to the exact receipt/candidate. |
| Durable host persistence is split | `DurableCognitiveApplicationHost`; `InMemoryWorkspaceRepository`; `PostgresB3OutcomeEvidenceRepository`; `PostgresB1MemoryFeatureRepository` | Workspace snapshots are in memory; receipts/outcomes and B1 feature state have PostgreSQL adapters. No focused B1 feature-state PostgreSQL round-trip test was found. |

## Exact test anchors

Current Chapter 21 outline references were checked against the accepted application source. Representative anchors include:

- `B1MemoryCandidateFactoryTest.adaptsWorkingEpisodicSemanticAndProceduralMemoryWithoutChangingM2Records`
- `B1MemoryCandidateFactoryTest.refusesWorkingMemoryFromDifferentScope`
- `B1MemoryCandidateFactoryTest.expiredWorkingMemoryCannotEnterActivationSelection`
- `B1MemoryCandidateFactoryTest.historicalUnverifiedEpisodeIsNotAdmittedToB1Candidates`
- `B1RetrievalSelectorTest.selectorRanksByExpectedDownstreamValueAndFitsContextBudget`
- `B1RetrievalSelectorTest.measuredInfrastructureLatencyIsSeparateFromCognitiveLatency`
- `B1RetrievalSelectorTest.maintenanceProfileChargesRefreshWhenDueAndRecurringHorizonCost`
- `B1MemoryFeatureLearningServiceTest.selectedAccessesAreDurableAndEnrichTheNextB1Candidate`
- `B1MemoryFeatureLearningServiceTest.verifiedDownstreamOutcomeUpdatesPersistedUseUtilityAndCueStatistics`
- `CognitiveCycleDecisionServicesTest.retrievalUsesM2BeforeB1AndPersistsTheSelectedEvidenceSet`
- `CognitiveCycleDecisionServicesTest.selectedLongTermMemoryProjectionIsIdempotentAfterGraphCheckpointInterruption`
- `WorkspaceAdmissionServiceTest.mandatoryContentExceedingCapacityFailsWithoutPartialSnapshot`
- `WorkspaceAdmissionServiceTest.alternativeCoalitionsCompeteAsFirstClassOptionsAndRecordTheWinner`
- `WorkspaceAdmissionServiceTest.incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation`
- `WorkspaceAdmissionServiceTest.coalitionCompetitionIsDeterministicAcrossCandidateInputOrder`
- `B3OutcomeEvidenceServiceTest.verifiedDownstreamOutcomeUpdatesOnlyTheExactAttributedB1MemoryRevision`
- `B3OutcomeEvidenceServiceTest.selectedCoalitionOutcomesAreReceiptBoundAndProduceOnlyShadowFeedbackUntilHeldOutApproval`
- `R2OutcomeEvidencePostgresIntegrationTest.b3ReceiptsAndVerifiedOutcomesSurviveRepositoryReplacementAndRemainAppendOnly`
- `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory`

All 49 unique test references in the approved outline resolve to exact methods in the accepted source tree. These are focused, service, graph and integration tests; they are not one test proving the entire workflow atomically.

## Persistence and evidence limits

- The durable host constructs `PostgresB1MemoryFeatureRepository`, but no focused test round-trips B1 feature-state updates in PostgreSQL. The similarly named `PostgresM7B1PersistenceIntegrationTest` does not establish that coverage.
- The durable host uses `InMemoryWorkspaceRepository`; B3 receipts and verified outcome evidence are PostgreSQL-backed separately. This does not make workspace snapshots durable.
- The deterministic M8-B3 ablation predates the accepted B1 utility-scale correction. Its B1 figures are not measurements of the accepted enrichment behavior. Maintenance and B3 implementations were not changed by the accepted patch, but fixture results do not resolve the maintenance field's semantic ambiguity or establish a hard bound on all B3 recursive operations.
- No B1 calibrated outcome-to-task-utility model or adaptive selector-weight update is claimed.

## Cross-chapter disposition

Chapter 20 remains unchanged: it correctly stops at the M2 cross-store retrieval boundary and defers B1 selection/B3 admission. Part II Chapters 12, 14 and 18 remain theory/design analysis rather than as-built implementation chapters. Chapters 19 and 22–24 required no source-fidelity edits for the accepted B1 patch. Chapter 21 alone was updated.

## Validation boundary

This is a book-only reconciliation. No Java source, Java test, Maven file, migration, application configuration, application documentation, or CI workflow is modified by the book patch. The author confirmed green GitHub Actions CI for the accepted B1 application change. Local LaTeX proof and pinned Mermaid/canonical book-build validation are reported separately in the Chapter 21 PDF integrity record.
