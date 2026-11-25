> **Superseded:** this status predates the accepted B1 utility-scale correction and the final 31-page Chapter 21 reconciliation. Use `Batch_11_Chapter_21_Authoring_Status_v2.md`.

# Batch 11 — Chapter 21 authoring status

**Date:** 25 November 2026  
**Chapter:** 21 — Memory Selection and Workspace Competition: B1 and B3

- The detailed Markdown outline was explicitly approved by the author on 25 November 2026.
- LaTeX prose was drafted in `Tex/part3/chapter21/chapter.tex` from that approved outline.
- Six accessible Mermaid source diagrams were added under `Tex/diagrams/source/part3/chapter21/`.
- A standalone entry point was added at `Tex/standalone/chapter21.tex`.
- The standalone build script, diagram-reference validator, scaffold check, README, and writing-rules status were updated to recognize Chapter 21 as drafted.
- Chapter 21 uses the supplied application snapshot `supply-chain-agent-main (9).zip`; code and test names were checked against that snapshot.
- The six stale, unrelated Part III placeholder directories for Chapters 25–30 were removed. Part III remains exactly six chapters, Chapters 19–24.
- Source and drafting reviews are recorded in `review/Chapter_21_Source_Review_v1.md` and `review/Chapter_21_Drafting_Review_v1.md`; the PDF integrity comparison is recorded in `review/Chapter_21_PDF_Integrity_Review_v1.md`.
- Final standalone proof: 28 US Letter pages; final PDF SHA-256 is recorded in the PDF integrity review.
- No application Java source, tests, Maven configuration, database migration, application CI workflow, or deployment configuration was modified.
- The chapter distinguishes test coverage from empirical validation and records the missing focused PostgreSQL B1 feature-state round-trip test.

**Current Part III state:** Chapters 19–21 contain prose from individually approved outlines. Chapters 22–24 remain placeholders until each detailed outline is individually approved.
