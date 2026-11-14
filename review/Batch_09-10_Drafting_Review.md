# Part II — Batch 1 drafting and quality review (Chapters 9–10)

**Status:** Drafts integrated; author review pending.  
**Date:** 14 November 2026.

## Content delivered

| Chapter | Title | Approximate source word count |
|---|---|---:|
| 9 | Why Feature-Level Descriptions Are Not Enough | 4,259 |
| 10 | The Seven Fields of a Mechanism | 3,921 |

## Drafting choices

### Chapter 9

- Opens with two systems both described as having memory, then progressively explains why the label is not enough.
- Introduces the documented mechanism after the reader encounters the problem.
- Explains state, trigger, control, transition, and possible later behavioral change without prematurely teaching the complete seven-field method.
- Introduces the E1–E4 and D0–D4 axes conceptually and keeps them independent; exact coding rules are deferred to Chapter 11.
- Includes the node–edge–invariant claim test and the review's explicit validity limits.
- Does not analyze the historical architecture catalog or residual bundles.

### Chapter 10

- Teaches the exact tuple `K = <S,C,T,P,F,L,R>` in the paper's order and with the paper's field names.
- Distinguishes each field from neighboring concepts, especially state versus control, trigger versus scheduling, persistence versus learning, and failure logging versus failure semantics.
- Uses the ACT-R ledger as a worked reading without importing outside ACT-R detail.
- Explains that the fields are analytical questions, not mandatory runtime components or one fixed chronological pipeline.
- Explicitly distinguishes unknown, absent, and not-applicable evidence in editorial notes without presenting these as new Fan and Lan codes.
- Hands detailed historical-to-modern comparison and E/D coding to Chapter 11.

## Shared production conventions

- Both chapters use the shared author preamble and `Tex/shared-macros.tex`.
- Both use `\FanLanCite{...}` for source-traceable footnotes.
- Both use shared semantic boxes selectively; ordinary prose remains outside boxes.
- Eight Mermaid sources were added, four under each chapter's source directory, each with `accTitle` and `accDescr`.
- All images are included only through the shared `\BookDiagram` macro. No TikZ or ASCII diagram is introduced.
- Glossary and index terms are added to the shared glossary/index infrastructure.
- Both outline sources and their approved review PDFs remain in their corresponding chapter folders.

## Validation performed

- Static source checks and word-count review completed.
- Chapter-local outline source status updated to record approval.
- Repository scripts extended to cover Chapters 9–10.
- Shell syntax and repository scaffold checks run after integration.
- Mermaid syntax and rendered PNG checks require the pinned Mermaid CLI. The local npm registry was unreachable during this batch, so actual Mermaid rendering could not be completed locally. No mock PNG or mock diagram is represented as real output.
- Standalone LaTeX layout tests passed for Chapter 9 (22 pages) and Chapter 10 (20 pages) using conspicuously marked temporary PNG placeholders and temporary local font substitutions. The author-supplied `Tex/preamble.tex` was restored byte-for-byte and its SHA-256 verified against the base repository. These tests validate LaTeX integration only; they are not final illustrated PDFs and do not validate real Mermaid output.

## Remaining release gate

The first GitHub Actions run must install the pinned Mermaid CLI, render all chapter `.mmd` sources to PNG, pass diagram validation, compile the combined book and run PDF quality checks. The rendered-diagrams artifact must be visually inspected at printed size before Chapters 9–10 are considered final illustrated PDFs.
