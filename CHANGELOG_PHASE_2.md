# Phase 2 — Technical correctness and source fidelity

## Scope

Phase 2 makes only technical, citation, terminology, and source-fidelity corrections. It does not perform the selective editorial compression reserved for Phases 3 and 4. No files were deleted.

## Added

- `CHANGELOG_PHASE_2.md` — this change summary.
- `README_CHANGESET.md` — change-only package instructions.
- `CHANGE_MANIFEST.csv` — file-level status and SHA-256 values.

## Modified

- `Tex/bibliography/references.bib`
- `Tex/glossary/terms.tex`
- `Tex/part1/chapter02/chapter.tex`
- `Tex/part1/chapter03/chapter.tex`
- `Tex/part1/chapter04/chapter.tex`
- `Tex/part1/chapter07/chapter.tex`
- `Tex/part2/chapter11/chapter.tex`
- `Tex/part2/chapter12/chapter.tex`
- `Tex/part2/chapter15/chapter.tex`

## Deleted

- None.

## Substantive changes

1. Chapter 12: repaired the broken `\FanLanCite` invocation.
2. Chapter 12: made candidate activation and ACT-R-derived cognitive retrieval-time predictions explicit inputs to the book-level B1 estimator. Distinguished cognitive retrieval time from wall-clock infrastructure latency.
3. Chapter 12: introduced incremental query-time maintenance cost, separated it from background lifecycle costs, and clarified soft latency ranking versus the hard deadline constraint.
4. Chapter 12: added a seven-field S/C/T/P/F/L/R reconstruction of B1. The table separates what the review identifies from implementation details it does not specify; it explicitly preserves the difference between unknown, absent, and not applicable.
5. Chapter 12: clarified which modern-system comparisons are supplementary and where the frozen B1 baseline set is listed.
6. Chapter 12 and bibliography: added ACT-R manual page-specific citations for declarative memory/activation, retrieval time, and production utility.
7. Chapter 7: added the standard softmax equation and a numerical Product X example using the existing illustrative values and an expressly illustrative temperature. The resulting weights are identified as selection weights, not real-world success probabilities.
8. Chapter 11: corrected the CLARION forward reference to Chapter 15 (B4) and Chapter 17 (B5/GraSP).
9. Glossary: added explicit plurals for `candidate action` and `general runtime family`.
10. Chapters 2–4: corrected Product X's release notation to `deployment v4.7`; corrected sentence-start glossary capitalization and code formatting in Chapter 2.
11. Chapter 15: converted malformed ASCII quotation marks to proper TeX quote pairs and corrected sentence-start capitalization of `beliefs`.
12. Bibliography: corrected Fan & Lan's entry to an arXiv preprint with full author names, version, identifier, subject class, and submission date.

## Editorial protection

No chapter, section, worked example, warning, or exercise was removed. No broad compression was performed.

## Build status

This ZIP contains LaTeX source changes and change documentation only. It does not contain a newly compiled PDF. Phase 1's build acceptance is carried forward; no post-delivery checks are part of this hand-off, as requested.
