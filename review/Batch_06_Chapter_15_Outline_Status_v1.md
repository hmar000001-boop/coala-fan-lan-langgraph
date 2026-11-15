# Batch 6 — Chapter 15 outline status v1

**Chapter:** 15 — Persistent Intentions, Reconsideration and Method Authority: B4  
**Batch:** 6 of 9  
**Outline:** v1.0, proposed and awaiting individual author approval  
**Chapter prose:** Not started; `chapter.tex` remains a placeholder  
**Theory-to-practice audit:** Completed; substantial implementation bridge required and specified in the outline.

## Prepared artifacts

- Chapter-local editable Markdown outline.
- Chapter-local generated LaTeX body.
- Chapter-local LaTeX review wrapper.
- Chapter-local review PDF (47 pages; compiled and visually inspected).
- Source-fidelity review.
- This status checkpoint.

## Main source distinctions preserved

- BDI commitment and MIDCA live meta-control are distinct historical contributions.
- Blind/single-minded/open-minded commitment policies are distinct from bold/cautious reconsideration schedules.
- E1-E4 evidence relation and D0-D4 migration depth remain independent.
- The reviewed modern systems provide partial baselines, not a completed B4 implementation.
- The practical reference subsystem is a book-level engineering proposal, not an implementation claimed by Fan and Lan.

## Build and visual review checkpoint

- The outline body was regenerated from the Markdown source after shortening a long source-folder path that caused one overfull line.
- XeLaTeX and Biber completed; no overfull boxes, undefined citations, or undefined references remain in the review log.
- Cover, contents, implementation-contract pages, Product X example, and references were visually inspected.
- The local review PDF uses temporary installed Noto OpenType fonts because the required TeX Gyre OpenType fonts are unavailable in this environment. The shared preamble was restored unchanged; GitHub Actions remains the authoritative font build.
- `scripts/build-outlines.sh` and `scripts/check-scaffold.sh` now include Chapter 15's outline artifacts. Chapter 15 remains excluded from authored-chapter build loops until prose is drafted after approval.

## Approval gate

Wait for explicit approval of Chapter 15 Outline v1.0 before writing chapter prose. Do not interpret approval of Chapters 12–14 or a generic request to continue as approval of this outline.

## After approval

Draft the chapter, add seven accessible Mermaid sources, add only necessary glossary/index entries, expand the Chapter 15 source and build checks, compile the individual chapter PDF, visually inspect diagram and page renders, run repository quality checks, and preserve a new checkpoint before packaging.
