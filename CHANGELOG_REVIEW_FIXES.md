# Review report fixes — change log

## Scope

This change set applies the confirmed technical and documentation corrections from the latest review of the 21 Java/SQL listings and the Chapter 15 lifecycle. It preserves the previously accepted Phase 2–5 changes. It does not include the baseline repository, unchanged files, or a newly compiled PDF.

## Modified files

### `Tex/part2/chapter15/chapter.tex`
- Reconciled the lifecycle prose with transitions that were already present in the Mermaid diagram: `SUSPENDED -> ACTIVE` and `DELEGATED -> RECONSIDERATION_PENDING`.
- Added a distinct `REJECTED` terminal state for a proposal rejected before authorization, with a separate proposal-authority operation and durable rejection reason/evidence.
- Made the stored resume target explicit (`ACTIVE` or `RECONSIDERATION_PENDING`) and added suspension/delegation metadata and state invariants to the intention record.
- Specified child-result handling for success, failure, timeout, and cancellation; stale or out-of-scope child results are not integrated.
- Fixed idempotency semantics: a fast replay lookup checks event ID and request digest before version validation; the repository repeats the check transactionally with the version/state/outbox update. Same ID with a different digest is a conflict.
- Applied method-compatibility and authorization checks to both method switching and delegation; added a parent-capability ceiling check for delegated methods. Revalidation is also required when continuing or resuming the current method.
- Defined core evidence, rule, precondition, effect, capability, risk, reversibility, method-compatibility, authorization-result, and transition-result contracts used by the examples.
- Expanded lifecycle, replay, proposal rejection, delegated-result, and authorization test scenarios.

### `Tex/diagrams/source/part2/chapter15/b4-intention-lifecycle.mmd`
- Added `PROPOSED -> REJECTED`.
- Clarified child success/failure/timeout/cancellation return to reconsideration after parent scope/version validation.
- Clarified suspended resumption to either active or reconsideration after the stored condition and permissions are revalidated.
- Updated the diagram accessibility description and styling for the rejection terminal state. The repository workflow regenerates the derived PNG from this source.

### `Tex/part2/chapter14/chapter.tex`
- Replaced the ambiguous generic result path with `NoAdmissionResult` and `BroadcastResult` as distinct result types.
- Removed snapshot expiry from the no-admission path; it now durably records the no-admission decision without opening or expiring a nonexistent workspace snapshot.
- Restricted `closeEpisode` to `BroadcastResult`, which carries the snapshot needed for attribution and expiry.
- Added explicit interfaces for the workspace ledger, active admission-policy registry, consumer coordinator, and policy feedback queue.
- Clarified that validated feedback is queued, later drained in bounded batches, and passed to an offline/controlled `PolicyLearner.update`; the active policy is not trained or promoted during a workspace cycle.
- Added tests for no-admission, broadcast-only episode closure, snapshot expiry, and feedback-batch handling.
- Marked the listings as illustrative contract fragments, not a standalone compilation unit; essential cycle support types are declared explicitly.

### `Tex/part2/chapter11/chapter.tex`
- Made the case-specific E/D mappings explicit for the named Soar-, LIDA-, BDI-, and ICARUS-related modern correspondences, rather than allowing a family row to look like a single architecture-wide rating.
- Clarified that codes describe individual mechanism correspondences, not whole-system maturity.

### `Tex/part2/chapter10/chapter.tex`, `chapter16/chapter.tex`, `chapter17/chapter.tex`, `chapter18/chapter.tex`
- Added precise Fan & Lan section/appendix locators to chapter source notes. Chapter 17 also retains the primary GraSP citation.
- Made the illustrative Java-like fragments / contracts / pseudocode distinction explicit in Chapters 16–18. Chapter 17 now defines the `Condition` value type used in the skill schema.

### `Tex/part2/chapter13/chapter.tex`
- Clarified that Java listings are proposed contract fragments and method bodies, not one standalone application; stated which implementation details are intentionally elided and where full application wiring is delivered.

### `Tex/part0/content.tex` and `Tex/part0/frontmatter/dedication.tex`
- Removed the empty “Dedication to be supplied” placeholder from the front-matter input sequence and deleted the unused placeholder file. No author-written dedication content was removed.

### `Tex/appendices/content.tex`
- Clarified that this draft has no populated technical appendices yet, that their contents will be determined by the approved Part III engineering work, and that chapter references to Fan & Lan Appendix A refer to the external paper.

## Validation performed before packaging
- Mermaid source validation passed for 95 sources, accessible descriptions, sequence syntax guard, and all Chapter 1–18 figure references.
- LaTeX environment begin/end counts were balanced in all modified `.tex` files.
- The index source scan found 180 `\index{...}` directives and no empty or unbalanced arguments.
- No literal tab characters were found in the modified chapter sources.

No full XeLaTeX/Biber PDF rebuild or standalone Java compilation of the illustrative fragments is claimed. The listings are intentionally not a single compilable application; Part III is the planned complete Java implementation.
