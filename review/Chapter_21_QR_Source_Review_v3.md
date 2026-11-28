# Chapter 21 source mapping and QR review — v3

**Date:** 26 November 2026  
**Status:** Chapter 21 source strips implemented; standalone XeLaTeX proof rendered and inspected.  
**Book source:** `Tex/part3/chapter21/chapter.tex`  
**Central source-navigation plan:** `CODE-PRESENTATION-PLAN.md`  
**Frozen application permalink revision:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Previous source-fidelity baseline:** `review/Chapter_21_Source_Review_v2.md`

## 1. Scope and source baseline

This is a book-only change. It adds stable source IDs and QR/source-reference strips to the seven Chapter 21 implementation listings, adds one focused coalition-enumeration listing, and corrects the B1 verified-outcome excerpt and the B3 attribution excerpt where their exception text did not match the application source. It does not modify Java source, Java tests, Maven files, migrations, application configuration, or application CI.

The seven source IDs use the repository identity and immutable GitHub source-view revision already established by the accepted Chapter 19/20 changesets: `haythemabr/supply-chain-agent` at `fa8cd5ec0742d7010dbba2c3646852e95062a419`. URLs use `blob` permalinks, not moving branches or raw-download URLs. The supplied application archive's later `CHANGESET_INFO` describes an M8 CI-evidence capture repair based on `c49c543` and lists only script/test-evidence tooling changes; it is not treated as a new Java implementation baseline. The accepted source review v2 remains the substantive source-fidelity baseline for B1 utility and B3 search semantics.

## 2. Chapter 21 source register

| Source ID | Listing / source member | Repository-relative source path | Source lines | Test evidence | QR |
| --- | --- | --- | ---: | --- | --- |
| `C21-S01` | `CognitiveCycleDecisionServices.retrieveEvidence(...)` — M2-to-B1 runtime sequence | `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/decision/CognitiveCycleDecisionServices.java` | 228–277 | `CognitiveCycleDecisionServicesTest.retrievalUsesM2BeforeB1AndPersistsTheSelectedEvidenceSet()`; `selectedLongTermMemoryProjectionIsIdempotentAfterGraphCheckpointInterruption()` | Yes |
| `C21-S02` | `B1RetrievalSelector.select(...)` — candidate scoring and context-budget selection | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1RetrievalSelector.java` | 26–93 | `B1RetrievalSelectorTest.selectorRanksByExpectedDownstreamValueAndFitsContextBudget()`; `measuredInfrastructureLatencyIsSeparateFromCognitiveLatency()`; `maintenanceProfileChargesRefreshWhenDueAndRecurringHorizonCost()` | Yes |
| `C21-S03` | `B1MemoryFeatureLearningService.applyVerifiedOutcome(...)` — exact-revision B1 feature update | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1MemoryFeatureLearningService.java` | 63–72 | `B3OutcomeEvidenceServiceTest.verifiedDownstreamOutcomeUpdatesOnlyTheExactAttributedB1MemoryRevision()` | Yes |
| `C21-S04` | `CognitiveCycleDecisionServices.attachB1MemoryAttributions(...)` — private adapter helper | `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/decision/CognitiveCycleDecisionServices.java` | 422–455 | Related integration: `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()` | No — supporting helper |
| `C21-S05` | `WorkspaceAdmissionService.admit(...)` — mandatory-first admission block | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b3/WorkspaceAdmissionService.java` | 66–79 | `WorkspaceAdmissionServiceTest.mandatoryContentIsAdmittedBeforeOptionalContent()`; `mandatoryContentExceedingCapacityFailsWithoutPartialSnapshot()`; `mandatoryContentExceedingMaximumCountFails()` | Yes |
| `C21-S06` | `WorkspaceAdmissionService.evaluateCoalitions(...)` / `enumerate(...)` — complete-combination proposal search | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b3/WorkspaceAdmissionService.java` | 204–254 | `WorkspaceAdmissionServiceTest.alternativeCoalitionsCompeteAsFirstClassOptionsAndRecordTheWinner()`; `incompleteCoalitionEnumerationFallsBackToSingletonAdmissionAndReportsTruncation()`; `coalitionCompetitionIsDeterministicAcrossCandidateInputOrder()` | Yes |
| `C21-S07` | `B3OutcomeEvidenceService.recordVerifiedOutcome(...)` — receipt/consumption/verifier gate | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b3/B3OutcomeEvidenceService.java` | 84–107 | `B3OutcomeEvidenceServiceTest.verifiedOutcomeMustReferenceAnAcceptedConsumedCandidateAndVerifiedSourceEvidence()`; `outcomeForUnconsumedCandidateOrUnverifiedEvidenceIsRejected()`; `persistedOutcomeIsReverifiedBeforeTrainerCapabilityIsMinted()` | Yes |

Every source and test file path above was found in the supplied application source tree, and every named test method was found in its named test file. Source line ranges are printed for navigation and correspond to the reviewed pinned source snapshot.

## 3. QR classification and editorial decisions

Six listings receive QR codes: `C21-S01`, `C21-S02`, `C21-S03`, `C21-S05`, `C21-S06`, and `C21-S07`. `C21-S04` intentionally remains text-only. It is a private adapter helper rather than a primary algorithm or state transition, and the related durable-host integration test does not directly assert this helper or a persisted B1 feature update. The printed source path, member, line range, related test file, test name, and clickable PDF references remain available; omitting the QR does not omit source navigation.

All QR payloads and visible **Open exact source** links use the same commit-pinned `blob` URL for that listing. Test-file paths and test labels link separately to the test file at the same commit. No QR points to `main`, `master`, or a raw-download URL. The six standalone `.tex` sources are generated with `qrcode.sty` using explicit quiet-zone padding; their vector PDF outputs are the assets included by the shared macro.

## 4. Content and source-fidelity review

### B1 retrieval and scoring

- `C21-S01` shows the runtime order: M2 retrieval, B1 candidate adaptation, optional feature enrichment, B1 selection, evidence-set persistence, selected-reference projection, then selection-access recording. The chapter does not imply that B1 is a second search engine or that M2 retrieval itself mutates working memory.
- `C21-S02` presents the net scoring calculation as the application's engineering objective. It is not labelled an ACT-R equation, nor is its logistic accessibility transform described as a calibrated probability. Cognitive latency and measured infrastructure latency remain distinct terms.
- The accepted B1 feature correction remains accurately qualified: candidate `expectedDownstreamUtility` is provider-supplied task-scale input; the persisted, legacy-named `B1MemoryFeatureState.expectedDownstreamUtility` remains a normalized [0,1] outcome statistic. The enrichment path does not copy that statistic into candidate utility. No calibration or adaptive selector-weight update is claimed.
- Maintenance remains described as implemented, not redesigned. `admissionValidationCost` is added on every estimate; the source does not disambiguate repeated validation work from a one-time historical admission cost. No sunk-cost amortization fix is claimed, and maintenance-event accounting remains separate from the durable host.

### B1-to-B3 attribution and verified learning

- `C21-S03` now reproduces the complete short `applyVerifiedOutcome(...)` method including the null guard and the exact scope-mismatch exception message. It updates only memory revisions named by the verified evidence and preserves idempotency through the outcome key.
- The cited B3 outcome test drives the receipt and verification path and asserts that the exact attributed B1 revision receives one update, while replay does not train twice.
- `C21-S04` corrects the source excerpt's scope-mismatch exception text to the actual application message. It remains a supporting helper and is not promoted to a QR-backed primary implementation.

### B3 admission and coalition search

- `C21-S05` shows mandatory candidates sorted and processed before optional competition. Mandatory protection does not override candidate-count, conflict, or capacity checks; a mandatory failure returns no partial snapshot.
- `C21-S06` was added because the original chapter explained the coalition-search behavior without showing the exact implementation point where the proposal counter advances. The excerpt now shows that the counter increments only after recursion reaches a complete combination of the requested size, and before aggregate capacity and fresh-coverage rejection.
- The configured search budget therefore bounds evaluated complete combinations, not every recursive node, partial branch, or total CPU work. Earlier partial branches pruned by capacity/conflict are not counted. The existing standard policy and fallback semantics remain as stated in source review v2: maximum coalition size 3; up to 512 evaluated complete combinations per admission; when enumeration is incomplete, the partial coalition comparison is discarded and singleton comparison is used. This is not described as exhaustive optimization or as a strict CPU-time cap.
- `C21-S07` shows the accepted persisted receipt, exact consumed candidate fingerprint, timestamp order, and verifier gate. The text retains the later append/re-read/reverification step before minting a trainer capability. A receipt is not a positive outcome and a persisted row is not an unrestricted learning instruction.

### Persistence and evaluation limits retained from source review v2

- The durable host uses an in-memory workspace repository; B3 receipts/outcomes and B1 feature state have PostgreSQL adapters. A configured PostgreSQL B1 feature repository is not by itself proof of focused database round-trip test coverage; no focused B1 feature-state PostgreSQL round-trip test was found.
- The generic maintenance ledger is in-memory and is not wired into the durable host as automatic maintenance-event measurement.
- Deterministic fixture/ablation results are descriptive test artifacts, not production benchmarks or causal evidence. No empirical improvement, causal attribution, production deployment, or generalized learning claim is made.

## 5. Layout and PDF proof

A standalone Chapter 21 proof was compiled with XeLaTeX and Biber. It contains 40 US Letter pages (612 × 792 pt). All seven listing/source-reference groups remain on one page each in the standalone proof:

| Listing | Source ID | Proof page |
| --- | --- | ---: |
| 21.1 | C21-S01 | 5 |
| 21.2 | C21-S02 | 8 |
| 21.3 | C21-S03 | 16 |
| 21.4 | C21-S04 | 19 |
| 21.5 | C21-S05 | 21 |
| 21.6 | C21-S06 | 24 |
| 21.7 | C21-S07 | 28 |

The six QR codes were decoded from 220-DPI rasterizations of the actual PDF. Each decoded payload was compared byte-for-byte with the URI annotation whose rectangle covers the printed QR; all six matched. Each clickable QR area measures approximately 19.15 × 19.50 mm, including the encoded symbol's quiet-zone area. The separate source/test links were checked, including the text-only C21-S04 source and test hyperlinks. The final XeLaTeX log contains no overfull horizontal-box warnings; the standalone build emits the expected glossaries warning because it does not print the book glossaries.

**Proof limitation:** the supplied archive does not contain the production TeX Gyre fonts or generated Chapter 21 Mermaid PNGs. The temporary standalone proof copy used DejaVu font substitutions and explicitly labelled temporary diagram placeholders. Neither the font substitutions nor the placeholders are included in this changeset or applied to `Tex/preamble.tex`. The proof validates code/source grouping, QR scan readability, and PDF hyperlink parity; it is not a production-font full-book build, a proof of final Mermaid artwork, or a physical-print certification. The QR macro's Tagged PDF limitations remain governed by the central plan; the readable clickable text paths are retained and the QR is not the sole access route.

## 6. Validation results

- `python3 scripts/check-source-qrs.py`: passed; 14 QR assets across Chapters 19–21 match their pinned PDF source links (3 + 5 + 6).
- `bash scripts/check-scaffold.sh`: passed; Part III contains exactly six chapters (19–24).
- `bash check-scaffold.sh`: passed; root wrapper delegates to the same canonical check.
- `bash scripts/check-diagrams.sh --sources-only`: passed; 118 Mermaid sources, accessibility descriptions, sequence syntax guard, and Chapter 1–22 figure references.
- Chapter 21 QR rendering and PDF link-annotation comparison: six of six passed at 220 DPI.
- Chapter 21 listing/source pair colocation: seven of seven passed in the standalone proof.

The scaffold checks above were run on the accepted post-Chapter-19/20 working tree after applying the six manual deletions listed in the already accepted Chapter 19 changeset's `DELETE_THESE_PATHS.txt`. ZIP extraction does not execute those deletion instructions; this Chapter 21 incremental changeset does not repeat or alter them.

## 7. Change boundary

Only Chapter 21, the central source-presentation plan, six C21 QR vector source/assets, and this Chapter 21 review note are changed/added. The previous Chapters 19 and 20 files and shared QR macros/scripts are not duplicated in this incremental changeset. No application project file is included.
