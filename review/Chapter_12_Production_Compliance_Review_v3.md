# Chapter 12 production-compliance and redrafting review v3

**Date:** 14 November 2026  
**Decision:** Redraft required; substantive B1 content retained and amended.  
**Status:** Source integration and static validation complete; actual Mermaid render and final illustrated-PDF review remain CI gates.

## Verdict

The previous Chapter 12 draft did not fully satisfy the latest Part II writing and quality rules. Its core teaching content was sound, but the production artifact set and source comparison were incomplete. The chapter has therefore been revised rather than restarted.

## Changes made

1. Added the memory-focused baseline set explicitly named by Fan & Lan: AgeMem, Memory-R1, MemCon, DeltaMem, A-MAC, CURATOR, and DAM. The chapter distinguishes the executable adaptive baselines from DAM as a conceptual comparator and states that CURATOR is the closest value--cost comparator. It adds the review-specific CURATOR summary (online helpfulness fitting; retrieval propensity, value, harm, and byte cost for keep/share/trust decisions) without inventing an equation or claiming an independent reconstruction of its implementation. The residual B1 novelty boundary is not adaptive admission or value/cost in isolation; it is their coupling with activation/accessibility, predicted retrieval latency, and downstream action utility at context assembly.
2. Replaced parenthetical `\\parencite` citations with the shared footnote-style `\\autocite` path, retained formal `[Fan & Lan]` citations through `\\FanLanCite`, and expanded source trace locations.
3. Added three chapter-specific Mermaid sources with accessibility titles/descriptions and shared-theme classes. Added `\\BookDiagram` placements, captions, labels, and explanatory prose. The three figures distinguish lifecycle decisions, B1 context assembly, and the event-evidence chain.
4. Added shared glossary terms and first-use `\\gls` calls for ACT-R activation concepts, retrieval latency, production utility, admission, retention, context assembly, and memory value. Added index entries.
5. Updated the standalone chapter entry to print glossary and index, consistent with Chapter 11.
6. Added a source/example note that separates Fan & Lan claims, ACT-R source mechanisms, and the book-created Product X example and engineering synthesis.
7. Created active outline v3 in Markdown plus matching chapter-local LaTeX and PDF artifacts; preserved outline v2 as an earlier checkpoint. The outline now distinguishes persistent-memory admission from B1 context admission.
8. Extended the scaffold and Mermaid validators/build script to cover Chapter 12 and updated the repository README.

## Source-fidelity boundary

Fan & Lan §VI-C B1 and Tables V--VI explicitly name the memory baselines and identify CURATOR as the closest value--cost comparator. The paper states that adaptive admission and value--cost memory governance are already implemented; B1 tests the remaining activation--latency--downstream-action-utility coupling. This statement is source-derived and is not replaced by an invented ranking or by claims that all named systems share an algorithm. The detailed behavior of each baseline is not expanded beyond the source's classification unless supported by its own primary paper.

Persistent-memory admission (new records entering durable storage) is distinguished from B1 context admission (already-stored candidates entering the active context). The book-level set-value objective, event schema, Product X example, selector procedure, and proposed ablations remain explicitly identified as engineering synthesis.

## Validation

- Repository scaffold: **passed** after the v3 outline Markdown/LaTeX/PDF artifacts were rebuilt.
- Citation key audit: **passed**; all 18 comparative citation keys resolve, and Biber produced the chapter bibliography.
- Glossary/index audit: **passed**; all 11 glossary identifiers resolve and the standalone build prints the glossary and index.
- Mermaid source accessibility metadata and reference mapping: **static source check passed** for all 48 repository sources and all three Chapter 12 placements. This does not validate rendered appearance.
- Actual Mermaid CLI 12.2.0 render: **not completed locally**; `npm install --prefix tools/mermaid` timed out. CI must render PNGs before LaTeX compilation.
- Local Chapter 12 layout proof: `Tex/Output/Chapter_12_LAYOUT_PREVIEW_NOT_FINAL.pdf` (45 pages, 7 × 10 inches) was rebuilt with visible placeholder labels at all three figure positions. It uses temporary local font substitutions and is explicitly not the final illustrated chapter PDF. No ambiguous `Chapter_12.pdf` is included. The superseded pre-v3 PDF is not part of the release package.
- TeX Gyre OpenType fonts are not installed in this environment; any local XeLaTeX layout preview requires temporary font substitutions. The repository preamble remains unchanged and CI installs the intended fonts.

## Release decision

Chapter 12 has been redrafted to satisfy the source, outline, citation, glossary/index, event-schema, and diagram-source requirements. It is **not yet fully release-compliant**: the pinned Mermaid CLI could not be installed locally, so the three real PNGs have not been rendered or inspected. Chapter 13 must not begin until the first CI run renders the real figures, the standalone and combined PDFs compile, and all three figures are inspected at print size. This is a remaining release gate, not a claim that the source revision is incomplete.
