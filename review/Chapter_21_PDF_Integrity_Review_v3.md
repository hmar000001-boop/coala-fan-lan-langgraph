# Chapter 21 PDF integrity review — v3 (accepted frozen application baseline)

**Date:** 25 November 2026  
**Status:** Final revised source PDF rendered and visually inspected.  
**Chapter source:** `Tex/part3/chapter21/chapter.tex`  
**PDF:** `/mnt/data/Chapter_21_Final.pdf` (separate delivery artifact)  
**Chapter 20 comparison:** `Chapter_20_Reviewed.pdf` (23 pages; reviewed source PDF)

## Final PDF properties

| Property | Chapter 20 | Chapter 21 final | Assessment |
|---|---:|---:|---|
| Pages | 23 | 31 | Content-driven difference; no page-count equality expected |
| Page size | 612 × 792 pt (US Letter) | 612 × 792 pt (US Letter) | Match |
| Main serif family | Liberation Serif | Liberation Serif | Match |
| Main sans family | Liberation Sans | Liberation Sans | Match |
| Monospace family | Liberation Mono | Liberation Mono | Match |
| Text extraction | Searchable | Searchable | Pass |

**Chapter 21 PDF SHA-256:** `2a12cc06774f57d561c0d3fae1fe0b9fd4d9e13d24e3c83b8f118c527a647bc3`

## Content and layout inspection

- All 31 pages were rendered to PNG and visually reviewed in four contact sheets; detailed inspection included the B1 scoring/listing pages, the B3 coalition search pages, broadcast/outcome evidence, the S/C/T/P/L/R table, recap, exercise, closing transition and references.
- The closing transition to Chapter 22 now fits on page 30 with the source note. References occupy page 31; the earlier sparse standalone transition page is gone.
- The B1 provider-utility correction, unchanged maintenance calculation and unchanged B3 complete-combination budget are described consistently in the source, approved outline, source review and recap.
- No clipped text, visible overlap, broken glyph, unresolved cross-reference, or missing citation was found. The final LaTeX log has no `Overfull \\hbox`, undefined-reference/citation, or LaTeX-error warnings. Some underfull-box warnings occur around long Java identifiers and narrow table cells; visual inspection found no clipping or loss of content.
- The canonical preamble hash matches the untouched repository baseline. No canonical book font configuration was edited.

## Build qualifications

The local proof used a temporary copy of the preamble with Liberation Serif/Sans/Mono substitutions because the configured TeX Gyre font files were not available in this environment. The temporary proof preamble and standalone entry are not part of the delivered repository overlay; `Tex/preamble.tex` remains byte-identical to the original book baseline.

The six Chapter 21 `.mmd` sources were unchanged during this reconciliation. The local proof used the corresponding preview PNGs retained from the previous proof; the pinned Mermaid CLI 12.2.0 was not installed or run in this environment. The authoritative Mermaid sources and figure references are included in the LaTeX changeset. `scripts/check-diagrams.sh --sources-only` passed for 113 Mermaid sources, accessible descriptions, sequence syntax guard and all Chapter 1–21 figure references. The canonical diagram render and configured full-book build remain CI checks.

This is a validated local PDF proof of the revised Chapter 21 source, not a claim that the canonical TeX Gyre/Mermaid CI build has run.
