# Phase 4 — Part II selective compression (Chapters 9–18)

## Scope

This change set applies the reviewed editorial-compression recommendations to Part II, Chapters 9–18. It changes only the ten chapter source files listed in `CHANGE_MANIFEST.csv` and adds this changelog, a change-set README, and the manifest.

The objective is to remove repeated presentation, not distinct content. Mechanism explanations, historical/source evidence, engineering bridges, contracts, state models, worked examples, tests, evaluation arguments, and materially different warnings remain in the chapters.

## Chapter-by-chapter changes

### Chapter 9
- Removed the takeaway that repeated the recap.
- Moved the bounded-review caution into the section that explains the review method, where its qualification is directly relevant.
- Shortened repeated common-misreading prose.
- Retained the distinction between searchable stores and ACT-R and the substantive review-scope explanation.

### Chapter 10
- Removed the second takeaway because its ACT-R interpretation is already explained in the body and recap.
- Kept the useful distinction between state and control.
- Shortened repeated common-misreading prose.
- Preserved all seven reconstruction fields and the separate treatment of unknown, absent, and not applicable values.

### Chapter 11
- Removed a takeaway that repeated the recap.
- Consolidated repeated common misreadings into a shorter set of interpretive distinctions.
- Preserved the historical-family table, migration-landscape table, corpus boundaries, and warning that a runtime interface does not establish a historical cognitive mechanism.

### Chapter 12
- Removed two takeaway boxes whose organizing distinctions are already fully explained in the chapter and recap.
- Kept the separate supplementary comparison sections because they cover materially different retrieval, memory-lifecycle, temporal-validity, graph, and redundancy-control decisions.
- Preserved the full B1 design, evaluation, and engineering bridge.
- This file also carries forward the accepted Phase 2 technical corrections: the citation macro repair; explicit activation/accessibility treatment; distinct latency ranking and hard-deadline roles; maintenance-cost accounting clarification; seven-field B1 reconstruction; and baseline-versus-supplementary comparison boundary.

### Chapter 13
- Reduced the repeated conceptual exposition of the B2 control chain to a concise map of its linked stages and authority boundaries.
- Left the following implementation sections as the detailed treatment of contracts, state transitions, failure handling, and execution.
- Removed the takeaway that repeated that control chain.
- Preserved the worked trace and distinct side-effect and causal-evaluation warnings.

### Chapter 14
- Removed the central-question note because it duplicated the chapter opening/overview.
- Removed the takeaway that repeated the recap.
- Combined review questions and practical exercises into one container, preserving all questions and all exercises under separate labels.
- Retained the note that B3 has no canonical score and preserved the LIDA/B3 mechanism comparisons and implementation bridge.

### Chapter 15
- Added a distinct Chapter-at-a-glance section.
- Shortened the opening incident setup because the chapter retains a fuller Product X execution trace later.
- Removed the takeaway that repeated the recap.
- Combined the review-question and practical-exercise containers without removing either set.
- Preserved BDI and MIDCA mechanisms, commitment policies, method authority, contracts, state-machine design, worked trace, and tests.

### Chapter 16
- Added a distinct Chapter-at-a-glance section.
- Compressed the opening incident setup and removed the central-problem note that repeated it.
- Removed the repeated E3/D3 qualification from the recap while retaining the substantive warning in the section that explains the B6 mapping.
- Preserved EPIC/Sigma, uncertainty propagation, resource governance, interruption/stopping, authority, and the distinct calibration and idempotency warnings.

### Chapter 17
- Corrected the opening structure: Chapter at a glance is now separate from the learning objectives.
- Shortened the worked-example caveat while retaining the distinction between the illustrative trace and empirical or implementation validation.
- Shortened the Chapter 18 handoff so it does not repeat the closure qualification.
- The recap now points to the validity section for the detailed evidence boundary rather than repeating that qualification in full.
- Preserved the negative B5 case, GraSP correspondence, experiments, validity discussion, source provenance, and safety boundary.

### Chapter 18
- Added a distinct Chapter-at-a-glance section.
- Shortened prose that repeated the five-residual/one-closed-case synthesis table.
- Removed the takeaway that repeated the synthesis and recap.
- Standardized the recap by placing its existing content in the `chapterrecap` environment.
- Preserved the dependency model, authority matrix, implementation sequence, engineering contracts, full Product X composition, failure handling, and evaluation.

## Content-preservation statement

No chapter, substantive section, mechanism, worked example, engineering contract, test strategy, distinct warning, review question, or practical exercise was intentionally deleted. Where two explanations served different purposes (for example, conceptual explanation, authority rule, and applied trace), they remain separate. The edits target repeated packaging or repeated setup only.

## Change counts

- Modified: 10 chapter source files.
- Added: 3 documentation files (including this changelog).
- Deleted: none.
- Unchanged repository files: not included in this change-only archive.

## Build status

This is a source change package. No new PDF is included. The user asked that no post-delivery checks be run after the ZIP is assembled; accordingly, this delivery is not accompanied by a new build or post-package validation claim.
