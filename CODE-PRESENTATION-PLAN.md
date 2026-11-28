# Code Presentation and Source Navigation Plan

**Status:** Accepted design; Chapters 19–24 source strips implemented; all six chapters have source/test registers; Chapter 24 QR payloads and standalone layout checked  
**Created:** 25 November 2026  
**Applies to:** Part III, Chapters 19–24  
**Canonical LaTeX tree:** `Tex/part3/`  
**Implementation baseline reviewed for Chapters 19–24:** `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`

> **Provenance note.** The supplied book archive did not contain a file named `CODE-PRESENTATION-PLAN.md`. This is therefore the first version of the plan, created in the book repository; it is not an edit to a previously present copy.

## 1. Decision

Use **one QR code per primary implementation listing**, not one QR code per chapter and not one QR code for every code excerpt.

A QR code is a print-navigation shortcut for a particular implementation. It must never replace the explanation, the source path printed beside it, or the test evidence. The book continues to explain the problem, contract, algorithm, state transition, invariants, failure boundaries, and what the tests do and do not establish.

Place the QR/source reference strip immediately below the relevant listing by default. Align the QR block to the right and place the compact source-reference text beside it. The printed reference must remain useful without a phone: readers should see the source ID, Maven module, complete repository-relative source path, class/member, and corresponding proof test.

## 2. What qualifies for a QR code

A QR code is appropriate when a listing is a primary implementation spotlight:

| Content | QR policy |
| --- | --- |
| Primary algorithm or business-state transition | **Yes** |
| Critical authorization, concurrency, or fencing operation | **Yes** |
| Important lifecycle method that establishes a contract or recovery boundary | **Yes**, when the listing is central to the chapter |
| Supporting record, interface, enum, or value-object excerpt | No; print the source reference |
| Small helper method or short illustrative fragment | No; print the source reference |
| Test assertion accompanying an implementation listing | No separate QR; identify the test and link it in the PDF |
| Diagram spanning several modules | No; provide a source map or module map |
| Whole chapter | No chapter-level QR |

The threshold is pedagogical, not a count quota. A chapter may have no QR codes or several. Do not add a QR merely to make a page look balanced.

## 3. Source identity and stable references

Assign a stable, chapter-local source ID to each implementation spotlight or important supporting excerpt. Use the form `C<chapter>-S<sequence>` (for example, `C21-S03`). Do not derive IDs from source line numbers because lines can move during ordinary edits.

Every source reference must carry:

1. **Source ID** — the printed and searchable identifier.
2. **Repository revision** — the full immutable commit SHA used for the chapter.
3. **Maven module** — the real module name from the supplied reactor.
4. **Repository-relative path** — complete path from the repository root, including `src/main/java` or `src/test/java` as applicable.
5. **Class and exact member** — method, constructor, record, or other symbol discussed.
6. **Proof test** — test class and exact test method(s), with the test source path when space permits.

A source ID must resolve to one implementation target in one source revision. If the target changes materially or moves to another source file, review the ID rather than silently redirecting it. Supporting excerpts receive a source ID and printed path but do not automatically receive a QR.

## 4. Canonical URL and commit pinning

The QR and the visible **Open exact source** PDF hyperlink must use the **same canonical GitHub source-view permalink**. Use the GitHub `blob` view, not a `raw` file-download URL. Pin the exact commit; never use `main`, `master`, or another moving branch for a published source reference.

Canonical form (the current Chapter 19 links use this commit-pinned form):

```text
https://github.com/haythemabr/supply-chain-agent/blob/6329aec82e1d8b4f19b68986a0d4cf0c448f697f/{REPOSITORY_RELATIVE_PATH}
```

The source ID and the printed source path identify the same destination used by the QR. The test label is a separate clickable PDF reference to the test file at the same commit; it is not encoded in the implementation QR.

**Repository identity verified for this snapshot.** The application archive's `CHANGESET_INFO/CHANGESET_INFO.txt` records `haythemabr/supply-chain-agent`; its ZIP comment records commit `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. The public GitHub repository and commit-pinned source files were checked before these URLs were added. This is not an inferred owner/repository pair. The links intentionally target the source-file `blob` view at that immutable commit. Source line ranges remain printed next to the member because line-fragment anchors are not currently part of the QR payload.

## 5. LaTeX layout and package choice

### Default: `qrcode.sty` vector asset plus `hyperref`

Generate each QR as a small standalone vector PDF using the CTAN `qrcode` package (tested v1.51), then include that PDF in the source strip as a graphic. The reusable `\BookSourceReferenceQR` macro accepts one canonical source URL and uses it for the clickable source ID, clickable source path, clickable QR graphic, and visible **Open exact source** link. The adjacent standalone QR `.tex` payload is checked against that macro argument by `scripts/check-source-qrs.py`. The test file and test-method labels link separately to the matching test file at the same commit.

This two-stage approach is deliberate: in the tested XeLaTeX pipeline, wrapping the `qrcode` package's inline minipage output directly in `\href` did not produce a PDF link annotation over the QR area. Embedding the same vector output as a graphic does, and the final clickable rectangle is verified from the generated PDF. It retains LaTeX-based QR generation without a third-party image service or raster artwork.

The strip should have two aligned regions:

- **Text region:** source ID, module, full source path, class/member, source line range, test file, test methods, and the visible text **Open exact source**. The source ID and printed source path are clickable.
- **QR region:** a black-on-white vector PDF asset, right-aligned, with the short label **Scan to inspect**. The embedded graphic is wrapped in `\href` using the same source URL and produces a clickable PDF annotation over the QR square.

Keep the strip compact and directly attached to its listing. The reference text is part of the printed navigation system, not a replacement for the listing caption or surrounding explanation.

### Quiet zone is mandatory

The standalone QR source defaults to `tight`, which suppresses the empty border. Set `padding` explicitly for every printed QR. The padding option turns off tight rendering and adds the required four-module empty border on each side. The main book embeds the generated PDF on an opaque white field with zero extra color-box inset. Do not crop, cover, tint, invert, round, add a logo to, or place a background image behind the QR.

### Physical size

Target **18–21 mm for the complete printed square, including the quiet zone**. Each standalone asset uses a **17 mm matrix height**; the four-module border is included in the PDF asset. The main source strip includes the complete vector PDF at **19.5 mm high** (approximately 19.1–19.5 mm wide/high including the quiet zone, depending on the small baseline excess in the standalone page box). Do not assume the `height` parameter already includes the quiet zone: measure the actual embedded asset for each payload/version.

Longer commit-pinned URLs can produce denser QR matrices. Do not shorten the payload with a redirect, URL shortener, branch alias, or an unverified intermediary. If the resulting QR cannot be scanned reliably at the target size, investigate a layout/size change rather than changing the destination semantics.

### `hvqrurl` remains an alternative

Use `hvqrurl` only if the margin layout proves better for a particular page design. It is designed for QR placement in document margins and can select the outer margin in two-sided layouts. Its installed default QR height is 1 cm and must be increased and measured. In the installed version, set the visible `linktext` globally with `\hvqrset{...}` rather than relying on an unverified per-call option. It is not the default implementation for the standard source strip.

## 6. Digital-PDF behaviour and accessibility

The PDF must provide normal selectable text links labelled **Open exact source**, source ID, and source path in addition to the clickable QR. The printed path and source ID remain visible whether or not the PDF is interactive. Test-file and test-method references should also be clickable to their test file.

The QR is primarily a print-navigation mechanism; it is not the only way to access the source. The `qrcode` package is not to be assumed compatible with Tagged PDF. If a tagged/accessibility-conformant PDF is produced, test the QR treatment separately and retain the selectable text link and readable source reference independently of the QR object.

## 7. Verification required before publication

For each QR-enabled listing:

1. Verify the source path, symbol, exact commit, and line range against the frozen application snapshot.
2. Verify the associated test file and test method; state exactly what the test proves and does not prove.
3. Generate the QR with explicit quiet-zone padding and an opaque white field.
4. Confirm the QR payload and **Open exact source** hyperlink are byte-for-byte the same canonical source URL.
5. Confirm the test hyperlink resolves to the matching test path at the same commit.
6. Build the print-ready PDF and inspect the actual rendered page: no clipping, collision, overfull source text, or broken line wrapping.
7. Decode the QR from the final PDF render, including a high-quality raster rendition at 200 DPI or above.
8. Produce and scan a physical proof at the intended print size. A successful decode from a screen image is not physical-print certification.
9. Confirm that the code remains black-on-white, unaltered, and surrounded by the full quiet zone.
10. Re-run the checks whenever the source commit, URL, LaTeX macro, package version, QR size, or PDF production pipeline changes.

A chapter is not QR-approved merely because LaTeX compiled. Record the commit, resolved permalink, measured outside dimensions, decoded payload, PDF inspection, and physical-proof result in the relevant review note.

## 8. Pilot and rollout order

Chapter 19 established the source-strip layout across three implementation modules. Chapter 20 extended the convention to memory, reasoning, perception and planning contracts. Chapter 21 completed the B1/B3 mechanism-specific pilot. Chapter 22 completed the B2 child-step fencing and parent-context/version validation pilot. Chapter 23 now extends the convention to B4 persistent intention and B6 resource/uncertainty governance. Chapter 24 completes the Part III rollout by integrating the application-level graph, durable host, persistence families, model adapters, simulated action path, and restart evidence. It uses the same per-listing source-reference rules and does not add a chapter-level QR.

The source-strip dimensions, QR macro, caption treatment, visible path and test references, and clickable-link behaviour remain the accepted defaults. Apply QR only to primary implementation listings. Supporting records and small definitions retain text-only source strips. The final source register for each chapter must be appended to this plan as that chapter is completed.

## 9. Chapter 19 source-register created in the first revision

The Chapter 19 revision assigns these IDs and prints their full paths, members, source line ranges, and test evidence against application commit `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. The requested Listing 19.2 example receives a QR as an explicit reader-navigation pilot even though the constructor is a supporting typed-command excerpt; this is not a rule to QR every record or declaration:

| Source ID | Classification | Implementation target | QR status |
| --- | --- | --- | --- |
| `C19-S01` | Supporting value-object excerpt | `Quantity.plus()` / `requireSameUnit()` | No QR |
| `C19-S02` | Supporting typed-command constructor (author-selected pilot exception) | `SimulationCommand.ReserveInventory` constructor | **QR included** |
| `C19-S03` | Primary business transition | `SupplyChainSimulator.reduceSupplierCapacity()` | **QR included** |
| `C19-S04` | Critical world-version/compare-and-set gate | `InMemorySupplyChainSimulationWorld.apply()` | **QR included** |

C19-S01 remains a supporting value-object excerpt with a readable, clickable source path and no QR. C19-S02 is QR-enabled because the author specifically selected Listing 19.2 as the concrete pilot example. The source ID, path and **Open exact source** text link and QR payload share one exact source URL; the test file and test methods link to their separate test-file permalink.

## 10. Chapter 19 QR implementation and proof result

The Chapter 19 source strips are implemented in `Tex/shared-macros.tex` and used immediately below Listings 19.2, 19.3, and 19.4. The QR vector sources and generated PDF assets live in `Tex/diagrams/source-qr/`; `scripts/generate-source-qrs.sh` regenerates them with XeLaTeX and `scripts/check-source-qrs.py` verifies that each QR payload exactly matches the source URL passed to the macro. The book CI runs both steps before compiling. The command listing requested by the author (C19-S02) is included as the explicit pilot example. C19-S01 remains a clickable text-only source reference.

The standalone Chapter 19 proof was compiled and rendered at 220 DPI. The proof environment required temporary DejaVu font substitutions because the container did not have the book's TeX Gyre families; those substitutions were made only in the temporary proof copy and were not made in `Tex/preamble.tex`. The proof copy also used temporary diagram placeholders because the source archive does not include generated Mermaid PNGs. This is a layout/QR smoke test, not the production-font full-book PDF or a physical print proof.

| Listing | QR version / correction | Calculated outside size including quiet zone | Raster decode | PDF link check |
| --- | --- | ---: | --- | --- |
| 19.2 / `C19-S02` | 10-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; source ID/path/Open exact source use the same URL; tests link separately to `SupplyChainSimulatorTest.java` |
| 19.3 / `C19-S03` | 10-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; visible source links use the same URL; tests link separately to `SupplyChainSimulatorTest.java` |
| 19.4 / `C19-S04` | 11-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; visible source links use the same URL; tests link separately to `SupplyChainExternalActionsTest.java` |

The final 220-DPI page images were decoded successfully. For each listing, the decoded payload was compared byte-for-byte with the single PDF URI annotation whose rectangle covers the QR square; all three pairs match. Each clickable QR annotation measures 19.15 × 19.50 mm, including the quiet-zone area, and is within the target 18–21 mm range. The separate source-ID/path/Open exact source annotations and test-file annotations were also checked. The final rendered Listing 19.3 source strip no longer collides with the page number; only that long algorithm listing uses a local 8.5 pt / 9.5 pt code size to make room. No physical-print certification is claimed.

## 11. Non-negotiable editorial rules

- A QR never replaces the code that teaches the mechanism.
- A QR never replaces a source path, source ID, test reference, or the explanation of the test boundary.
- No branch-based or unverified URL may be printed or encoded.
- No fabricated repository owner, repository name, commit, path, symbol, line range, test, or scan result; the Chapter 19 links are tied to the repository identity and commit recorded in the actual source archive.
- Distinguish the source code from the test evidence; the test does not automatically prove every property described by the surrounding prose.
- Keep primary implementation code short enough to inspect in print; prefer a focused algorithm or state transition over unrelated surrounding code.
- Keep supporting records, interfaces, and tiny excerpts navigable through printed paths and clickable PDF text, without a QR quota.
- Preserve the distinction between a reference demonstration and a production integration throughout the Part III chapters.


## 12. Chapter 20 source register and QR classification

Chapter 20 maps the CoALA memory, internal-action, perception, and planning contracts to the frozen application revision `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. Seven listings receive stable IDs. Five are primary implementation spotlights and receive QR codes; the `Observation<T>` declaration and `PlanningState.advance(...)` helper remain supporting excerpts with clickable text references only.

| Source ID | Listing / implementation target | Source range | Proof test(s) | QR status |
| --- | --- | ---: | --- | --- |
| `C20-S01` | `WorkingMemoryService.put(...)` — version/expiry guarded compare-and-set update | 49–56 | `WorkingMemoryServiceTest.staleWriterCannotOverwriteNewerWorkingMemoryVersion()`; `expiredWorkingMemoryCannotBeRevivedByAWrite()` | **QR** |
| `C20-S02` | `Episode.verify(...)` — evidence-bearing episode lifecycle transition | 93–99 | `EpisodicMemoryServiceTest.onlyExplicitlyReviewedEpisodeBecomesRetrievableExperience()`; `unverifiedEpisodeCannotBePromotedWithoutReviewEvidence()` | **QR** |
| `C20-S03` | `MemoryRetrievalService.retrieve(...)` — exact cross-store retrieval boundary | 24–44 | `MemoryRetrievalServiceTest.exactRetrievalCombinesAllFourCoalaMemoryResponsibilitiesWithoutB1Scoring()`; `workingMemoryReferenceCannotBeReadAcrossScopes()` | **QR** |
| `C20-S04` | `ReasoningAction.execute(...)` — supplied-evidence citation integrity check | 25–36 | `CoalaInternalActionsTest.reasoningActionRejectsEvidenceReferencesNotSuppliedByCaller()`; `reasoningProviderMalformedAssessmentIsRejectedInsteadOfAccepted()` | **QR** |
| `C20-S05` | `Observation<T>` compact constructor — provenance- and snapshot-bound observation record | 8–17 | `SupplyChainExternalActionsTest.perceptionReturnsImmutableSnapshotObservationWithProvenance()` | No QR; supporting record |
| `C20-S06` | `PlanningState.advance(...)` — immutable branch path/evidence advancement | 33–40 | `ThoughtSearchPlannerTest.expandsStructuredAlternativesAndReturnsRankedCandidates()` | No QR; supporting state helper |
| `C20-S07` | `SimulatorBackedPlanningWorldModel.apply(...)` — isolated simulator-backed branch transition | 54–64 | `DeterministicCandidateEvaluatorTest.acceptsSimulatorReplayedPlanAndMarksApprovalAsGovernanceRequirement()`; `rejectsAPlanWhoseClaimedStateDoesNotMatchSimulatorReplay()` | **QR** |

All seven source paths and test paths resolve at the pinned commit, not a branch alias. The source line ranges above match the actual one-based line numbers of the pinned source files. Listing 20.3 shows the complete `retrieve(...)` method, including working-memory lookup, scope/expiry checks, and the episodic, semantic, and procedural read paths. For C20-S07, the printed explanation also distinguishes request/authority validation (performed before the `try` block and therefore fail-fast) from simulator/domain-transition failures converted to `WorldTransition.Rejected`.

The Chapter 20 standalone proof was used to check the source-strip layout, QR readability, and PDF link annotations. All seven listing/source-reference pairs remain on the same page. The five QR payloads are generated as vector PDF assets under `Tex/diagrams/source-qr/`; each was decoded from the rendered PDF at 220 DPI and matched the URL on its clickable QR annotation. The two text-only references retain clickable source and test links. This verifies the digital proof only; it is not a physical-print certification. The local proof substitutes DejaVu fonts and temporary diagram placeholders because the production TeX Gyre fonts and generated Mermaid artwork are absent from the supplied archive.

## 13. Chapter 21 source register and QR classification

Chapter 21 follows the B1 retrieval/learning path and the B3 workspace-admission/outcome path against frozen application commit `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. Seven stable source IDs are assigned. Six primary implementation listings receive QR codes; the private runtime attribution helper remains a text-only supporting reference because the available end-to-end test does not directly assert that helper or a persisted B1 feature update.

| Source ID | Listing / implementation target | Source range | Proof test(s) | QR status |
| --- | --- | ---: | --- | --- |
| `C21-S01` | `CognitiveCycleDecisionServices.retrieveEvidence(...)` — runtime handoff from M2 retrieval through B1 selection, evidence persistence, reference projection, and access-history recording | 228–277 | `CognitiveCycleDecisionServicesTest.retrievalUsesM2BeforeB1AndPersistsTheSelectedEvidenceSet()`; `selectedLongTermMemoryProjectionIsIdempotentAfterGraphCheckpointInterruption()` | **QR** |
| `C21-S02` | `B1RetrievalSelector.select(...)` — net-score ranking and context-budget selection | 26–93 | `B1RetrievalSelectorTest.selectorRanksByExpectedDownstreamValueAndFitsContextBudget()`; `measuredInfrastructureLatencyIsSeparateFromCognitiveLatency()`; `maintenanceProfileChargesRefreshWhenDueAndRecurringHorizonCost()` | **QR** |
| `C21-S03` | `B1MemoryFeatureLearningService.applyVerifiedOutcome(...)` — verified capability and exact memory-revision update | 63–72 | `B3OutcomeEvidenceServiceTest.verifiedDownstreamOutcomeUpdatesOnlyTheExactAttributedB1MemoryRevision()` | **QR** |
| `C21-S04` | `CognitiveCycleDecisionServices.attachB1MemoryAttributions(...)` — private runtime adapter mapping B3 candidates to exact B1 revisions | 422–455 | Related host integration: `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()`; this test does not directly assert the private helper or persisted B1 feature update | No QR; supporting helper |
| `C21-S05` | `WorkspaceAdmissionService.admit(...)` — mandatory-first admission and fail-closed constraints | 66–79 | `WorkspaceAdmissionServiceTest.mandatoryContentIsAdmittedBeforeOptionalContent()`; `mandatoryContentExceedingCapacityFailsWithoutPartialSnapshot()`; `mandatoryContentExceedingMaximumCountFails()` | **QR** |
| `C21-S06` | `WorkspaceAdmissionService.evaluateCoalitions(...)` / `enumerate(...)` — bounded complete-combination proposal search | 204–254 | `WorkspaceAdmissionServiceTest.alternativeCoalitionsCompeteAsFirstClassOptionsAndRecordTheWinner()`; `incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation()`; `coalitionCompetitionIsDeterministicAcrossCandidateInputOrder()` | **QR** |
| `C21-S07` | `B3OutcomeEvidenceService.recordVerifiedOutcome(...)` — accepted-consumed-receipt and verified-evidence gate | 84–107 | `B3OutcomeEvidenceServiceTest.verifiedOutcomeMustReferenceAnAcceptedConsumedCandidateAndVerifiedSourceEvidence()`; `outcomeForUnconsumedCandidateOrUnverifiedEvidenceIsRejected()`; `persistedOutcomeIsReverifiedBeforeTrainerCapabilityIsMinted()` | **QR** |

The C21-S06 counter increments only when recursion reaches a complete combination of the requested size. It increments before aggregate context-capacity and fresh-coverage rejection. The configured proposal budget therefore bounds evaluated complete combinations; it must not be described as a hard cap on all recursive calls, partial branches, or total CPU work. The tests listed for coalition search exercise alternative proposals, deterministic ordering, and explicit truncation fallback; they do not prove exhaustive optimization or a globally optimal workspace.

C21-S04 remains navigable through a printed source path and clickable source/test references but intentionally receives no QR. The cited durable-host test is related integration evidence, not a focused assertion for the private mapping helper or a durable B1 feature-state update. Keep this distinction visible; do not make the link look like stronger evidence than it is.

The six C21 QR assets are vector PDFs under `Tex/diagrams/source-qr/`, with one `.tex` payload source per QR. The Chapter 21 source strips use the shared `\BookSourceReferenceQR` / `\BookSourceReferenceNoQR` macros introduced and accepted in the Chapter 19 changeset. The final standalone proof compiled to 40 US Letter pages; all seven listing/reference groups stayed on one page, and the six QR payloads decoded at 220 DPI and matched their clickable PDF URI annotations. The QR symbols' clickable outside dimensions are approximately 19.15 × 19.50 mm. The repository QR validator passed for all 14 assets across Chapters 19–21; the scaffold checks passed at six Part III chapters and the Mermaid sources-only check passed for 118 sources. The standalone proof checks layout, scan decoding, and clickable PDF URL parity only; it is not a production-font full-book build or a physical print certification.


## 14. Chapter 22 source register and QR classification

Chapter 22 documents the B2 parent-linked impasse and protected-recovery path against the same immutable application revision `6329aec82e1d8b4f19b68986a0d4cf0c448f697f` used in Chapters 19–21. Nine stable references are assigned: seven primary implementation listings receive QR codes, while the two boundary-record declarations remain text-only supporting references. The chapter preserves the distinction between parent identity checks, case transition checks, child-step fencing, and the later governance lifecycle.

| Source ID | Listing / implementation target | Source range | Proof test(s) | QR status |
| --- | --- | ---: | --- | --- |
| `C22-S01` | `ParentContextSnapshot` compact constructor — four-field parent identity contract | 6–14 | `ImpasseResolutionServiceTest.childScopeMustMatchParentScope()`; `staleParentVersionRejectsChildResult()` | No QR; supporting record |
| `C22-S02` | `ChildResolutionResult` compact constructor — typed finding-only return packet | 7–22 | `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate()` | No QR; supporting record |
| `C22-S03` | `CognitiveCycleLifecycleServices.openImpasse(...)` — case creation followed by B4 delegation and B2 start | 291–306 | `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention()`; `b2ChildCannotExecuteACapabilityOutsideItsDelegatedScope()` | **QR** |
| `C22-S04` | `ImpasseResolutionCase.recordAction(...)` — delegated capability and child-action budget transition | 46–50 | `ImpasseResolutionServiceTest.childActionBudgetAndCapabilityAreEnforced()`; `childCannotExceedActionBudget()` | **QR** |
| `C22-S05` | `PostgresB2ChildStepReceiptStore.complete(...)` — completion guarded by claim state, fencing token, and live lease | 89–104 | `PostgresM7B2CoreIntegrationTest.childStepReceiptsResumeCompletedWorkAndFenceExpiredClaims()` | **QR** |
| `C22-S06` | `CognitiveCycleLifecycleServices.validateImpasseReturn(...)` — authoritative parent snapshot validation before case resolution and B4 return | 407–415 | `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention()` | **QR** |
| `C22-S07` | `ImpasseResolutionCase.resolve(...)` — case-level parent/result identity, timestamp, and disposition transition | 52–65 | `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate()`; `staleParentVersionRejectsChildResult()` | **QR** |
| `C22-S08` | `RecoveryProcedureDraftService.approve(...)` — parent/evidence/action revalidation and trusted-authority CAS | 72–88 | `RecoveryProcedureDraftServiceTest.approvalRequiresCurrentParentEvidenceAndTrustedOperatorAuthority()`; `approvalCannotCrossParentVersionOrObjectiveChange()` | **QR** |
| `C22-S09` | `RecoveryProcedurePromotionService.validate(...)` / `activate(...)` — independent procedural reviewer and activator | 90–104 | `RecoveryProcedurePromotionServiceTest.b2ApprovalStagesOnlyADraftAndIndependentProceduralLifecycleIsRequired()`; `proceduralReviewerAndApproverMustBeIndependentActors()` | **QR** |

The two text-only references are deliberately limited to supporting Java record contracts; they still print the complete module, source path, member, source lines, test path, and test methods, with clickable PDF source and test labels. The seven QR payloads use the same commit-pinned GitHub source URLs as their adjacent PDF links and are generated as vector PDF assets. The visible source path and test path remain alongside each code listing.

The Chapter 22 discussion distinguishes three separate enforcement locations: `recordAction(...)` consumes a case-level action slot before the host operation; the PostgreSQL receipt's `complete(...)` requires the exact claim to remain `CLAIMED`, the fencing token to match, and the lease to remain live; and `validateImpasseReturn(...)` compares the domain parent against authoritative working memory before calling the case-level `resolve(...)` transition. These controls do not make the inner B2 subgraph itself durable or constitute a distributed transaction across the case and B4 intention stores.

The optional recovery-procedure path remains explicitly staged. `approve(...)` changes the B2 draft to `APPROVED` only. `stageApprovedDraft(...)` publishes an immutable artifact and a CoALA procedural-memory `DRAFT`; it does not activate it. `validate(...)` requires a reviewer independent of the B2 draft approver, and `activate(...)` requires a separately validated version plus an activator independent of both earlier actors. The linked tests exercise these boundaries but do not establish that the stored procedure executes an action.

The Chapter 22 local standalone proof is used only for typography, source-strip cohesion, QR decoding, and PDF link verification. Production-font full-book compilation and physical-print certification remain separate release checks.

## 15. Chapter 23 source register and B4/B6 QR classification

Chapter 23 follows the B4 intention lifecycle and B6 uncertainty/resource governance against the exact application snapshot identified by the supplied archive's ZIP comment: `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. The archive's `CHANGESET_INFO` also contains a separate CI-evidence overlay base reference (`c49c543`); that overlay does not replace the application-code snapshot used by this chapter. The Chapter 23 QR and test URLs are pinned to the full `fa8cd5e` commit, not to a branch.

Eleven source IDs are assigned. Seven primary implementation listings receive QR codes; four supporting record/helper/adaptor excerpts retain clickable text references only.

| Source ID | Implementation target | Source range | Proof test(s) | QR status |
| --- | --- | ---: | --- | --- |
| `C23-S01` | `RecoveryIntention` record declaration — protected objective and method binding | 13–38 | `RecoveryIntentionServiceTest.intentionCapturesImmutableObjectiveFingerprintAndConstraints()`; `methodChangeUpdatesActivePlanReferenceButNeverObjectiveFingerprint()` | No QR; supporting record |
| `C23-S02` | `RecoveryIntentionService.changeMethod(...)` and common versioned `update(...)` path | 67–70, 130–139 | `RecoveryIntentionServiceTest.methodChangeUpdatesActivePlanReferenceButNeverObjectiveFingerprint()`; `staleVersionCannotOverwriteConcurrentIntentionUpdate()` | **QR** |
| `C23-S03` | `CognitiveCycleLifecycleServices.governIntention(...)` typed directive switch, including host-authorized termination | 477–493 | `M8B4FullGraphWorkflowTest.b4MethodChangeControlsTheNextFullGraphPlannerWithoutChangingTheCommittedObjective()` | **QR** |
| `C23-S04` | `PostgresRecoveryIntentionRepository.compareAndSet(...)` — scope, ID, version, objective fingerprint, and history transaction | 75–100 | `M8B4CRestartReconciliationIntegrationTest.concurrentIntentionUpdatesUseVersionCasAndPreserveTheProtectedObjective()` | **QR** |
| `C23-S05` | `UncertaintyAssessment.isCurrentFor(...)` and checkpoint-safe `Reference` | 92–114 | `MetaControlGovernorTest.uncertaintyAssessmentMustMatchExecutionScopeAndValidityWindow()`; `missingUncertaintyDimensionIsNotSilentlyTreatedAsZero()` | No QR; supporting identity/contract |
| `C23-S06` | `CognitiveCycleLifecycleServices.assessUncertainty(...)` — idempotent request, optional calibration checks, and monotonic revision | 499–541 | `UncertaintyCalibrationTrainerTest.activatedProfileCalibratesAllDimensionsButUncalibratedAssessmentRemainsUnchanged()` | **QR** |
| `C23-S07` | `MetaControlGovernor.evaluate(...)` — ordered stop, interrupt, evidence, downshift and continue precedence | 10–28 | `MetaControlGovernorTest.lowResourceMarginSelectsReducedComputationWithAnExplicitTypedPlannerDirective()`; `deadlineStopsExecution()`; `criticalPlanUncertaintyInterruptsForHumanDecision()` | **QR** |
| `C23-S08` | `PlannerBudgetDownshift` bounded value object and `halfBudget()` factory | 1–17 | `MetaControlGovernorTest.lowResourceMarginSelectsReducedComputationWithAnExplicitTypedPlannerDirective()` | No QR; supporting value object |
| `C23-S09` | `ResourceBudgetExecutionGuard.execute(...)` reservation, lease acquisition, operation-start fencing and heartbeat | 81–116 | `ResourceBudgetExecutionGuardTest.reservesBeforeWorkAndCommitsTrustedMeasuredUsage()`; `failedStartedWorkIsConservativelyChargedAtItsReservation()`; `committedOperationIdentityCannotBeInvokedAgain()` | **QR** |
| `C23-S10` | `PostgresResourceBudgetLedger.acquireLease(...)` — safe reclaim of expired unstarted reservation with fencing-token increment | 279–295 | `R1DefBudgetLeaseRecoveryIntegrationTest.expiredUnstartedReservationIsReclaimedWithANewFenceAndCanRunOnce()`; `expiredStartedReservationIsFencedAndChargedConservativelyWithoutReplay()` | **QR** |
| `C23-S11` | `BudgetedReasoningProvider.assess(...)` — M3 reasoning routed through shared B6 guard | 43–53 | `M8B4DPostgresBudgetExecutionIntegrationTest.m5PlanningAndM3ReasoningConsumeOneSharedPostgresBudgetAccount()`; `closedPostgresBudgetStoreBlocksReasoningBeforeProviderInvocation()` | No QR; supporting adapter excerpt |

The four no-QR entries remain navigable through their printed source path, source ID and clickable PDF links. The seven QR-enabled entries use the same full commit-pinned `blob` URL for the QR, source ID, printed path and **Open exact source** hyperlink; test links use the matching test file at the same commit. Each QR has explicit quiet-zone padding and a standalone vector PDF asset.

The B4 evidence is layered: local service tests cover objective identity and stale-version rejection; the full-graph test shows a changed method reaching the next planner call; and the PostgreSQL restart integration test demonstrates one winner for a concurrent version CAS with history recorded. These are not a distributed transaction across intention, B2 case, graph checkpoint and external action stores.

The B6 evidence covers scoped assessment identity/validity, optional calibration, ordered meta-control decisions, guard reservation/operation-start/accounting, and two distinct PostgreSQL expiry outcomes. An expired unstarted reservation can be reclaimed under a newer fencing token; an expired started reservation is conservatively charged and not replayed. The M8B4D test separately covers shared M5-planning/M3-reasoning accounting. None of these tests establishes live calibration quality, universal host wiring, external action outcome, or production deployment.

Six diagram sources are added under `Tex/diagrams/source/part3/chapter23/`. `scripts/check-diagrams.sh` now includes Chapter 23 in its source/reference inventory, and `scripts/build-chapters.sh` includes the Chapter 23 standalone driver. The build driver now regenerates the vector QR assets and runs `scripts/check-source-qrs.py` before rendering diagrams and compiling chapters. Mermaid PNGs are generated by the repository's pinned Mermaid CLI using `scripts/render-diagrams.sh`; they are build outputs and are not part of the chapter-only changeset.

The standalone layout proof has 35 pages. Automated PDF inspection confirms that all eleven listing/source-reference pairs (seven QR and four text-only) remain on the same page, all source and test links are present, and all seven QR symbols decode to the exact source permalink at 300-DPI rendering. The PDF proof used substitute DejaVu fonts and temporary Graphviz-rendered stand-ins for the six Mermaid figures because the repository-pinned Mermaid CLI and production TeX Gyre fonts were unavailable in the authoring environment. This verifies layout and link placement, not final production typography, official Mermaid rendering, or physical print scanning.



## 16. Chapter 24 application composition source register

Chapter 24 uses the application archive whose ZIP comment pins the Java snapshot to `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`. The `CHANGESET_INFO` entry records a separate `c49c543` base only for an overlay changing CI evidence-capture scripts; it contains no Maven/Java source or workflow YAML changes. All Chapter 24 source and test permalinks therefore use the full `fa8cd5e` commit rather than a branch.

Fourteen source-reference records are assigned. Seven primary implementation listings receive a QR code; seven supporting contracts/adapters/persistence or test references retain clickable text-only navigation. The small `Phase0Application` intake smoke program is linked separately in the runnable-surface discussion because it has no dedicated test and is not a primary listing.

| Source ID | Implementation / evidence | Source range | Test evidence | QR |
| --- | --- | ---: | --- | --- |
| `C24-S01` | `CognitiveCycleOperations` typed application port | 24–98 | `CognitiveCycleGraphTest.readOnlyCycleRunsThroughCoalaPlannersAndObservationWithoutApproval()`; `stateChangingCandidateInterruptsAndResumesOnlyAfterBoundApproval()` | No QR; supporting port |
| `C24-S02` | `CognitiveCycleState.SCHEMA` and typed graph-state projection | 18–90 | `CognitiveCycleGraphTest.retrievalProjectionAdvancesTheWorkingMemoryVersionInGraphState()` | No QR; supporting state contract |
| `C24-S03` | `CognitiveCycleApplicationGraph.buildFull(...)` / `compileFull(...)`, including shared-guard identity check | 44–105 | `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()` | **QR** |
| `C24-S04` | `CognitiveCycleGraph.build(...)` node registrations and conditional routes | 619–735 | `CognitiveCycleGraphTest.stateChangingCandidateInterruptsAndResumesOnlyAfterBoundApproval()`; `b2ImpasseIsResolvedInItsOwnBoundedSubgraphBeforeParentReconsiders()` | **QR** |
| `C24-S05` | `DurableCognitiveApplicationHost.open(...)` / `assemble(...)` composition root | 272–364 | `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()` | **QR** |
| `C24-S06` | `PostgresLangGraph4jCheckpointSaverFactory.create(...)` and `threadIdForExecution(...)` | 23–38 | `PostgresLangGraph4jSaverFactoryIntegrationTest.executionThreadIdentityIsStableAndScopeSeparated()`; `productionSaverFactoryUsesSharedDataSourceForPauseAndRestartResume()` | **QR** |
| `C24-S07` | `PostgresAgentPersistence` single-DataSource composition facade | 17–69 | `DurableCognitiveApplicationHostPostgresIntegrationTest.durableHostPersistsMemoryRestoresInterruptedCycleAndAcceptsANewTopLevelCycle()` | No QR; supporting facade |
| `C24-S08` | `LangChain4jRequestInterpreter.interpret(...)` closed outcome normalization | 17–50 | The primary REQ-09 integration test deliberately injects a deterministic `RequestInterpreter`; it does not exercise this adapter or a live model. | No QR; adapter boundary |
| `C24-S09` | `LangChain4jReasoningProvider.assess(...)` evidence-key validation and confidence fallback | 28–53 | `LangChain4jReasoningProviderTest.modelCannotCiteEvidenceKeyNotPresentInTheRequest()`; `missingConfidenceDegradesToUnassessedRatherThanInventingCertainty()` | No QR; adapter contract |
| `C24-S10` | `BudgetedReasoningProvider.assess(...)` shared guard accounting | 20–53 | `BudgetedReasoningProviderTest.realM3ReasoningActionReservesAndCommitsDurableB6InvocationUsage()`; `budgetLedgerOutageFailsClosedBeforeCallingTheProvider()` | No QR; supporting adapter |
| `C24-S11` | `ActionDispatcher.dispatch(...)` and receipt/unknown-outcome path | 41–200 | `ActionDispatcherTest.duplicateSuccessfulMutationIsNotExecutedTwice()`; `authorizationIsCheckedBeforePreconditionAndIdempotencyClaim()` | **QR** |
| `C24-S12` | REQ-09 two-cycle durable-host integration test | 151–302 | `durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()` | **QR** |
| `C24-S13` | `M8B4ForkedJvmProbe` first/replacement-process path | 77–161 | `M8B4ForkedJvmProcessRestartIntegrationTest.independentJvmRestartRestoresWorkflowAuthorityBudgetAndExternalOutcome()` | **QR** |
| `C24-S14` | Full-graph fresh-JVM clarification test | 275–303 | `M8B4FullGraphWorkflowTest.completeApplicationGraphResumesFromPostgresCheckpointInFreshJvmAfterAbruptDeath()`; expected terminal path is `ESCALATED`. | No QR; test boundary |

The seven QR assets (`C24-S03`, `S04`, `S05`, `S06`, `S11`, `S12`, and `S13`) use explicit quiet-zone padding and vector PDF symbols. The same commit-pinned source URL is used by the QR payload, clickable source ID/path, and **Open exact source** PDF link. The no-QR references remain text-linked. The shared macro retains 19.5 mm as the standard QR size; only the two densest Chapter 24 payloads (`C24-S06` and `C24-S12`) use the 21 mm variant, both within the agreed 18–21 mm target. All 14 source-reference mappings are included in `review/Chapter_24_QR_Source_Review_v1.md`; the separate `Phase0Application` path is linked in the chapter text and is explicitly identified as an intake-only smoke program without a dedicated automated test.

The chapter keeps three persistence concepts distinct: CoALA and mechanism/runtime repositories, the LangGraph4j checkpoint, and the simulator's authoritative world. It also keeps the three different restart claims separate: REQ-09 reconstructs host instances in one JVM; the focused action-ledger probe launches two JVMs with a small graph and marker provider; the full-graph fresh-JVM test resumes a clarification checkpoint and terminates `ESCALATED`. None of these is silently promoted to a general production restart guarantee.

Seven accessible Mermaid sources are added under `Tex/diagrams/source/part3/chapter24/`. The diagram checker inventories Chapter 24 and the individual chapter build script includes `Tex/standalone/chapter24.tex`. The QR generator and validator are cumulative and now verify 35 primary-source QR assets across Chapters 19–24. Generated Mermaid PNGs and standalone proof PDFs are build artifacts and are not included in the chapter-only changeset.

