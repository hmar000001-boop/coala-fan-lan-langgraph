# Batch 9 — Chapter 18 authoring status

**Date:** 15 November 2026  
**Chapter:** How the Mechanisms Work Together  
**Status:** LaTeX manuscript drafted and integrated.

## Authorization and review

The author approved Outline v1.0 and instructed one minor-issues review pass followed immediately by drafting. The review confirmed the outline's source anchors and scope. It retained two small clarifications: local component limits are not conflated with the runtime-wide resource ledger, and the four-plane organization is explicitly a book-level explanatory view rather than a source-defined architecture.

The single canonical Markdown outline is stored at `Tex/part2/chapter18/outline/Chapter_18_Outline_v1.md`. No outline PDF or LaTeX wrapper/body was created.

## Integrated source

- Chapter source: `Tex/part2/chapter18/chapter.tex`
- Standalone build: `Tex/standalone/chapter18.tex`
- Part II input: already present in `Tex/part2/content.tex`
- Source review: `review/Chapter_18_Source_Review_v1.md`
- Drafting review: `review/Chapter_18_Drafting_Review_v1.md`
- Nine Mermaid sources: `Tex/diagrams/source/part2/chapter18/`

## Key synthesis content

The chapter covers the shared state tuple and distinct proposal/governor/transition/learning operations; the separate authority of B1, B2, B3, B4, B6, GraSP, and the coordinator; the five Figure 8 dependencies; the source implementation order; the bounded synthesis runtime; Java-like composition contracts; persistence/concurrency and interruption/resume; the Product X example; composition failure modes; the source-prescribed ablations and compositional experiments; and scientific limits.

B5 remains closed by GraSP as an E3/D4 convergence case within the bounded review corpus. The manuscript assigns no aggregate E/D code to the composite runtime and does not claim that the full composition is empirically validated.

## Validation status — local results

- Repository scaffold: passed. The scaffold recognizes all 18 drafted chapters and the Markdown-only outline convention for Chapters 16–18.
- Shell syntax: passed for every repository shell script.
- Mermaid source validation: `scripts/check-diagrams.sh --sources-only` passed for all 95 sources, accessible descriptions, the sequence syntax guard, and every Chapter 1–18 figure reference. The real renderer is unavailable locally; no successful PNG rendering is claimed.
- XeLaTeX/Biber: standalone layout compilation completed with temporary Noto OpenType substitutes; 57-page PDF. No unresolved citations/references, LaTeX errors, hyperref warnings, overfull boxes, or oversized floats in the final log.
- Glossary/index: nine glossary entries generated; MakeIndex generated 20 index entries without errors.
- PDF text and visual review: text extraction passed; contact sheet and representative pages inspected, including the multi-page authority matrix, code listing, Product X tables, glossary, references, and index.
- Temporary Mermaid placeholder panels were clearly marked `NOT A MERMAID RENDER` and removed from the project before ZIP creation.
- Shared preamble: restored byte-for-byte; SHA-256 `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`.
- Remaining GitHub Actions gates: actual Mermaid CLI 12.2.0 rendering, generated PNG integrity/dimensions, diagram inspection at printed size, and production TeX Gyre OpenType font compilation. The local PDF is a layout preview, not a final illustrated publication PDF.
