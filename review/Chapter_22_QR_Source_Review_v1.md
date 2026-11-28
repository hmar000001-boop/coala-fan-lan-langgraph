# Chapter 22 source mapping and QR review — v1

**Date:** 26 November 2026  
**Status:** Chapter 22 source strips and QR codes integrated; standalone XeLaTeX proof rendered and inspected.  
**Book source:** `Tex/part3/chapter22/chapter.tex`  
**Central source-navigation plan:** `CODE-PRESENTATION-PLAN.md`  
**Frozen application snapshot:** `haythemabr/supply-chain-agent` at `fa8cd5ec0742d7010dbba2c3646852e95062a419`

## 1. Scope and source provenance

This is a book-only changeset. It adds nine stable source references to Chapter 22, places QR codes on the seven primary implementation listings, gives the two supporting boundary-record declarations text-only source strips, and records the source map in the central presentation plan. It also converts the long failure-semantics table to a repeat-header `longtable` after the standalone proof exposed an oversized-float/caption clipping problem.

The source baseline is the exact revision identified by the uploaded `supply-chain-agent-main (10).zip` archive comment: `fa8cd5ec0742d7010dbba2c3646852e95062a419`. GitHub identifies this commit as the merge of the `Fix/B1` pull request. The archive's `CHANGESET_INFO/CHANGESET_INFO.txt` separately mentions `c49c543` as the base inspected revision for the M8 CI-evidence-capture repair; that metadata describes the base of that ancillary changeset, not the final application snapshot named by the archive comment. The two B1 Java files and their regression behavior are present in the supplied snapshot.

The B1 correction was checked before Chapter 22 work:

- `B1MemoryFeatureLearningService.enrich(...)` preserves the provider-supplied `candidate.expectedDownstreamUtility()` while continuing to apply access history, verified-use history, and cue-association learning.
- The persisted learned outcome statistic remains separate and normalized to `[0,1]`.
- `B1MemoryFeatureLearningServiceTest.verifiedDownstreamOutcomeUpdatesPersistedUseUtilityAndCueStatistics()` exercises provider utility `12.0` and learned outcome statistic `1.0`, and asserts that the candidate retains `12.0` while the other learning features continue to work.
- Chapter 21 already describes this distinction and cites the same pinned snapshot. No Chapter 21 amendment was needed in this changeset.

No Java, Java test, Maven, migration, application documentation, or application CI file is modified or included.

## 2. Chapter 22 source register

Every path and named test method below was found in the supplied application source snapshot. Source-line ranges were checked against those exact files. All GitHub links use commit-pinned `blob` URLs at the revision above; no URL points to a moving branch or raw-download endpoint.

| Source ID | Listing / source member | Repository-relative source path | Source lines | Test evidence | QR |
| --- | --- | --- | ---: | --- | --- |
| `C22-S01` | `ParentContextSnapshot` compact constructor — four-field parent identity contract | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ParentContextSnapshot.java` | 6–14 | `ImpasseResolutionServiceTest.childScopeMustMatchParentScope()`; `staleParentVersionRejectsChildResult()` | No — supporting record |
| `C22-S02` | `ChildResolutionResult` compact constructor — typed finding-only return packet | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ChildResolutionResult.java` | 7–22 | `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate()` | No — supporting record |
| `C22-S03` | `CognitiveCycleLifecycleServices.openImpasse(...)` — case creation, B4 delegation, and B2 start | `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecycleServices.java` | 291–306 | `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention()`; `b2ChildCannotExecuteACapabilityOutsideItsDelegatedScope()` | Yes |
| `C22-S04` | `ImpasseResolutionCase.recordAction(...)` — delegated capability and child-action budget | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionCase.java` | 46–50 | `ImpasseResolutionServiceTest.childActionBudgetAndCapabilityAreEnforced()`; `childCannotExceedActionBudget()` | Yes |
| `C22-S05` | `PostgresB2ChildStepReceiptStore.complete(...)` — completion fenced by claim state, token, and lease | `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresB2ChildStepReceiptStore.java` | 89–104 | `PostgresM7B2CoreIntegrationTest.childStepReceiptsResumeCompletedWorkAndFenceExpiredClaims()` | Yes |
| `C22-S06` | `CognitiveCycleLifecycleServices.validateImpasseReturn(...)` — authoritative parent check and case resolution call | `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecycleServices.java` | 407–415 | `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention()` | Yes |
| `C22-S07` | `ImpasseResolutionCase.resolve(...)` — case/result identity, timestamp, and disposition transition | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionCase.java` | 52–65 | `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate()`; `staleParentVersionRejectsChildResult()` | Yes |
| `C22-S08` | `RecoveryProcedureDraftService.approve(...)` — parent/evidence/action revalidation and trusted approval CAS | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureDraftService.java` | 72–88 | `RecoveryProcedureDraftServiceTest.approvalRequiresCurrentParentEvidenceAndTrustedOperatorAuthority()`; `approvalCannotCrossParentVersionOrObjectiveChange()` | Yes |
| `C22-S09` | `RecoveryProcedurePromotionService.validate(...)` / `activate(...)` — independent reviewer and activator | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedurePromotionService.java` | 90–104 | `RecoveryProcedurePromotionServiceTest.b2ApprovalStagesOnlyADraftAndIndependentProceduralLifecycleIsRequired()`; `proceduralReviewerAndApproverMustBeIndependentActors()` | Yes |

The `C22-S06` source range is deliberately limited to lines 407–415, which are the exact parent-snapshot guard and `impasses.resolve(...)` call shown in Listing 22.5. The surrounding method also performs uncertainty refresh, child-artifact lookup, B4 return, and optional draft proposal handling; those steps are explained in the adjacent prose and remain visible by opening the complete method through the QR/source hyperlink.

## 3. QR classification and layout

Seven listings receive QR codes: `C22-S03` through `C22-S09`. The two record declarations `C22-S01` and `C22-S02` are supporting contracts, so they receive complete text-only source strips and clickable source/test references but no QR. This follows the accepted policy from Chapters 19–21: QR codes identify primary implementation points rather than decorating every Java excerpt.

Each source strip shows its source ID, Maven module, complete repository-relative Java path, member, exact source lines, test file, and test method names. The QR and **Open exact source** label use the same immutable GitHub source URL. Test paths and test labels are independently clickable. The QR PDFs are vector assets generated from `.tex` payload sources using the shared QR macro infrastructure; quiet-zone padding remains enabled.

The seven listing/reference groups were verified on the same page in the final standalone proof:

| Listing | Source ID | Proof page |
| --- | --- | ---: |
| 22.1 | C22-S01 and C22-S02 | 5 |
| 22.2 | C22-S03 | 7 |
| 22.3 | C22-S04 | 9 |
| 22.4 | C22-S05 | 11 |
| 22.5 | C22-S06 | 14 |
| 22.6 | C22-S07 | 16 |
| 22.7 | C22-S08 | 19 |
| 22.8 | C22-S09 | 21 |

## 4. Source-fidelity and architecture qualifications retained

- The active `openImpasse(...)` path consumes an already typed host/domain signal and child investigation request. The detector's consolidation service is described separately; the chapter does not claim that the runtime automatically infers typed impasses from arbitrary failure text.
- `ParentContextSnapshot` is a four-value identity tuple (scope, request, working-memory version, objective fingerprint), not a copy of the parent objective or all dependencies.
- The child investigation is bounded by a delegated capability subset, a fixed allow-list, deadline, action budget, and durable step receipts. The case action count is distinct from the graph recursion limit and B6's broader resource governor.
- The PostgreSQL receipt completion predicate requires the step to remain `CLAIMED`, the fencing token to match, and the lease to remain live. This does not prove the business truth of findings or create a distributed transaction across repositories.
- Parent-return validation compares the domain parent snapshot against authoritative working memory before case resolution. It does not dereference and verify every evidence reference at that point; later procedure-draft governance performs additional evidence and action-descriptor checks.
- B2 case resolution, B4 intention return, recovery-draft approval, immutable-artifact staging, procedural validation, activation, and active retrieval remain separate transitions. An approved draft is not yet an active procedure.
- The source contains `HYPOTHESIS_PROPOSED`, but the reviewed live/test path does not exercise it. The current case transition maps every non-`UNRESOLVED` disposition to `RESOLVED`, and the chapter explicitly identifies the missing hypothesis-only gate as an open semantic/coverage edge.
- The chapter does not claim a full Soar superstate/substate implementation, Goal Dependency Set regeneration, a dedicated inner-B2-graph checkpointer, automatic procedure learning, or measured recovery benefit.

## 5. PDF proof and visual checks

The standalone Chapter 22 proof compiled with XeLaTeX to **34 US Letter pages** (612 × 792 pt). The final rendered proof was inspected at 220 DPI. All seven QR payloads were decoded from the actual rendered PDF, and each was compared with the source URI link annotation on the same page. All seven decoded payloads matched their commit-pinned source links exactly. The PDF contains a clickable link rectangle over each QR, with measured dimensions of approximately **19.15 × 19.50 mm**, including quiet-zone area. Text source/test links were also present as PDF URI annotations.

The proof exposed and corrected two layout issues before release:

1. The C22-S06 source range was narrowed from the whole enclosing method (400–446) to the exact lines displayed in Listing 22.5 (407–415).
2. The B2 failure-semantics table was converted from an oversized single-page float to a repeat-header `longtable`; the previous float clipped its caption at the bottom of a proof page. The final proof no longer reports a `Float too large` warning for that table.

**Proof limitation:** the supplied book archive does not include the production TeX Gyre fonts or generated Chapter 22 Mermaid PNGs. The isolated proof copy therefore used DejaVu font substitutions and clearly labelled temporary diagram placeholders. Those substitutions and placeholders are not part of this changeset and were not applied to the book's production preamble or diagram sources. The proof validates pagination, source-strip cohesion, QR scan decoding, and PDF link parity; it is not a production-font full-book build, verification of the final Mermaid artwork, or physical-print certification. The QR package's Tagged PDF limitation remains documented in the central presentation plan; readable clickable source/test references remain available independently of the QR.

## 6. Validation results

- Source/test validation: all 9 source paths, all 9 line ranges, and every named test file/method were found in the supplied `fa8cd5e` application snapshot.
- B1 provenance: the uploaded application ZIP comment identifies `fa8cd5e`; GitHub identifies that commit as the merge of `Fix/B1`; the provider utility preservation and `12.0` vs `1.0` regression remain present. Chapter 21 already describes this correction correctly.
- `python scripts/check-source-qrs.py`: passed; 21 QR assets across Chapters 19–22 match their commit-pinned PDF links.
- `bash scripts/check-scaffold.sh`: passed; Part III contains six chapters (19–24).
- `bash check-scaffold.sh`: passed; root wrapper delegates to the canonical scaffold check.
- `bash scripts/check-diagrams.sh --sources-only`: passed; 118 Mermaid sources, accessibility descriptions, sequence syntax guard, and all Chapter 1–22 figure references.
- Chapter 22 QR render/link parity: 7 of 7 decoded at 220 DPI and matched the same-page PDF URI annotation.
- Chapter 22 listing/source grouping: all nine source references (including the two no-QR supporting records) remain with their associated listings.

The standalone proof uses the supplied source tree and temporary render resources only. This changeset does not alter the application snapshot or reproduce any source Java files inside the book repository.

## 7. Change boundary

This incremental changeset modifies only `Tex/part3/chapter22/chapter.tex` and `CODE-PRESENTATION-PLAN.md`; adds seven QR `.tex` payloads and seven vector PDF assets for `C22-S03`–`C22-S09`; and adds this review note plus delivery metadata. It does not duplicate shared QR macros/scripts or any files from the already accepted Chapters 19–21 changesets. No application source, test, Maven, migration, deployment, or CI file is included.
