# Chapter 17 — Drafting and consistency review

**Status:** Draft integrated; source-fidelity and internal consistency pass completed.  
**Outline:** v1.0 approved 15 November 2026.  
**Chapter source:** `Tex/part2/chapter17/chapter.tex`.

## 1. Scope conformance

- Chapter 17 is Batch 8 and is written as the special methodological case for B5/GraSP.
- B5 is not described as a sixth residual bundle. Chapter 18 remains the reserved synthesis and is not drafted.
- The chapter begins with the disappearance of a candidate gap, then reconstructs its origin, the closest-baseline screen, GraSP's runtime, the E/D result, empirical results, limitations, and a faithful implementation map.
- The implementation bridge does not invent a new B5 hypothesis. It explains how to represent and test the already-published chain in a Java-oriented production system.

## 2. Source and terminology checks

- Fan & Lan's B5 closure is separated from GraSP's own empirical results.
- E3 and D4 are defined independently. E3 is not misrepresented as documented lineage; D4 is not described as complete ICARUS migration.
- Retrieval, graph compilation, and verified execution are kept distinct.
- State/data edges are treated as hard dependencies; order edges are treated as soft precedence constraints.
- The five repair operators remain distinct and have their own preconditions and intended use.
- Confidence-based entry routing is separated from post-failure local repair, global replan, and ReAct fallback.
- Main comparison results, the selected main component table, and the five Appendix C.2 ablations are not conflated.
- The book-created heating-a-potato trace is explicitly identified as illustrative rather than a claimed reproduction of a measured trajectory.

## 3. Implementation bridge coverage

The chapter includes Java-like records for skill schemas, invocations, graph nodes/edges, verifier contracts, failure events, repair patches, and runtime outcomes. It defines graph validity and patch acceptance contracts; separates source mechanisms from production-hardening proposals; provides a lifecycle and vertical-slice implementation plan; and proposes compilation, operator, integration, persistence/concurrency, replay, and benchmark tests.

The book-level additions—stable IDs, skill versions, transaction boundaries, durable checkpoints, side-effect reconciliation, and observability correlation—are not attributed to GraSP or Fan & Lan.

## 4. Editorial corrections made during the final pass

- Corrected the approved outline's decision record to show the author approval and drafting authorization.
- Converted two residual outline-direction phrases in the chapter prose into direct explanatory prose.
- Harmonized the ICARUS reference and GraSP author metadata with the bibliography records.
- Added glossary terms for the chapter's distinct skill/graph/edge/repair concepts.
- Kept the approved title, section sequence, nine-diagram plan, and scope unchanged.

## 5. Production checks and actual run results

| Check | Result | Evidence / boundary |
|---|---|---|
| `bash scripts/check-scaffold.sh` | PASS | Repository reports 17 drafted chapters; Chapters 16–17 each retain one canonical Markdown-only outline; Chapter 17 has nine accessible Mermaid sources. |
| `bash scripts/check-diagrams.sh --sources-only` | PASS | 86 source diagrams; accessible descriptions, sequence-syntax guard, and every Chapter 1–17 figure reference validated. |
| `bash -n` on the modified build/check scripts | PASS | `build-chapters.sh`, `check-scaffold.sh`, `check-diagrams.sh`, and `quality-checks.sh`. |
| XeLaTeX layout compilation | PASS — local preview only | 63-page standalone preview; used temporary Noto OpenType substitutes because the required TeX Gyre OpenType files are absent locally. The shared production preamble was restored byte-for-byte. |
| Biber | PASS | Three cited records processed; bibliography present in the preview. |
| Glossary and index | PASS | Glossary generation accepted 13 entries; MakeIndex accepted 26 index entries. |
| LaTeX references and citations | PASS on final local pass | No undefined citation/reference, empty bibliography, `LaTeX Error`, or `Emergency stop` diagnostics in the final preview log. |
| Horizontal overflow | PASS on final local pass | No `Overfull \hbox` or `Overfull \vbox` diagnostics. Several low-severity underfull-box warnings remain. |
| PDF text extraction | PASS | 63 pages; text extraction contains the chapter title, main prose, bibliography, glossary, and index. |
| Visual inspection | PASS — layout only | Contact sheet and representative title, table, code-listing continuation, bibliography, index, and placeholder-figure pages inspected. No clipped text or overlap observed. |
| Actual Mermaid 12.2.0 PNG rendering | NOT RUN locally | Pinned CLI is not installed/cached and npm DNS access is unavailable. Nine conspicuously labelled temporary layout panels were used only for preview, then excluded from the source archive. |
| Production-font build | CI gate | Local TeX Gyre OpenType variants are unavailable; GitHub Actions remains authoritative. |
| Full book `quality-checks.sh` | NOT RUN against chapter-only PDF | That script validates the combined book's metadata and all chapter headings, not an individual chapter PDF. The chapter preview was independently checked by pdfinfo, pdftotext, and the final LaTeX log. |

The supplied PDF is therefore a layout preview, not the final illustrated production PDF. No placeholder PNG or substitute-font build is represented as a fully validated release artifact.

## 6. Final review statement

The chapter is internally aligned with the approved Batch 8 outline and the approved nine-batch Part II plan. The chapter explains B5 as a closed candidate in the reviewed corpus and uses GraSP as the mandatory closest baseline for future skill-governance proposals. Chapter 18 remains a placeholder for Batch 9 synthesis after Chapters 9–17 have been completed and reviewed.
