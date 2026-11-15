# Batch 8 — Chapter 17 authoring status

**Date:** 15 November 2026  
**Batch:** 8 of the approved nine-batch Part II plan  
**Chapter:** 17 — The Closed Candidate B5 and GraSP  
**Outline:** v1.0 approved; one minor-issue review pass completed  
**Drafting status:** LaTeX manuscript integrated; local source checks and substitute-font layout preview completed. Real diagram rendering and production-font CI remain open gates.

## Checkpoint

- Complete source repository resumed from the Chapter 16 Batch 7 archive.
- Approved outline preserved as one Markdown file only.
- Chapter prose integrated at `Tex/part2/chapter17/chapter.tex`.
- Standalone entry point added at `Tex/standalone/chapter17.tex`.
- Nine Mermaid source diagrams added under `Tex/diagrams/source/part2/chapter17/`.
- GraSP and ICARUS bibliography entries added.
- Chapter glossary vocabulary added and linked to first-use occurrences.
- Source-fidelity and drafting-review records added.
- Build script, diagram checker, scaffold checker, and PDF quality heading validation extended to Chapter 17.
- README updated; Chapter 18 remains a placeholder.

## Source boundary

B5 remains a closed candidate, not a sixth residual bundle. GraSP's architecture and experiments are attributed to Xia et al.; the B5 closure and E3/D4 mapping are attributed to Fan & Lan. The Java-oriented types, persistence/concurrency hardening, test interfaces, and vertical-slice plan are book-level engineering reconstructions and do not claim to reproduce GraSP's implementation or results.

## Validation completed locally

- `bash scripts/check-scaffold.sh` passed: Chapters 1–17 are recognized as drafted, Chapters 16–17 retain their single canonical Markdown-only outlines, and Chapter 17's nine sources are found.
- `bash scripts/check-diagrams.sh --sources-only` passed for 86 Mermaid sources and all Chapter 1–17 figure references.
- `bash -n` passed for the four modified build/check scripts.
- The approximately 13,300-word chapter was composed as a 63-page standalone layout preview through `latexmk`/XeLaTeX using a temporary preview wrapper and Noto OpenType substitutes. This is not the production `chapter17.tex` build: the local TeX Gyre OpenType variants and real Mermaid PNGs are unavailable.
- Biber processed three cited records; glossary generation accepted 13 entries; MakeIndex accepted 26 entries. The final preview log contains no undefined citations/references, no LaTeX error, no emergency stop, and no horizontal overfull boxes. Four low-severity underfull-box warnings remain.
- PDF text extraction and representative-page visual inspection completed. The preview uses nine explicitly labelled temporary panels, not actual Mermaid renders.
- The shared `Tex/preamble.tex` was restored byte-for-byte; SHA-256 remains `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`.

## Remaining validation gates

The pinned Mermaid CLI 12.2.0 could not be run locally because it is unavailable and npm DNS access failed. The nine temporary panels were removed from the source archive; the `.mmd` sources are authoritative. GitHub Actions must render the actual PNGs and perform the production-font build. The supplied PDF is a layout preview, not a final illustrated production PDF. The ZIP contains only editable Mermaid source, not temporary PNGs or local compilation artifacts.

## Next position

Chapter 17 is the Batch 8 completion target. Chapter 18 must not begin until Chapters 9–17 are complete and reviewed; it remains the Batch 9 synthesis chapter.
