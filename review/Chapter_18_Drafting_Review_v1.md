# Chapter 18 — Drafting and consistency review

**Chapter:** How the Mechanisms Work Together  
**Batch:** 9 — final synthesis  
**Outline:** v1.0, explicitly approved on 15 November 2026  
**Drafting instruction:** One minor-issues review pass, then begin immediately.

## Draft contents

The LaTeX chapter closes Part II with a synthesis of B1, B2, B3, B4, and B6 around GraSP as the existing closed B5 skill-governance capability. It does not reopen B5 or add a sixth residual hypothesis.

The manuscript includes:

- Fan and Lan's exact shared runtime state tuple and the proposal/governor/transition/learning distinction;
- a responsibility/authority matrix, including explicit non-authorities;
- all five Figure 8 cross-bundle dependencies;
- implementation order separated from the dependency graph;
- a bounded synthesis runtime and a four-plane teaching view explicitly identified as a book-level presentation;
- Java-like event, version, proposal, decision, and receipt contracts;
- transaction, idempotency, persistence, concurrency, interruption/resume, and graceful-degradation discussion;
- the Product X payment-status trace, with no unauthorized retry or duplicate charge;
- composition-specific failure modes, source-prescribed experimental discipline, the three minimum ablations, dependency experiments, full-system comparisons, metrics, and falsification criteria;
- a final recap and practical exercise.

## Cross-chapter consistency

- B1 accessibility and B3 workspace admission remain distinct.
- B2 recovery and B5 cross-episode skill governance remain distinct.
- B4 owns intention/goal/method authority; B6 owns risk/resource/action constraints.
- Workspace visibility and skill applicability do not grant external-action permission.
- GraSP's E3/D4 mapping remains case-specific and independent across the E and D axes.
- No aggregate E/D label is assigned to the composite runtime.
- The complete composition remains a research hypothesis, not a result from Fan and Lan or the preceding component studies.

## Engineering-proposal distinctions

All Java-like contracts, the four-plane teaching view, aggregate and event boundaries, transaction strategy, Product X trace, and added dependency experiments are clearly labelled as book-level proposals or hypotheses.

## Figures

Nine editable Mermaid sources are included under `Tex/diagrams/source/part2/chapter18/`. Each includes `accTitle` and `accDescr`, and each is referenced once in the chapter through `\BookDiagram`. Real PNG rendering remains a pinned Mermaid CLI / GitHub Actions gate when the local CLI is unavailable.

## Review result

The manuscript follows Outline v1.0. No changes to the approved chapter scope were required. The only outline clarifications retained were the distinction between component-local limits and the runtime-wide resource ledger, and the explicit marking of the four-plane view as a book-level teaching model.


## Local build and visual inspection — 15 November 2026

- Standalone layout preview: 57 pages, 7 × 10 inch trim, two-sided/open-right layout.
- Local font substitution: Noto Serif / Noto Sans / Noto Sans Mono for the disposable preview only; the production preamble was restored byte-for-byte afterward.
- Diagram status: nine disposable panels labelled `NOT A MERMAID RENDER` were used only for spacing/pagination inspection. They were removed from the repository before packaging. No real Mermaid PNG render is claimed.
- LaTeX/Biber/glossary/index: completed. The final log has no unresolved citations/references, LaTeX errors, hyperref warnings, overfull boxes, or oversized floats. Nine glossary entries and a 20-entry chapter index were generated.
- PDF text extraction and representative-page visual inspection: passed. The authority matrix spans pages with repeated headers; code listings, Product X tables, glossary, references, and index were inspected.
- Repository: shell syntax, scaffold validation, and `scripts/check-diagrams.sh --sources-only` passed. The latter validates all 95 Mermaid sources, accessible descriptions, the sequence syntax guard, and Chapter 1–18 figure references.
- Remaining CI gates: render all Mermaid sources using pinned CLI 12.2.0, validate generated PNG integrity/dimensions, inspect real diagrams at printed size, and compile with the production TeX Gyre OpenType fonts. The local PDF is a layout preview, not the final illustrated production PDF.
- Shared `Tex/preamble.tex` SHA-256 after restoration: `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b` (byte-for-byte unchanged).
