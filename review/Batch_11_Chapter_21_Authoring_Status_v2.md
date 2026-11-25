# Batch 11 — Chapter 21 authoring status (v2)

**Date:** 25 November 2026  
**Chapter:** 21 — Memory Selection and Workspace Competition: B1 and B3  
**Status:** Final source reconciliation complete after the accepted B1 utility-scale correction and author-confirmed green application CI.

## Authoring and source baseline

- The detailed Markdown outline was explicitly approved by the author on 25 November 2026.
- The complete Chapter 21 LaTeX prose is in `Tex/part3/chapter21/chapter.tex`; the approved outline is `Tex/part3/chapter21/outline/Chapter_21_Outline.md`.
- The chapter is aligned to `supply-chain-agent-main (9).zip` plus the accepted two-file B1 utility-scale patch. The accepted patch preserves provider-supplied task-scale candidate utility during enrichment. The author confirmed GitHub Actions CI green.
- The application is now frozen. This book-only update does not modify Java source, Java tests, Maven, migrations, application documentation, or application CI.
- The persisted B1 outcome statistic remains a legacy-named [0,1] feature-state field and is no longer substituted for the provider's task-scale candidate utility. The chapter does not claim a calibrated outcome-to-task-utility model.
- `MaintenanceProfile` and B3 coalition enumeration are unchanged. The chapter reports the actual five-field cost estimate, flags the unresolved `admissionValidationCost` semantics, and describes the actual complete-combination budget without claiming a hard bound on every recursive operation or incoming-candidate count.

## Cross-chapter disposition

- Chapter 20 remains unchanged: it accurately ends at the M2 retrieval boundary and defers B1 selection and B3 admission.
- Part II Chapters 12, 14 and 18 remain unchanged as theoretical/engineering-design analyses; their distinctions are reconciled in Chapter 21 without rewriting their proposals as implemented behavior.
- Chapters 19 and 22–24 required no edits for the accepted B1 correction.
- The six obsolete, unreferenced Part III placeholders 25–30 are removed; Part III remains the approved six chapters, 19–24.

## Validation and proof

- Chapter 21 has six accessible Mermaid source diagrams. `scripts/check-diagrams.sh --sources-only` validates 113 Mermaid sources and Chapter 1–21 figure references.
- `scripts/check-scaffold.sh` verifies Part I 8, Part II 10 and Part III 6; Chapters 19–21 contain prose and Chapters 22–24 remain outline-gated placeholders.
- The approved outline's 49 unique named test references resolve to exact methods in the accepted application source tree.
- Standalone XeLaTeX proof: 31 US Letter pages, rendered and visually inspected. The final PDF integrity record is `review/Chapter_21_PDF_Integrity_Review_v3.md`.
- The local proof uses temporary Liberation font substitutions because the configured TeX Gyre font files are unavailable in this environment. The canonical `Tex/preamble.tex` is unchanged. The pinned Mermaid CLI 12.2.0/canonical book build remains a CI verification item; the six `.mmd` sources are the authoritative diagrams.

## Part III status

Chapters 19–21 contain drafted prose from individually approved outlines. Chapters 22–24 remain placeholders pending individual outline approval. Future work remains confined to the LaTeX book; the supply-chain application is frozen.
