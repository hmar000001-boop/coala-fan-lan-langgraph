> **Superseded:** this PDF proof predates the final source reconciliation of Chapter 21. Use `Chapter_21_PDF_Integrity_Review_v3.md` and its hash for the final LaTeX-only delivery.

# Chapter 21 PDF integrity review — final deep-review build

**Date:** 25 November 2026  
**Chapter 20 comparison source:** accepted reviewed `Chapter_20.pdf`  
**Chapter 21 source:** revised `Tex/part3/chapter21/chapter.tex` after B1/B3 deep review

## Results

| Property | Chapter 20 | Chapter 21 final | Assessment |
|---|---:|---:|---|
| Pages | 23 | 31 | Longer because the Chapter 21 scope is B1+B3 implementation and evidence lifecycle |
| Page size | 612 × 792 pt (US Letter) | 612 × 792 pt (US Letter) | Match |
| Main sans family | Liberation Sans | Liberation Sans | Match |
| Main serif family | Liberation Serif | Liberation Serif | Match |
| Main monospace family | Liberation Mono | Liberation Mono | Match |
| Searchable text | Yes | Yes | Match |

**Chapter 21 SHA-256:** `253d18f317688b1616f0f8fc4242b0cc688da1a03d9d3e4cb62678d3b707e8cc`  
**Chapter 20 SHA-256:** `3bdd5edf01f07952932aa9b87ff7c83d0d6954ae0d81500e8e75d1d2e0afae76`

## Layout inspection

- The final 31-page Chapter 21 PDF was rendered and visually inspected in page contact sheets covering pages 1–31, with detailed checks of code listings, the scoring example, B3 competition diagrams, tables, recap and references.
- No clipped text, overlapping elements, broken glyphs, unresolved cross-references or overfull-box warnings were observed in the final LaTeX build log.
- The final reference list occupies page 31; the chapter recap and source/transition notes remain on pages 28–30.
- Chapter 20 and Chapter 21 retain the same US Letter page geometry and main font families. Page counts are intentionally different; no pixel-identical claim is made because the chapter content is different.

## Build qualifications

The local proof build used temporary system-font substitutions (Liberation Serif/Sans/Mono) because the configured TeX Gyre families were unavailable locally. The canonical preamble in the repository was not modified for this substitution. Six Chapter 21 Mermaid source diagrams were converted to temporary Graphviz previews for the local proof; the tracked `.mmd` sources and figure references remain canonical. Mermaid CLI 12.2.0 rendering and the configured canonical book build must still be confirmed in GitHub Actions.

This is a visual proof of the revised source, not a claim that the canonical font/diagram CI build has passed.
