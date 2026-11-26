# Chapter 23 — Source and QR Review v1

**Chapter:** Persistent Intention and Resource Governance: B4 and B6  
**Review date:** 26 November 2026  
**Application snapshot:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Scope:** chapter prose/source fidelity, source/test references, QR and PDF links, standalone layout, diagram-source registration, and chapter build/scaffold integration.

## 1. Application snapshot and provenance

The supplied `supply-chain-agent-main` archive identifies application commit `fa8cd5ec0742d7010dbba2c3646852e95062a419` in its ZIP comment. The archive's `CHANGESET_INFO` contains a separate CI-evidence overlay base reference (`c49c543`); that is not used as the application-source baseline for Chapter 23. All Chapter 23 source and test URLs are pinned to the full `fa8cd5e` commit and use `blob` paths, not a branch alias.

The earlier B1 utility correction is present in the supplied application files: provider-supplied downstream utility remains `12.0` while normalized learned utility is retained separately as `1.0`. Chapter 23 does not reinterpret or duplicate that B1 correction; it follows B4 and B6 implementation in the same supplied snapshot. No application repository file was changed during this book revision.

## 2. Source register

All eleven source paths and test paths below were found in the supplied application archive. The exact member names and cited test-method names were checked against those files. The line ranges are one-based source-file ranges at the pinned snapshot.

| ID | Implementation | Source lines | QR | Evidence class |
| --- | --- | ---: | --- | --- |
| C23-S01 | `RecoveryIntention` record declaration | 13–38 | No | Supporting record |
| C23-S02 | `RecoveryIntentionService.changeMethod(...)` and `update(...)` | 67–70; 130–139 | Yes | Versioned method transition |
| C23-S03 | `CognitiveCycleLifecycleServices.governIntention(...)` decision switch | 477–493 | Yes | Runtime intention governance |
| C23-S04 | `PostgresRecoveryIntentionRepository.compareAndSet(...)` | 75–100 | Yes | Durable version/fingerprint CAS |
| C23-S05 | `UncertaintyAssessment.isCurrentFor(...)` and reference contract | 92–114 | No | Supporting identity contract |
| C23-S06 | `CognitiveCycleLifecycleServices.assessUncertainty(...)` | 499–541 | Yes | Scoped/idempotent uncertainty assessment |
| C23-S07 | `MetaControlGovernor.evaluate(...)` | 10–28 | Yes | Ordered B6 decision policy |
| C23-S08 | `PlannerBudgetDownshift` record/factory | 1–17 | No | Supporting value object |
| C23-S09 | `ResourceBudgetExecutionGuard.execute(...)` | 81–116 | Yes | Reservation, lease, fencing and accounting |
| C23-S10 | `PostgresResourceBudgetLedger.acquireLease(...)` | 279–295 | Yes | Expired-unstarted lease reclaim |
| C23-S11 | `BudgetedReasoningProvider.assess(...)` | 43–53 | No | Supporting runtime adapter |

The four no-QR references remain text-linked in the PDF. They are intentionally not assigned QR codes because they are supporting record, identity, value-object, or adapter excerpts rather than primary implementation spotlights.

## 3. Technical fidelity and teaching boundaries checked

- **B4 intention vs method:** the objective fingerprint and protected constraints remain stable while a typed, versioned transition can replace the active method/plan reference. The lifecycle service applies the domain-supplied directive; it does not invent method authority from model reflection.
- **B4 persistence:** the PostgreSQL compare-and-set checks scope, intention ID, expected version and objective fingerprint, and records history inside the same JDBC transaction. The chapter does not describe this as a distributed transaction across the B2 case store, graph checkpoint, or external action system.
- **B6 uncertainty:** assessment identity is tied to execution/scope and validity context. Calibration is optional; a stored assessment is not presented as evidence that a calibration profile is accurate.
- **B6 policy:** stop, interrupt, request-evidence, reduce-computation and continue decisions are ordered and typed. A planner downshift is not an increase to the shared durable execution ceiling.
- **B6 enforcement:** the guard reserves and establishes the durable operation-start boundary before provider invocation. An expired unstarted PostgreSQL lease may be reclaimed with a higher fencing token; an expired started operation is conservatively charged and is not replayed.
- **Action authority:** B4 and B6 do not authorize a specific external or simulator state change. Capability authorization, approval and final revalidation remain separate M3/domain boundaries.
- **B5/GraSP:** the chapter keeps B5 as the already-established Part II boundary; procedural memory and B2 recovery drafts are not represented as GraSP.

## 4. QR and PDF-link checks

Seven primary listings receive QR codes: C23-S02, C23-S03, C23-S04, C23-S06, C23-S07, C23-S09 and C23-S10. For each:

1. The QR payload equals the source URL supplied to `\BookSourceReferenceQR`.
2. The source ID, visible source path, QR and **Open exact source** target use that same pinned source URL.
3. The visible test path and test methods link to the corresponding test file at the same commit.
4. The QR is a vector PDF asset, black on white, with explicit quiet-zone padding; the printed linked region is approximately 19.2 × 19.5 mm.
5. The QR decoded from the standalone PDF at 300-DPI rendering. QR decoding at 220 DPI was not reliable for every long permalink, so the report does not claim a 220-DPI or physical-print certification.

PDF page inspection confirms that all eleven listing/source-reference pairs are on the same page. This includes the two source references that initially moved to the following page and the missing `\end{lstlisting}` delimiter that previously caused C23-S07's QR macro to be swallowed as listing text; both pagination issues and the delimiter are corrected in the delivered source.

## 5. Automated checks and proof limitations

| Check | Result | Scope/qualification |
| --- | --- | --- |
| `python3 scripts/check-source-qrs.py` | PASS | 28 QR assets across Chapters 19–23 match commit-pinned chapter links |
| `bash scripts/check-diagrams.sh --sources-only` | PASS | 124 Mermaid sources, accessibility metadata, syntax guard and Chapter 1–23 figure references |
| Chapter 23 source/test audit | PASS | 11 source paths, 11 test paths and listed test methods exist in the archive |
| Standalone PDF page/link audit | PASS | 35 pages; 11 listing/source pairs co-located; source and test links present; 7 QR payloads decoded at 300 DPI |
| XeLaTeX standalone proof | PASS with substitutions | DejaVu substitute fonts and temporary Graphviz stand-ins for the six Mermaid figures; no overfull boxes or unresolved citations in the proof log |
| Scaffold | PASS on canonical tree | Requires the previously approved Chapter 19 deletion list for obsolete placeholder directories 25–30 to have been applied |

The authoring environment did not have the repository-pinned Mermaid CLI installed, and its installation attempt exceeded the available command window. Thus the six `.mmd` sources and accessibility metadata are verified, but official Mermaid PNG rendering was not run here. The standalone PDF used temporary Graphviz render stand-ins solely to inspect page composition. The production TeX Gyre fonts were also unavailable, so the PDF is a layout/link proof, not a production-font proof. No physical printed proof was tested.

The application Maven test suite was not rerun during this book-editing pass. Test names were verified to exist in their test files; the report does not claim that the tests were executed in this session.

## 6. Build and scaffold integration

- `scripts/check-diagrams.sh` includes Chapter 23 in the source/reference inventory.
- `scripts/build-chapters.sh` includes the Chapter 23 standalone build and now regenerates all vector QR PDFs and runs the QR consistency checker before diagram rendering and chapter compilation.
- `scripts/check-scaffold.sh` now treats Chapter 23 as drafted/source-checked and retains Chapter 24 as the only placeholder in Part III; it checks the Chapter 23 outline, standalone driver and six accessible Mermaid sources.
- The canonical Part III count remains six chapters: 19–24. The C23 changeset does not repeat deletion of directories 25–30 already specified by the approved Chapter 19 changeset.
