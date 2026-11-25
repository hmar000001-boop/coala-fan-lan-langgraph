# Chapter 20 source review — v1

**Date:** 25 November 2026  
**Status:** Completed for author review  
**Book source:** `Tex/part3/chapter20/chapter.tex`  
**Approved outline:** `Tex/part3/chapter20/outline/Chapter_20_Outline.md`  
**Implementation source:** supplied `supply-chain-agent-main` repository snapshot

## Scope and source discipline

Chapter 20 maps the CoALA material already taught in Part I to the actual memory, action, and planning contracts in the Java application. Its theoretical citations are limited to CoALA Section 4 and the related figures. Fan and Lan are mentioned only to preserve the later chapter boundary (B1/B3 in Chapter 21 and the B5/GraSP non-implementation boundary); their mechanism analysis is not used to reinterpret CoALA.

The application, service, record, provider, and test names below were checked against the supplied Java source snapshot. No Java source or tests were modified for this book chapter.

## Code claims checked

| Chapter claim | Source checked | Qualification retained |
|---|---|---|
| Working memory is immutable, scoped, versioned, expiring, and evidence-linked | `supply-chain-agent-memory/.../working/WorkingMemorySnapshot.java`; `WorkingMemoryService.java`; `Hypothesis.java` | Compare-and-set rejects stale updates; evidence set is recomputed from current slots and hypotheses. |
| Episodic records begin unverified and require separate review | `.../episodic/Episode.java`; `EpisodicMemoryService.java` | Model-derived episodes require supporting evidence; only verified episodes are returned as trusted experience. |
| Semantic facts have provenance and temporal lifecycle | `.../semantic/SemanticFact.java`; `SemanticMemoryService.java`; `SemanticAdmissionPolicy.java` | Model-derived provenance is not activated without review; replacement/revision preserves temporal history. |
| Procedural memory uses a governed version lifecycle | `.../procedural/ProcedureVersion.java`; `ProceduralMemoryService.java` | DRAFT/VALIDATED/ACTIVE/RETIRED/REJECTED records and artifact references are not a GraSP typed skill DAG. |
| Cross-store retrieval is deterministic and separate from B1/B3 | `.../retrieval/MemoryRetrievalQuery.java`; `MemoryRetrievalResult.java`; `MemoryRetrievalService.java` | It uses scope/entity/predicate/time/limit filters; no activation/utility scoring, no B3 workspace, and no automatic working-memory write-back. |
| Internal actions separate retrieval, reasoning, and writes | `supply-chain-agent-actions/.../internal/MemoryRetrievalAction.java`; `ReasoningAction.java`; `WorkingMemoryUpdateAction.java`; `EpisodeLearningAction.java`; `LearningActionCatalog.java` | Reasoning result cites only request-supplied evidence; episode recording cannot self-verify. |
| Reasoning output is bounded and structured | `.../internal/ReasoningRequest.java`; `ReasoningAssessment.java` | Context and evidence counts/lengths are bounded; assessment is not a private chain-of-thought transcript. |
| Reasoning and sequential planning use different provider ports | `supply-chain-agent-runtime/.../LangChain4jReasoningProvider.java`; `supply-chain-agent-planning/.../cot/SequentialDecisionProvider.java` | A concrete LangChain4j `ReasoningProvider` exists. No concrete production `SequentialDecisionProvider` implementation was found in app/runtime main sources in the inspected snapshot. |
| Perception returns provenance-bearing observations | `supply-chain-agent-actions/.../external/perception/Observation.java`; `SupplyChainPerceptionActions.java` | The observation includes a source snapshot version; a later write must still revalidate current state. |
| Grounding uses distinct state-changing handlers | `supply-chain-agent-actions/.../external/grounding/SupplyChainGroundingActions.java` | Full dispatch, capability, idempotency, and world-adapter details are in Chapter 19 and Chapter 24. |
| Planning is performed over isolated branch state | `supply-chain-agent-planning/.../api/PlanningRequest.java`; `PlanningState.java`; `PlanningWorldModel.java`; `SimulatorBackedPlanningWorldModel.java` | Request action definitions must be grounding/domain-write actions inside the trusted proposal scope. Planning transitions call the deterministic simulator using branch snapshots and do not commit to `SupplyChainSimulationWorld`. |
| Three planning strategies share one interface but differ in search | `.../cot/SequentialReasoningPlanner.java`; `.../tot/ThoughtSearchPlanner.java`; `.../tot/DeterministicThoughtActionRanker.java`; `.../mcts/MctsSearchPlanner.java`; `.../routing/PlannerRouter.java` | Sequential provider is an injected port; default ToT-style ranker is deterministic; MCTS class calls itself an adaptation, not faithful RAP reproduction. |
| Evaluation replays a proposed path and distinguishes feasibility from approval | `.../api/DeterministicCandidateEvaluator.java`; `PlanEvaluation.java`; `PlanCandidate.java` | It aggregates supplied impact estimates; it does not independently prove the estimates match measured simulator outcomes. Aggregate risk uses an explicit independence assumption. Approval-required is a downstream governance flag. |
| Unsupported protected-customer constraint fails closed | `DeterministicCandidateEvaluator.java` and its test | The current domain model cannot identify protected commitments; the evaluator records a violation rather than claiming success. |

## Test anchors checked

- `WorkingMemoryServiceTest`
- `EpisodicMemoryServiceTest.newlyRecordedEpisodeIsNotReturnedAsTrustedExperience`
- `EpisodicMemoryServiceTest.onlyExplicitlyReviewedEpisodeBecomesRetrievableExperience`
- `SemanticMemoryServiceTest`
- `ProceduralMemoryServiceTest`
- `MemoryRetrievalServiceTest.exactRetrievalCombinesAllFourCoalaMemoryResponsibilitiesWithoutB1Scoring`
- `CoalaInternalActionsTest.workingMemoryUpdateIsScopedVersionedAndIdempotent`
- `CoalaInternalActionsTest.episodeLearningRecordsButDoesNotSelfVerify`
- `CoalaInternalActionsTest.reasoningActionRejectsEvidenceReferencesNotSuppliedByCaller`
- `LearningActionCatalogTest`
- `SupplyChainExternalActionsTest`
- `SequentialReasoningPlannerTest.sequentialPlannerBuildsOneLinearCandidateWithoutBranching`
- `ThoughtSearchPlannerTest.expandsStructuredAlternativesAndReturnsRankedCandidates`
- `MctsSearchPlannerTest.runsSeededMctsWithBoundedRolloutsAndTraceStatistics`
- `PlannerRouterTest`
- `DeterministicCandidateEvaluatorTest.acceptsSimulatorReplayedPlanAndMarksApprovalAsGovernanceRequirement`
- `DeterministicCandidateEvaluatorTest.rejectsAPlanWhoseClaimedStateDoesNotMatchSimulatorReplay`
- `DeterministicCandidateEvaluatorTest.rejectsPlanExceedingHardRiskThreshold`
- `DeterministicCandidateEvaluatorTest.failsClosedWhenProtectedCommitmentConstraintCannotBeVerifiedByCurrentDomainModel`

The chapter does not claim that these focused tests form one end-to-end trace. Full graph and durable-host behavior is reserved for Chapter 24.

## Validation boundary

This is a book-only change. Java, tests, Maven configuration, and the application repository were not changed. The review confirms source structure and named tests but does not rerun the Java acceptance pipeline. The user's previously accepted green CI remains the source acceptance baseline. Independent experimental validation remains a separate later phase.
