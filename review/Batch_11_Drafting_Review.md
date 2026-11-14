# Chapter 11 — Drafting and quality review

**Chapter:** From Historical Cognitive Architectures to Modern Agents  
**Outline:** v1.0, approved by the author on 14 November 2026  
**Primary source:** Fan and Lan (2026), arXiv:2607.23942v1  
**Corpus snapshot:** frozen 26 July 2026

## Final outline review

The approved outline was checked one final time against the original arXiv HTML. No substantive scope change was required. The chapter preserves the intended progression: comparison problem; corpus layers; ten historical architecture families; eight general runtime families; forty-two mechanism-focused records; four explicit bridges; E1–E4; D0–D4; worked evidence packets; migration landscape; validity boundaries; recap and handoff.

## Draft contents

The chapter is written in `Tex/part2/chapter11/chapter.tex`. It covers:

- Corpus H (10), M-A (8), M-B (42), and separately recorded Corpus B explicit bridges.
- All ten historical architecture families: ACT-R, Soar, CLARION, LIDA, Hearsay-II/blackboard, BDI, MIDCA, ICARUS, EPIC, Sigma.
- All eight general runtime families: Letta/MemGPT, LangGraph, AutoGen, AgentScope, OpenHands, Microsoft Agent Framework, OpenAI Agents SDK, AIOS.
- All forty-two mechanism-focused records grouped by the paper's mechanism areas.
- Four explicit bridge cases: CoALA, LLM-ACTR, Bootstrapping Cognitive Agents, hybrid BDI–LLM.
- Exact E1–E4 and D0–D4 criteria, precedence, independence, and mechanism-specific scope.
- Three worked mappings: Hearsay-II/message-oriented runtimes (E4/D2), hybrid BDI–LLM (E1/D3), and SCALAR (E2/D4 for its mapped mechanism).
- The migration ledger's ten-family summary and the bounded-review validity disclosures.

## Source-fidelity checks

1. The paper's corpus freeze date is stated as 26 July 2026.
2. The three principal corpus strata and separately recorded bridge roles are distinguished; no disjoint-population sum is asserted.
3. AIOS and hybrid BDI–LLM cross-indexing is explained.
4. Magentic-One and Agent Spec remain supporting cases, not additions to the eight general runtime families.
5. E-codes are categorical evidence relationships, not a maturity scale; exactly one E-code applies to a specific correspondence.
6. D-codes apply to the mapped mechanism, not an architecture or product. D4 requires outcome-dependent change to future policy; logging alone is insufficient.
7. The highest admitted D-level is not prevalence or a universal maximum.
8. The paper's single-coder provisional status, absent independent recoding, absence of a search-recall estimate, lack of PRISMA completeness, and lack of causal or residual-bundle experiments are stated.
9. B5 is described as closed within the frozen corpus by GraSP, not as an eternal universal absence claim.
10. Chapters 12–17 receive only a preview; their mechanism analyses are not duplicated.

## Mermaid figures

Six `.mmd` sources are located in `Tex/diagrams/source/part2/chapter11/`:

1. `corpus-strata-and-bridges.mmd`
2. `historical-architecture-families.mmd`
3. `general-runtime-families.mmd`
4. `evidence-relation-codes.mmd`
5. `migration-depth-levels.mmd`
6. `evidence-packet-and-independent-codes.mmd`

All include `accTitle` and `accDescr`, use the shared Mermaid theme, and are included through `\\BookDiagram`. No TikZ, ASCII diagrams, or chapter-specific diagram library is used.

## Validation and limitations

- Chapter prose, citations, labels, glossary references, and six diagram references checked. Added the missing `historicalarchitecture` glossary definition after the first LaTeX pass identified it.
- Shell syntax, Mermaid source syntax heuristics, workflow YAML, JSON configuration, scaffold checks, and diagram source/reference mapping checked.
- A disposable standalone XeLaTeX layout test produced a 43-page PDF at 7 × 10 inches and included bibliography, glossary, and index. `pdftotext` found the expected chapter title and section headings. Pages were rendered at 120 dpi; the historical-family table, migration ledger, warning box, recap, glossary, references, and index were visually inspected.
- The local layout test used conspicuously marked PNG placeholders and temporary Nimbus font substitutions only. This tests chapter inclusion, captions, labels, float placement, page flow, and typography; it does not validate the real Mermaid renders or the user-specified TeX Gyre font appearance. The placeholders and test PDF are excluded from the repository. The original preamble SHA-256 was restored and verified.
- The real Mermaid CLI could not be installed locally because `registry.npmjs.org` did not resolve. No placeholder PNGs or test PDFs are included in the deliverable. Real PNG generation, rendered figure inspection, and final individual PDF production remain a GitHub Actions gate. The direct Mermaid CLI version is pinned to 12.2.0, but the npm dependency lockfile remains outstanding until registry access is available.
- `Tex/preamble.tex` was restored and its SHA-256 compared with the base repository before packaging.

## Status

Chapter 11 source draft integrated. Standalone LaTeX layout validation passed at 43 pages. The final illustrated chapter PDF is pending the first successful real Mermaid CI rendering and visual inspection.


### Standalone LaTeX validation results

- Standalone XeLaTeX build: **PASS**, 43 pages, 7 × 10 inch page size.
- Bibliography: Biber output present; references included.
- Glossary and index: generated and included. The first pass exposed an undefined `historicalarchitecture` glossary entry; the definition was added and the complete standalone build rerun successfully.
- Text extraction: expected title and section headings 11.1–11.13 present.
- Visual inspection: all pages rendered at 120 dpi. Representative pages containing the historical-family comparison table, mechanism-record grouping, migration ledger, warning box, recap, review questions, glossary, references, and index were inspected.
- ChkTeX: no chapter warnings after replacing straight quotation marks with LaTeX-style quotes.
- Layout: no overfull boxes and no undefined references/citations. Some underfull lines remain in narrow summary-table cells; these were visually inspected and remain legible. The small-caps font warning is caused by the temporary Nimbus substitute and is not evidence about the TeX Gyre production fonts.

### Combined-book smoke test boundary

XeLaTeX completed the combined-book source pass and produced a 277-page XDV. The local XDV-to-PDF conversion exceeded the execution time limit while processing the high-resolution placeholder images. No combined-book PDF pass is claimed from that attempt. The GitHub Actions build with real Mermaid PNGs remains the authoritative combined-book validation.
