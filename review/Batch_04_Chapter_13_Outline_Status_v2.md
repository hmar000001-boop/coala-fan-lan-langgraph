# Batch 4 — Chapter 13 (B2) Status v2

**Date:** 14 November 2026  
**Status:** Outline v2 revised; full LaTeX chapter drafted; local layout proof compiled and visually inspected. Real Mermaid rendering remains a CI gate.

## Author instruction

The author asked whether the outline had a sufficient bridge from theory to implementation, emphasized that practical implementation bridges should be present across bundles whenever possible, and instructed that drafting proceed after the outline was revised or confirmed. No second outline-approval pause was required.

## Outline v2 changes

The original outline explained Soar and Fan & Lan's B2 residual hypothesis, and included a Product X example, but its practical bridge was too high-level compared with the B1 chapter. Outline v2 therefore makes an implementable reference design a required main-body section. It specifies:

- component responsibilities and authority boundaries for adapter, classifier, parent-state store, recovery governor, child runner, result validator, parent committer, ledger, compiler and rule registry;
- typed contracts for raw execution failures, classified findings, parent snapshots, recovery scopes, typed resolutions and rule candidates;
- a guarded runtime state machine, including commit, escalation, abort, elimination and regeneration;
- append-only persistence, parent versioning, compare-and-swap, dependency invalidation, concurrent child handling, event idempotency and external-side-effect accounting;
- validation rules, rule quarantine/shadow/promotion/disablement/rollback, a vertical-slice implementation sequence, reference pseudocode and boundary tests.

These are explicitly presented as book-level engineering synthesis, not native Soar objects or an implementation supplied by Fan & Lan.

## Completed Chapter 13 artifacts

- `Tex/part2/chapter13/outline/Chapter_13_Outline_v2.md` — revised detailed outline.
- `Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v2.tex` and `Chapter_13_Outline_v2_body.tex` — editable LaTeX outline artifacts.
- `Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v2.pdf` — 39-page review PDF; cover and implementation-bridge pages visually inspected.
- `Tex/part2/chapter13/chapter.tex` — complete chapter prose source.
- `Tex/standalone/chapter13.tex` — independent XeLaTeX entry point.
- `Tex/diagrams/source/part2/chapter13/` — five accessible Mermaid source diagrams with `accTitle` and `accDescr`.
- `review/Chapter_13_Source_Review_v2.md` and `review/Chapter_13_Drafting_Review_v1.md` — source-fidelity and drafting/implementation-bridge records.
- `Tex/Output/Chapter_13_LAYOUT_PREVIEW_NOT_FINAL.pdf` — 43-page layout proof with visible temporary diagram placeholders. It is not the final illustrated PDF.

## Implementation bridge covered in the chapter

The chapter includes Soar's four native operator-selection impasse categories; substate/superstate and Goal Dependency Set semantics; result handling and chunking timing; Fan & Lan's four B2 invariants and partial modern baselines; the proposed runtime component architecture and contracts; state transitions; persistence/concurrency; side-effect and idempotency boundaries; typed resolution validation; dependency-aware compilation and rule governance; Product X's payment-timeout example; and evaluation metrics, ablations, falsifiers and implementation tests.

## Verification

- `bash scripts/check-scaffold.sh` passes.
- The 39-page outline review PDF was compiled and rendered for inspection.
- The 43-page chapter layout proof was compiled with XeLaTeX/Biber/glossary/index and rendered. Representative pages covering Soar tables, the typed-contract table, state-transition table, reference architecture placement, Product X, glossary, references and index were inspected. Table labels and a float that interrupted a multi-page listing were corrected during visual review.
- The shared `Tex/preamble.tex` remains byte-for-byte unchanged (SHA-256: `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`).
- The chapter includes shared glossary entries and 25 index entries. Intentional blank verso pages before references and index follow the double-sided `openright` book layout.
- Five Mermaid source files and their accessibility metadata/figure references pass the source-level checks. The local npm registry is unavailable and the pinned Mermaid CLI is not installed; real PNG generation, diagram dimension validation and printed-size inspection must therefore be completed by the first GitHub Actions build. No placeholder image is represented as a real diagram.
- The local PDF uses temporary Nimbus OpenType substitutes because the TeX Gyre OpenType files are unavailable in this local environment; the repository preamble is unchanged and CI installs the intended fonts.

## Next gate

Run the repository's GitHub Actions workflow. Inspect all five actual Mermaid PNGs at print size, build the final combined book and standalone Chapter 13 PDF using CI fonts, and resolve any remaining figure or PDF quality failures. Chapter 13 prose is drafted; it should not be treated as release-final until that gate passes.
