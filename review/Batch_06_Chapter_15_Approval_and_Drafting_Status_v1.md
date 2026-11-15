# Batch 6 — Chapter 15 (B4) approval and drafting checkpoint v1.0

**Date:** 15 November 2026  
**Author decision:** Approved Chapter 15 Outline v1.0; instructed one minor-issue review pass and immediate drafting.  
**Chapter:** Persistent Intentions, Reconsideration and Method Authority: B4

## Repository integrity

The complete project archive `batch06-chapter15-b4-outline-project.zip` was found in the Library and materialized as the source repository. SHA-256 before extraction:

`4072cd9890cb2aa2e5a1e4859b861c0a33bfa7b98ea703837c1f8ddd05d2554c`

`unzip -t` reported no errors. The archive had one repository root, `cognitive-architectures-to-production-agents`, and contained the Chapters 1–14 sources, shared LaTeX preamble/macros, bibliography, scripts, CI workflows, Chapter 15 outline and review assets, and later chapter placeholders. The original root name is preserved in the new delivery archive.

## Approval and drafting status

- Chapter 15 Outline v1.0 is approved as of 15 November 2026.
- One source-fidelity/minor-issue pass was completed before prose drafting.
- The first substantive prose draft is integrated at `Tex/part2/chapter15/chapter.tex`.
- The earlier outline PDF is retained as the frozen v1.0 review snapshot. Its pre-approval status line is historical; this checkpoint records the subsequent author approval.
- The previous source review v1 remains preserved; v2 is the active drafting review.

## Scope preserved

The chapter keeps blind/single-minded/open-minded commitment policies separate from bold/cautious/intermediate reconsideration schedules; separates BDI commitment from MIDCA meta-control; and distinguishes goal authority, method authority, and model proposal authority. The Product X example changes method without goal substitution. All Java contracts, lifecycle details, persistence/concurrency design, external-side-effect handling, anti-oscillation controls, and evaluation mechanisms are labelled as book-level engineering proposals.

## Integrated artifacts

- `Tex/part2/chapter15/chapter.tex`
- `Tex/standalone/chapter15.tex`
- `Tex/diagrams/source/part2/chapter15/` (seven Mermaid sources)
- `Tex/glossary/terms.tex` (ten new Chapter 15 terms; no duplicate keys)
- `Tex/part2/chapter15/outline/` (approved v1.0 source and frozen review PDF)
- `review/Chapter_15_Source_Review_v2.md`
- `review/Chapter_15_Drafting_Review_v1.md`
- this checkpoint
- extended chapter/scaffold/diagram/PDF scripts and README status

## Local validation results

- `bash scripts/check-scaffold.sh` passes. All edited shell scripts pass `bash -n`.
- The seven Chapter 15 Mermaid sources each contain `accTitle` and `accDescr`, and each has exactly one matching `\BookDiagram` placement. The repository contains 68 Mermaid sources and 68 referenced figure paths across Chapters 1–15.
- A standalone XeLaTeX layout preview compiled to 61 pages at 7 × 10 inches with Biber, glossary, and index output. Biber resolved the 14 citation keys; the glossary contains 15 entries and the index 16 entries.
- The 61-page preview was rendered at 150 dpi; the full-page contact sheet and representative opening, tables, Java/SQL listings, warnings, glossary, references, and index pages were visually reviewed. Minor LaTeX and layout issues discovered in the pass were corrected.
- The preview uses temporary Noto OpenType substitutes because the TeX Gyre OpenType fonts are unavailable in this environment. Its seven figure positions contain conspicuously labelled layout-only cards; they are not actual Mermaid diagrams. The preview is therefore not a production chapter PDF.
- The temporary font substitution was restored; `Tex/preamble.tex` matches the original SHA-256 `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`. Temporary layout images were deleted from the repository.

## Remaining release gates

The pinned Mermaid CLI is version 12.2.0. Local installation timed out. GitHub Actions must perform real rendering, PNG integrity/dimension checks, printed-size figure inspection, and a production-font XeLaTeX build. No real Mermaid PNGs or final illustrated production PDF are included or claimed as validated.
