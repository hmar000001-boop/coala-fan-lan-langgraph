> **Superseded:** this v1 source review predates the accepted B1 utility-scale correction and includes outdated test/API references. Use `Chapter_21_Source_Review_v2.md` for the frozen source and current exact test names.

# Chapter 21 source review — v1

**Date:** 25 November 2026  
**Status:** Source verification completed for the Chapter 21 draft  
**Book source:** `Tex/part3/chapter21/chapter.tex`  
**Approved outline:** `Tex/part3/chapter21/outline/Chapter_21_Outline.md`  
**Application source:** supplied `supply-chain-agent-main (9).zip`  
**Application ZIP SHA-256:** `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`

## Source and claim review

The application code references and named test methods in this chapter were checked against the supplied source snapshot. The chapter does not modify Java source, tests, Maven configuration, migrations, application configuration, or CI workflows in the application repository.

| Chapter claim | Source checked | Qualification retained |
|---|---|---|
| M2 retrieval precedes B1 candidate adaptation and scoring | `supply-chain-agent-runtime/.../decision/CognitiveCycleDecisionServices.java`, `retrieveEvidence`; `B1MemoryCandidateFactory.java` | Scope consistency is checked before retrieval. The runtime requests candidates from M2 and then converts them into B1 candidates. B1 does not replace cross-store retrieval. |
| B1 candidate features are supplied through an injected boundary | `B1CandidateFeatureProvider.java`; `B1CandidateFeatures.java`; `B1MemoryCandidateFactory.java` | Access history, cues, expected downstream utility, context units, measured infrastructure latency, and maintenance profile are not all derived by the selector. They are supplied by the configured provider. |
| B1 uses separate cognitive and infrastructure latency terms | `B1RetrievalSelector.java`; `RecencyFrequencyActivationEstimator.java`; `ExponentialActivationLatencyModel.java`; `B1ScoringPolicy.java` | The score is an application engineering objective. The bounded accessibility transform is not a calibrated probability and the latency model is not a measured human retrieval law. |
| B1 is a deterministic bounded greedy selector | `B1RetrievalSelector.java`; `B1SelectionRequest.java`; `B1SelectionResult.java` | Net-utility order uses candidate ID as tie-breaker. Candidate count, accessibility, net utility, context units, and an optional B6 memory-kind diversity floor constrain selection. It does not guarantee a global optimum. |
| B1 selected long-term memories are projected as references | `CognitiveCycleDecisionServices.java`, `projectSelectedMemoryReferences`; `WorkingMemoryService.java` | Working-memory candidates are not reprojected. Episodic, semantic, and procedural source records remain authoritative in their own stores. A stale scope, expiry, or version conflict fails closed; only a narrowly identified checkpoint replay is recognized. |
| B1 access and verified-use feedback are separate | `B1MemoryFeatureLearningService.java`; `B1MemoryFeatureState.java` | Selection access is idempotent by execution/evidence-set/candidate identity. Verified outcome updates require separately verified evidence and exact memory attribution; selection is not counted as successful use. |
| B1 outcome updates are tied to one memory revision | `B3OutcomeEvidenceService.java`; `B1MemoryFeatureLearningService.java`; `B1MemoryFeatureState.java` | The outcome service checks accepted receipt, consumed candidate, temporal order and verifier result. The attribution identifies the exact memory revision; no fuzzy or name-based attribution is inferred. |
| Estimated maintenance cost is distinct from actual-event accounting | `MaintenanceProfile.java`; `MemoryMaintenanceAccountingService.java`; `InMemoryMemoryMaintenanceLedger.java`; `MechanismAblationRunner.java` | The in-memory ledger supports an ablation/accounting path. The maintenance accounting service is not wired into the durable host, so the book does not claim automatic host-wide observed-cost feedback. |
| B3 candidates are separately prepared from B1 candidates | `CognitiveCycleDecisionPort.java`; `CognitiveCycleDecisionServices.java`; `WorkspaceAdmissionRequest.java`; `WorkspaceCandidate.java` | The domain/application adapter creates a typed B3 request. Optional B1 attribution is an explicit exact-reference mapping validated against selected references; it is not an automatic copy of the B1 result. |
| B3 protects mandatory content before optional competition | `WorkspaceAdmissionService.java`; `WorkspaceAdmissionStatus.java`; `WorkspaceAdmissionServiceTest.java` | Mandatory candidates are ordered and checked for count, conflicts and capacity. If mandatory admission cannot fit, the service returns insufficient mandatory capacity without a partial snapshot. |
| B3 compares singleton and complementary coalition options under a bound | `WorkspaceAdmissionService.java`; `WorkspaceCoalitionCompetitionPolicy.java`; `WorkspaceCoalitionSearch.java` | The implementation repeatedly chooses bounded options. If coalition enumeration is truncated, the partial coalition list is not compared as complete; the service falls back to singleton comparison. This is not a global optimum guarantee. |
| B3 incomplete admission can still produce a snapshot | `WorkspaceAdmissionService.java`; `WorkspaceAdmissionOutcome.java`; `WorkspaceSnapshot.java`; runtime workspace operation | Admission status, snapshot lifecycle status and graph-facing disposition are different status layers. Incomplete coverage/diversity can accompany an admitted snapshot. |
| Broadcast acknowledgements are not useful outcomes | `WorkspaceBroadcastService.java`; `WorkspaceReceiptEvidence.java`; `B3OutcomeEvidenceService.java` | Broadcast is synchronous in-process. A receipt is a consumer acknowledgement and candidate-consumption record, not a positive outcome. Receipt-store failure is reported rather than represented as successful durable acknowledgement. |
| Downstream outcomes are revalidated before training use | `B3OutcomeEvidenceService.java`; `VerifiedDownstreamOutcomeEvidence.java` | Evidence is checked against a persisted accepted receipt and consumed candidate, and revalidated when training capability is requested. Candidate-level B1 feedback and coalition feedback remain distinct. |
| Current durable host has separate workspace and evidence persistence | `DurableCognitiveApplicationHost.java`; `InMemoryWorkspaceRepository.java`; `PostgresB3OutcomeEvidenceRepository.java`; `PostgresB1MemoryFeatureRepository.java` | The host uses an in-memory workspace repository and PostgreSQL receipt/outcome plus B1 feature repositories. The chapter does not claim the workspace snapshot is durably reloaded. |

## Test anchors checked

The chapter uses only exact test methods found in the inspected source snapshot. Representative anchors include:

- `B1MemoryCandidateFactoryTest.adaptsWorkingEpisodicSemanticAndProceduralMemoryWithoutChangingM2Records`
- `B1MemoryCandidateFactoryTest.refusesWorkingMemoryFromDifferentScope`
- `B1MemoryCandidateFactoryTest.expiredWorkingMemoryCannotEnterActivationSelection`
- `B1MemoryCandidateFactoryTest.historicalUnverifiedEpisodeIsNotAdmittedToB1Candidates`
- `B1RetrievalSelectorTest.selectorRanksByExpectedDownstreamValueAndFitsContextBudget`
- `B1RetrievalSelectorTest.measuredInfrastructureLatencyIsSeparateFromCognitiveLatency`
- `B1MemoryFeatureLearningServiceTest.selectedAccessesAreDurableAndEnrichTheNextB1Candidate`
- `B1MemoryFeatureLearningServiceTest.verifiedDownstreamUseChangesNextActivationHistoryAndUtilityFeatures`
- `CognitiveCycleDecisionServicesTest.retrievalUsesM2BeforeB1AndPersistsTheSelectedEvidenceSet`
- `CognitiveCycleDecisionServicesTest.selectedLongTermMemoryProjectionIsIdempotentAfterGraphCheckpointInterruption`
- `WorkspaceAdmissionServiceTest.mandatoryContentExceedingCapacityFailsWithoutPartialSnapshot`
- `WorkspaceAdmissionServiceTest.alternativeCoalitionsCompeteAsFirstClassOptionsAndRecordTheWinner`
- `WorkspaceAdmissionServiceTest.incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation`
- `B3OutcomeEvidenceServiceTest.verifiedDownstreamOutcomeUpdatesOnlyTheExactAttributedB1MemoryRevision`
- `B3OutcomeEvidenceServiceTest.selectedCoalitionOutcomesAreReceiptBoundAndProduceOnlyShadowFeedbackUntilHeldOutApproval`
- `R2OutcomeEvidencePostgresIntegrationTest.b3ReceiptsAndVerifiedOutcomesSurviveRepositoryReplacementAndRemainAppendOnly`
- `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory`

These are separate focused and integration tests, not one test that proves every sequence as a single atomic run.

## Persistence and test-gap disclosures

- The durable host constructs `PostgresB1MemoryFeatureRepository`, but the supplied snapshot contains no focused PostgreSQL integration test that round-trips B1 feature-state updates. `PostgresM7B1PersistenceIntegrationTest` does not establish that behavior; it covers semantic memory, procedural versioning and planner-session persistence.
- The B3 workspace snapshot uses `InMemoryWorkspaceRepository`; it is cycle-scoped/ephemeral in the inspected host composition.
- B3 receipts and verified outcome records are persisted in PostgreSQL. The focused `R2OutcomeEvidencePostgresIntegrationTest` supports this evidence-store claim, not durable workspace snapshot storage.
- The full-graph B3 workflow test uses an in-memory evidence repository in its test composition and is not used as proof of PostgreSQL durability.

## Theory and implementation boundary

The CoALA references are limited to concepts already introduced in Part I and the CoALA implementation map in Chapter 20. Fan and Lan's B1/B3 residual analysis supplies the mechanism distinction and source framing. The exact Java class structure, scoring equation, feature-provider port, data contracts, coalition search bound, persistence selection, and test architecture are engineering choices in the supplied application; they are not prescribed by CoALA or by Fan and Lan.

## Validation boundary

This is a book-only change. The source review inspected Java source and tests but did not rerun the application's Maven build or CI workflow. No empirical effectiveness claim is made. The canonical Mermaid rendering remains the pinned repository/CI responsibility; any temporary local diagram previews used for PDF layout verification are not represented as Mermaid CLI output.
