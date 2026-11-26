# Chapter 20 — Source and implementation review (v2)

**Scope:** Chapter 20 only, plus its source-reference register and five primary-listing QR assets.  
**Application revision used for source links:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`.  
**Application source status:** read-only; no application files were changed.

## Disposition

Chapter 20 is retained as the CoALA implementation bridge for memory, internal and external actions, planning, evaluation, and selection. The revision adds stable source identifiers to all seven Java listings, corrects several excerpts to match the implementation, and applies the agreed QR policy: five primary implementation spotlights receive QR codes; two supporting declarations/helpers retain clickable source and test references without QR codes.

## Source register

The source paths, test paths, method names, and source ranges below refer to the immutable GitHub revision above. Ranges are one-based GitHub source lines, not line numbers from a differently formatted local archive.

| ID | Listing | Source range | Proof tests | QR |
|---|---|---:|---|---|
| C20-S01 | `WorkingMemoryService.put(...)` | 49–56 | `staleWriterCannotOverwriteNewerWorkingMemoryVersion()`; `expiredWorkingMemoryCannotBeRevivedByAWrite()` | Yes |
| C20-S02 | `Episode.verify(...)` | 93–99 | `onlyExplicitlyReviewedEpisodeBecomesRetrievableExperience()`; `unverifiedEpisodeCannotBePromotedWithoutReviewEvidence()` | Yes |
| C20-S03 | `MemoryRetrievalService.retrieve(...)` | 24–44 | `exactRetrievalCombinesAllFourCoalaMemoryResponsibilitiesWithoutB1Scoring()`; `workingMemoryReferenceCannotBeReadAcrossScopes()` | Yes |
| C20-S04 | `ReasoningAction.execute(...)` | 25–36 | `reasoningActionRejectsEvidenceReferencesNotSuppliedByCaller()`; `reasoningProviderMalformedAssessmentIsRejectedInsteadOfAccepted()` | Yes |
| C20-S05 | `Observation<T>` compact constructor | 8–17 | `perceptionReturnsImmutableSnapshotObservationWithProvenance()` | No — supporting record |
| C20-S06 | `PlanningState.advance(...)` | 33–40 | `expandsStructuredAlternativesAndReturnsRankedCandidates()` | No — supporting state helper |
| C20-S07 | `SimulatorBackedPlanningWorldModel.apply(...)` | 54–64 | `acceptsSimulatorReplayedPlanAndMarksApprovalAsGovernanceRequirement()`; `rejectsAPlanWhoseClaimedStateDoesNotMatchSimulatorReplay()` | Yes |

## Content corrections and checks

- **C20-S01:** the excerpt presents the version and expiry checks before the immutable replacement and repository compare-and-set. It is described as a scoped working-memory update, not a global memory transaction.
- **C20-S02:** the episode lifecycle text distinguishes recording from explicit verification and evidence-backed promotion into trusted retrieval.
- **C20-S03:** the listing shows the complete `retrieve(...)` method, including working-memory lookup, scope/expiry handling, and the episodic, semantic, and procedural retrieval paths. The chapter explicitly separates deterministic retrieval from B1 ranking and B3 workspace admission.
- **C20-S04:** the code checks that provider citations are a subset of the evidence supplied in the request. The exception message and execution-aware provider call match the pinned source. The chapter does not describe a reasoning assessment as an action, memory write, or private reasoning transcript.
- **C20-S05:** the `Observation<T>` declaration remains a supporting type. It is linked through readable source and test references, without a QR code.
- **C20-S06:** `PlanningState.advance(...)` remains a supporting immutable state helper. It is linked through readable source and test references, without a QR code.
- **C20-S07:** validation of the planning request and its authority occurs before the simulator transition `try` block. Failures produced while applying the domain transition are converted into `WorldTransition.Rejected`; these are not described as the same failure category.
- The chapter distinguishes a planner proposal, candidate evaluation, strategy-specific candidate ordering/retention, and later execution authorization. It does not imply a shared `CandidateSelector` service or that the simulator-backed planning world model commits its branch to the current world.

## QR and PDF proof

Five vector QR assets are associated with C20-S01, C20-S02, C20-S03, C20-S04, and C20-S07. Their payloads are immutable source-view permalinks pinned to the application revision above. Each QR is also a clickable PDF link to that same URL. The text-only C20-S05 and C20-S06 references keep clickable source and test paths.

A local standalone XeLaTeX proof was rendered at 220 DPI. Automated PDF checks confirmed that all seven source-reference strips remain on the same page as their corresponding listings, that source and test hyperlinks exist, and that all five QR payloads decode and match the PDF link annotations. The proof PDF is 29 pages. This is a digital-layout check, not a physical-print certification.

The local proof substitutes DejaVu fonts and temporary diagram placeholders because the supplied archive does not include the production TeX Gyre fonts and generated Mermaid artwork. Accordingly, it is not a final production-font book build.

## Files changed

- Modified `Tex/part3/chapter20/chapter.tex`.
- Modified `CODE-PRESENTATION-PLAN.md` (Chapter 20 source register and proof note).
- Added this review report.
- Added five QR source pairs under `Tex/diagrams/source-qr/`: `C20-S01`, `C20-S02`, `C20-S03`, `C20-S04`, and `C20-S07` (each `.tex` and vector `.pdf`).

No Chapter 19 files, shared QR infrastructure, scaffold scripts, or application repository files are changed by this incremental Chapter 20 changeset. It assumes the previously accepted Chapter 19 changeset has already been applied.
