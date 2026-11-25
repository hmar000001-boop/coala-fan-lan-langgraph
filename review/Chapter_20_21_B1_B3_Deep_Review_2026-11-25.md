# Final source reconciliation — Chapters 20–21 (B1/B3)

**Date:** 25 November 2026  
**Status:** Final LaTeX reconciliation after the accepted B1 utility-scale correction and author-confirmed green GitHub Actions CI.  
**Book baseline:** `coala-fan-lan-langgraph-main (1).zip`, SHA-256 `57ad1dc0ab694e7818b62a05a40a876b50313296cd6947b0a3b582572e144143`.  
**Application baseline:** `supply-chain-agent-main (9).zip`, SHA-256 `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`, plus the accepted two-file B1 patch.  
**Scope of this delivery:** LaTeX/book files only. No supply-chain application file is included or modified.

## 1. Final disposition

Only Chapter 21 required source-fidelity edits for the accepted application change and the rejected-proposal cleanup. Chapter 20 remains unchanged. Part II Chapters 12, 14 and 18 remain unchanged because they analyze the B1/B3 mechanisms and present engineering designs; they do not claim that the application has implemented every proposal. Chapters 19 and 22–24 remain unchanged because the examined text does not describe the altered B1 enrichment behavior, the `MaintenanceProfile` formula, or the B3 coalition-evaluation counter.

The previous combined review described three application corrections as if all three had been applied. That was not the accepted result. The author subsequently reviewed the findings and approved only the B1 learned-utility-scale correction. The maintenance-profile redesign and B3 search-expansion/input-cap redesign were rejected and are **not** part of the frozen application.

## 2. Application baseline now described by Chapter 21

### 2.1 Accepted B1 utility-scale correction

The author confirmed GitHub Actions CI green for the inventory-safe two-file B1 patch. The accepted patch changes only:

- `B1MemoryFeatureLearningService.java`
- `B1MemoryFeatureLearningServiceTest.java`

`B1MemoryFeatureLearningService.enrich` continues to merge bounded selection-access and verified-use histories and overlay persisted cue-association strengths. It now preserves `B1MemoryCandidate.expectedDownstreamUtility` supplied by the trusted candidate-feature provider. It does not copy the persisted outcome statistic from `B1MemoryFeatureState` into that candidate field.

The persisted record component remains named `expectedDownstreamUtility` and remains constrained to [0,1]. Its update is a normalized outcome-quality statistic: `USEFUL` maps to 1.0, `HARMFUL` to 0.0, and `NEUTRAL` to 0.5; subsequent outcomes use `0.8 × old + 0.2 × reward`. The task-scale candidate utility has no declared calibration to this normalized value. Chapter 21 now distinguishes the two and does not claim that the normalized value is a calibrated task-utility learner or a selector input.

The existing test method was extended rather than adding an additional `@Test` method, preserving the M8-B5 inventory. Its current name is `B1MemoryFeatureLearningServiceTest.verifiedDownstreamOutcomeUpdatesPersistedUseUtilityAndCueStatistics`. It verifies a provider utility of 12.0 remains 12.0 while the persisted normalized statistic is 1.0 and the access/cue features continue to update.

### 2.2 Maintenance profile — unchanged; semantic caveat documented

The accepted application retains the original five-field `MaintenanceProfile`:

- `admissionValidationCost`
- `refreshCost`
- `recurringCostPerDay`
- `refreshInterval`
- `lastMaintainedAt`

The selector calls `estimateCost(request.evaluatedAt(), request.maintenanceHorizon())`. The method adds `admissionValidationCost` on every estimate, adds `refreshCost` when `lastMaintainedAt + refreshInterval` is not later than the evaluation time, and adds `recurringCostPerDay × horizonDays`.

The field's intended semantics are not disambiguated by the source: if `admissionValidationCost` represents validation repeated at selection time, the repeated addition may be intentional; if it represents a historical one-time admission/embedding/storage expense, charging it again on each estimate would conflict with the sunk-cost rule in Part II Chapter 12. The Java source does not implement the previously proposed marginal/amortized redesign. Chapter 21 now reports the literal formula, flags the ambiguity, and refrains from claiming that sunk-cost accounting is solved.

The exact selector test is `B1RetrievalSelectorTest.maintenanceProfileChargesRefreshWhenDueAndRecurringHorizonCost`. The in-memory maintenance ledger remains a separate path; the accounting service is not wired as automatic event measurement in the durable host.

### 2.3 B3 coalition search — unchanged; actual bound documented

The accepted application retains `WorkspaceCoalitionCompetitionPolicy(maximumCoalitionSize, maximumEvaluatedCoalitionProposals)`. Its standard setting is `(3, 512)`.

The counter is incremented when enumeration reaches a **complete combination** of the requested size, before aggregate context-capacity and fresh-coverage checks. Consequently, complete combinations that are then rejected by those checks consume the counter. However, partial branches pruned earlier because an individual candidate does not fit the remaining capacity or conflicts with selected/current partial members do not consume it.

The counter is accumulated across iterative admission rounds for one workspace admission. The application has no independent request-input-candidate cap. `WorkspaceAdmissionRequest.maximumCandidates` limits the number of entries that may be admitted into the workspace; it does not limit the number of candidates in the incoming request.

If the configured complete-combination budget is exhausted before enumeration is complete, the partial coalition set is not treated as complete; the service records truncation and falls back to singleton comparison. This is not a strict bound on every recursive traversal operation or total CPU work. The two proposed changes (count every recursive extension and reject requests over 512 input candidates) were not accepted and are absent from the frozen source.

The current truncation test is `WorkspaceAdmissionServiceTest.incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation`. No conflict-heavy expansion-budget or input-cap regression test from the rejected proposal is cited.

## 3. Cross-chapter and duplication findings

### Chapter 19 → Chapter 20

Chapter 19 retains ownership of the supply-chain domain, simulator, action boundary and Maven-module map. Chapter 20 uses those foundations to map CoALA memory, internal/external actions, planning and evaluation. No repeated domain/simulator or module tour was introduced.

### Chapter 20 → Chapter 21

Chapter 20 explains the four CoALA memory responsibilities, M2 query eligibility and `MemoryRetrievalResult`. It explicitly states that retrieval does not perform B1 scoring, B3 admission or automatic working-memory projection. Chapter 21 begins at that seam and does not repeat the memory taxonomy or M2 implementation listing. No Chapter 20 edit was necessary.

### Chapter 21 → Chapters 22–24

Chapter 21 describes only how the B6 distinct-kind directive constrains B1/B3 selection and how B1/B3 evidence is persisted and consumed. It does not move B2 recovery mechanics, B4/B6 lifecycle governance or full LangGraph4j composition into this chapter. Those remain in Chapters 22, 23 and 24 respectively.

### Part II continuity

Chapter 12's cost-accounting principle remains the design-level rule; Chapter 21 now explains that the current `MaintenanceProfile` does not fully specify whether the admission-validation term is incremental or historical. Chapter 14's B3 mechanism analysis remains conceptual; Chapter 21 describes the actual complete-combination budget without upgrading it into a strict search-traversal bound. Chapter 18's B1/B3 candidate-domain distinction remains consistent with the as-built application.

## 4. Chapter 21 revisions applied

- Corrected the `MaintenanceProfile.estimateCost` code listing to pass both `evaluatedAt` and `maintenanceHorizon`.
- Replaced the false three-input marginal/amortized maintenance description with the actual five-field formula and its unresolved `admissionValidationCost` semantics.
- Corrected the current maintenance test method name.
- Removed the nonexistent `normalizedOutcomeQualityEstimate` API claim; retained the legacy component/JSON name and explained its implemented [0,1] update.
- Updated the B1 regression-test reference to the accepted method name.
- Replaced the false B3 input cap and recursive-extension budget with the actual complete-combination evaluation count, early-pruned branch behavior, per-workspace-round accumulation, and absence of an independent input cap.
- Removed references to two tests from the rejected B3 proposal.
- Updated the as-built handoff paragraph, evaluation provenance note, S/C/T/P/L/R discussion and chapter recap to avoid describing rejected Java changes.
- Updated the approved outline and source-review records to the accepted frozen baseline.

## 5. Validation and boundaries

- Source checks were performed against the supplied application snapshot overlaid with the accepted two-file B1 patch.
- All 49 unique test references in the current approved outline resolve to exact test methods in that accepted source tree.
- Chapter 20 and the neighboring Part III chapter sources were searched for claims about the corrected B1 enrichment, maintenance-profile formula, and coalition-search counter. No further chapter edit was justified.
- The six Chapter 21 Mermaid sources are unchanged; only their surrounding explanation was revised. Their source and figure references remain aligned.
- The author reported green GitHub Actions CI for the accepted B1 patch. This LaTeX work did not rerun or modify application CI.
- The standalone Chapter 21 TeX proof is validated separately. The local Mermaid CLI 12.2.0/canonical book build remains a repository/CI check if the local environment cannot reproduce the pinned renderer.

## 6. Final editorial decision

Chapter 21 is now aligned to the frozen application after the only accepted Java correction. Chapter 20 and the other chapters are retained unchanged. The maintenance-profile ambiguity and B3 search-bound limitation are described as implementation facts/limitations, not silently fixed or presented as enhancements. The supply-chain application remains frozen for the rest of Part III; subsequent work is confined to the LaTeX book.
