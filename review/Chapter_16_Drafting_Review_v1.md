# Chapter 16 — Drafting and implementation-bridge review

**Chapter:** Uncertainty, Resources, Interruption and Stopping: B6  
**Part II batch:** 7 of the author's nine-batch plan  
**Source:** `Tex/part2/chapter16/chapter.tex`

## Plan conformance

- This is a standalone B6 mechanism chapter, not paired with B5 or the final synthesis.
- Chapter 17 remains the B5/GraSP closed-candidate study.
- Chapter 18 remains reserved for synthesis after Chapters 9–17 are complete and reviewed.
- The single active outline remains Markdown-only at `Tex/part2/chapter16/outline/Chapter_16_Outline_v1.md`; no review PDF, outline LaTeX wrapper, or generated alternate outline was added.

## Theory-to-implementation bridge

The bridge is substantial because B6's claim is a control relationship. The chapter includes:

1. A source-grounded reconstruction of EPIC timing/contention and Sigma shared uncertainty-bearing representation.
2. Closest modern resource and uncertainty/action baselines, with individual contribution and boundary.
3. An uncertainty-lineage record tied to a defined target, evidence, model, calibrator, freshness and revision.
4. A typed multi-resource vector with reservations, deadlines and non-fungible units.
5. Separate scheduling and action-authorization decisions.
6. Explicit semantics for scheduling, preemption, interruption, cancellation, suspension, resumption and stopping.
7. Java-like data contracts, state transitions, concurrency and persistence invariants.
8. A Product X incident walkthrough, vertical implementation sequence, measurable outcomes, three distinct ablations and falsification criteria.

The chapter labels these as engineering proposals rather than source-prescribed implementation details.

## Diagram plan

Nine Mermaid sources are committed under `Tex/diagrams/source/part2/chapter16/` and each is referenced from the chapter: EPIC resource bottlenecks; Sigma uncertainty propagation; modern baseline map; cross-stage control loop; resource-vector scheduler; authorization and interruption; lifecycle state machine; Product X incident sequence; evaluation and ablation. Each source contains `accTitle` and `accDescr`. PNG generation is delegated to the pinned Mermaid CLI in CI.

## Validation performed locally

- `bash -n scripts/*.sh`: passed.
- `bash scripts/check-scaffold.sh`: passed; the repository recognizes the authored Chapter 16 source and the single Markdown outline.
- `bash scripts/check-diagrams.sh --sources-only`: passed for all 77 Mermaid sources, accessible metadata, the sequence-diagram semicolon guard, and Chapter 1–16 figure references.
- XeLaTeX standalone layout build: completed at 61 pages using temporary Noto Serif/Noto Sans/DejaVu Sans Mono substitutes because the production TeX Gyre OpenType fonts are unavailable locally.
- Biber 2.20, `makeglossaries`, and `makeindex`: completed. The final XeLaTeX pass contains no unresolved citation/reference warnings, bibliography-empty warning, overfull box, or PDF-string warning.
- Representative pages were rendered and visually inspected for headings, tables, code listings, footnotes, references, glossary and index. Temporary watermarked panels marked `NOT A MERMAID RENDER` were used only for layout inspection, then removed; they are not committed or delivered.
- `Tex/preamble.tex` was restored byte-for-byte; SHA-256 matches the pre-build copy.

## Open validation items

- Run pinned Mermaid CLI 12.2.0 across all diagrams. Local npm registry resolution was unavailable; the normal `scripts/check-diagrams.sh` therefore cannot pass until real PNGs are rendered.
- Confirm real Mermaid output, PNG integrity, printed-size diagram legibility, and production TeX Gyre font build in GitHub Actions.
- Run the complete repository build, PDF text quality checks, and reproducible-build checks on the GitHub runner. No final illustrated PDF is claimed in this package.

## Drafting review outcome

The chapter is fully drafted in LaTeX and integrated into the repository build path. This file records editorial and engineering-review scope; it does not claim that outstanding CI or visual checks have passed.
