# Review findings — disposition and correction record

Classifications below refer to the review's assertion, not whether the topic is generally important.

## New findings

| Finding | Classification | Disposition |
|---|---|---|
| 1. Chapter 15 lifecycle is incomplete | **Partial** | The reviewer is right that the prose transition inventory omitted resume and delegated-return transitions, but both transitions already existed in the original Mermaid diagram. The prose, state record, guards, return conditions, and tests are now aligned. A `PROPOSED -> REJECTED` terminal path has also been added. |
| 2. Listing 15.6 checks versions before replay | **Correct** | The orchestration now checks event ID and canonical request digest first. The repository must repeat the same check atomically with version/state/outbox updates, preventing a duplicate delivery from failing as stale and preventing concurrent duplicate application. Same ID/different digest is rejected. |
| 3. Listing 15.6 authorization bypass for DELEGATE | **Correct** | Both `SWITCH_METHOD` and `DELEGATE` now pass compatibility and authorization checks. Delegation additionally checks that the child's method/capabilities remain within the parent's authority ceiling. Current-method revalidation is required for continue/resume. `MethodRegistry.assess` is now used. |
| 4. Listing 14.4 no-admission path | **Correct** | The no-admission branch no longer calls snapshot expiry. It produces a typed `NoAdmissionResult`, records the cycle outcome through the ledger, and cannot enter snapshot-only `closeEpisode`. Only `BroadcastResult` carries a snapshot and is accepted by `closeEpisode`. |
| 5. Listing 14.4 naming/interface drift | **Partial** | `PolicyFeedbackQueue` is distinct from `PolicyLearner`: the former enqueues/drains validated feedback; the latter creates a candidate policy from a batch. Workspace ledger, admission registry, and consumer coordinator interfaces are explicit. The two responsibilities were not collapsed into one misleading name. |
| 6. 52 undefined types; listings do not compile standalone | **Partial** | Core types affecting the lifecycle/workspace contracts are now explicit, including `Condition`, `CycleContext`, `TaskOutcome`, `ValidationResult`, `EvidenceRecord`, `VerificationRule`, `Precondition`, and `AuthorizationResult`. The demand that every listing compile standalone is not applicable: the book uses intentionally illustrative contract fragments, SQL schemas, and method bodies. Chapters 13–18 now say this explicitly and identify omitted imports/adapters/value-object implementations. Full application compilation belongs to Part III. |

## Previously open / carry-over items

| Item | Classification | Disposition |
|---|---|---|
| H4 — supplementary systems confused with Fan & Lan's B1 baseline | **Error (stale status)** | Already corrected in the accepted Phase 2 source: Chapter 12 explicitly labels supplementary technical comparators and separately identifies the baseline set. No new edit required. |
| H6 — uneven inline source labels | **Partial** | Source notes are now standardized with paper section/appendix locators in Chapters 10 and 16–18; Chapters 13–15 already provide source-boundary notes and inline citations. This improves traceability but is not a forensic verification of every bibliography entry. |
| M2 — CoALA §4.6 citation ambiguity | **Error** | The source macros explicitly identify the cited paper's sections; the alleged ambiguity with the book's §4.6 is not present. No change required. |
| M5 — blanket 20–25% reduction | **Partial** | The original estimate was unsupported as a universal target. The accepted Phases 3–4 already applied selective compression; this package does not add a new word-count quota. |
| M8 — Part II length | **Partial** | The length concern is subjective. Mechanism explanations, contracts, state machines, worked traces, and evaluation bridges are substantive; prior phases removed repetition without cutting those contributions. |
| M6 — Java listings are not standalone programs | **Partial** | The criticism is valid only as a labelling/completeness concern. Chapters 13–18 now mark the snippets as illustrative fragments and identify intentional omissions. Standalone application compilation is reserved for Part III. |
| L3 — prose “Fan and Lan” versus label “[Fan & Lan]” | **Error** | These are stylistic variants, not conflicting source identities. No change required. |
| L4 — Bothell manual page locators | **Partial / addressed** | The ACT-R reference entry and Chapter 12 citations now identify the relevant declarative-memory and utility page ranges. Rendered PDF presentation still depends on the next build. |
| Dedication | **Correct (coverage gap)** | The only dedication file was an unfilled placeholder (“Dedication to be supplied”). It has been removed from the document inputs and deleted; no author content was removed. |
| Appendix A | **Correct (coverage gap)** | The book appendix page now states that technical appendices are not populated yet and distinguishes them from Fan & Lan's external Appendix A. |
| Index | **Correct (coverage gap)** | The source index directives were scanned: 180 directives, no empty/unbalanced arguments. No source change was necessary. |
| Chapter 16 UALA / KnowNo characterization | **Correct** | Their roles remain bounded: UALA is uncertainty-aware tool interaction; KnowNo is conformal-prediction-based help seeking. Neither is presented as the full B6 coupling. Existing primary-paper citations remain adjacent to the claims. |
| E/D code consistency | **Correct (with a clarity improvement)** | The repeated codes were reported as consistent. Chapter 11 now states the case-specific pairs explicitly and cautions against reading them as whole-system maturity scores. |

## Remaining scope limitation

This package corrects the source issues identified in the report and addresses the listed coverage gaps. It does not claim an exhaustive independent re-review of every paper, every bibliography field, or the final rendered PDF. A full XeLaTeX/Biber build and visual inspection remain necessary after the changes are applied. The 21-listing review's syntax result is acknowledged, but these fragments are intentionally not one standalone Java compilation unit.
