> **Superseded:** this PDF record predates the final source reconciliation. Use `Chapter_21_PDF_Integrity_Review_v3.md`.

# Chapter 21 PDF integrity and visual comparison — v1

**Date:** 25 November 2026  
**Chapter PDF:** `Chapter_21.pdf` (delivered separately from the changes-only source ZIP)  
**Chapter 20 comparison PDF:** the previously delivered `Chapter_20.pdf`  
**Purpose:** verify that the Chapter 21 proof is structurally sound and visually consistent with the immediately preceding chapter.

## Chapter 21 PDF identity

- SHA-256: `4f4b31228a6a7ec0b0133f17701a1e4c37ce1293c99bdfe890683b0d8ef87170`
- File size: 1,870,248 bytes.
- Pages: 28.
- Page size: US Letter, 612 × 792 pt (8.5 × 11 in), every page.
- PDF version: 1.5; not encrypted; no forms or JavaScript.
- Producer: `xdvipdfmx (20240305)`.
- The PDF opens through PyMuPDF and the PDF preflight tool; its text layer is searchable and `pdftotext` extracts the chapter and references.
- No placeholder title/content strings or unresolved-reference markers appear in the extracted text.

## Comparison with Chapter 20

The reference file is `Chapter_20.pdf`, SHA-256 `3bdd5edf01f07952932aa9b87ff7c83d0d6954ae0d81500e8e75d1d2e0afae76` (1,166,647 bytes).

| Property | Chapter 20 | Chapter 21 | Result |
|---|---:|---:|---|
| Pages | 23 | 28 | Chapter 21 is longer because B1 and B3 require additional implementation detail; no missing/duplicate pages were detected |
| Page size | 612 × 792 pt | 612 × 792 pt | Match |
| Producer | `xdvipdfmx (20240305)` | `xdvipdfmx (20240305)` | Match |
| Main text families in local PDFs | Liberation Serif / Sans / Mono | Liberation Serif / Sans / Mono | Match |
| Running heads, page numbers, heading hierarchy, learning-objective box, captions, and references treatment | Existing book style | Same style | Visually consistent |

Chapter 21 includes additional Computer Modern math font subsets for its displayed B1 objective; this is expected because Chapter 21 contains a formula not present in the Chapter 20 proof. Both PDFs use embedded font subsets for the text families.

## Final-render verification

- All 28 pages of the delivered Chapter 21 PDF were rendered to PNG and reviewed in contact sheets. Full-page checks included the B1/B3 comparison table, the S/C/T/P/F/L/R table, the chapter recap, the end-of-chapter transition, and the references page.
- The previous two-line orphan at the end of the chapter was removed. The complete "Looking ahead" transition now stays on page 27; references begin on page 28.
- The PDF in the delivery location and the corresponding `Tex/Output/Chapter_21.pdf` proof copy have the same page geometry and are pixel-identical on all 28 pages at a 0.5× raster comparison.
- The final LaTeX log has no compile errors, unresolved citations/references, or overfull boxes. Underfull horizontal-box notices remain, but inspection found no clipping or unreadable content. Local small-caps substitution and the standalone glossaries notice are known environment/build-context warnings.

## Known limits (do not treat this proof as the canonical book build)

- The repository's canonical preamble specifies TeX Gyre Termes, Heros, and Cursor. Those fonts were unavailable locally, so the disposable proof copy used Liberation Serif, Liberation Sans, and Liberation Mono. The monospace family now matches the substitute family embedded in the Chapter 20 proof. The canonical project preamble was not modified.
- The six diagrams in the proof are temporary Graphviz layout previews corresponding to the authored Mermaid sources. Mermaid CLI 12.2.0 was not available locally; actual parsing and rendering by the pinned Mermaid tool must still be confirmed by the configured book CI environment.
- The combined-book build and the supply-chain application's Maven/CI suite were not run for this book-only change.

## Conclusion

The Chapter 21 PDF is structurally readable, searchable, unencrypted, 28 pages long, and visually consistent with Chapter 20's page geometry and common text-font families. The delivered PDF and the build-output proof render identically across all pages. The only outstanding PDF-production gate is the canonical Mermaid render and configured book build in CI.
