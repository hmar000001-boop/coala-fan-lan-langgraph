> **Superseded:** this review predates the accepted B1 utility-scale correction and the final source reconciliation. Use `Chapter_21_Drafting_Review_v2.md`.

# Chapter 21 drafting review — v1

**Date:** 25 November 2026  
**Status:** Draft complete; standalone PDF proof built and visually reviewed  
**Chapter:** `Tex/part3/chapter21/chapter.tex`  
**Approved outline:** `Tex/part3/chapter21/outline/Chapter_21_Outline.md`

## Outline adherence and chapter shape

The approved outline has been carried into a complete implementation-led chapter. The draft contains the following progression:

1. Two different selection questions after base retrieval.
2. The real runtime sequence from M2 retrieval through B1 candidate construction, enrichment, selection, evidence persistence, projection, and access-history recording.
3. The B1 engineering objective, its accessibility estimate, separately predicted cognitive latency and measured infrastructure latency, downstream utility, maintenance estimate, and bounded selection constraints.
4. Working-memory projection as stable references rather than copied authoritative long-term records.
5. Separate selection/access history, verified-use learning, and maintenance-event accounting paths.
6. A separately prepared B3 heterogeneous workspace candidate set and optional, validated B1 attribution.
7. Mandatory-content protection, singleton/coalition comparison, bounded enumeration, and incomplete-admission semantics.
8. Synchronous consumer broadcast, durable receipt evidence, and the separate verification gate for downstream outcomes.
9. The as-built B1/B3 composition and its persistence boundaries.
10. The seven-field S/C/T/P/F/L/R analytical reading, recap, review questions, and a practical exercise.

The chapter includes six accessible Mermaid source diagrams and focused Java listings. The listings expose the contracts and call sequence needed to understand the implementation without reproducing entire source files or boilerplate.

## Cross-chapter consistency

- Chapter 19 remains the source for the supply-chain domain, simulator, action-dispatch boundary, Maven module map, and framework/runtime context. Chapter 21 does not restate those foundations.
- Chapter 20 remains the source for the CoALA memory taxonomy, cross-store base retrieval, internal actions, and the distinction between retrieval and later reasoning/learning operations. Chapter 21 begins after M2 retrieval rather than repeating its implementation.
- Part I's CoALA vocabulary is recalled briefly and cited directly. Fan and Lan's B1/B3 distinctions are treated as the Part II mechanism framing; their bundles are not presented as original CoALA architecture.
- B1 memory candidates and B3 workspace candidates remain different typed sets with an explicit application/domain handoff. The draft does not turn them into one universal linear pipeline.
- The chapter does not teach B2, B4, B6, planner internals, or the full LangGraph4j graph composition reserved for Chapters 22–24.

## Source-fidelity and correction review

The source-specific claims and exact test anchors are recorded in `review/Chapter_21_Source_Review_v1.md`. The draft retains the repository's important qualifications:

- The feature provider supplies trusted B1 features; the selector does not manufacture all of them.
- Accessibility and cognitive latency are engineering estimates, not a literal or calibrated ACT-R implementation. Infrastructure latency and estimated maintenance cost remain separate quantities.
- Selection access is not verified downstream use. The latter requires accepted receipt evidence, an actually consumed candidate, verifier-approved source evidence, and exact memory-revision attribution.
- Estimated maintenance profiles and actual maintenance-event accounting are different paths; the accounting service is not described as automatically wired into the durable host.
- B3 candidates are separately prepared. Optional B1 attributions are explicit and validated.
- Mandatory-content failure does not create a partial snapshot. Incomplete coverage/diversity may coexist with a snapshot, and admission status, snapshot lifecycle status, and graph disposition remain distinct.
- Coalition enumeration is bounded. A truncated set is not represented as a complete search; the documented singleton fallback is retained. No global-optimum guarantee is claimed.
- A consumer receipt records acknowledgement/consumption, not correctness or usefulness. Verified downstream outcomes remain a separate evidence boundary.
- Workspace snapshots are in-memory in the inspected durable-host composition, while receipts/outcomes and B1 feature state have PostgreSQL adapters. The missing focused PostgreSQL round-trip test for B1 feature state is disclosed.
- The chapter makes no empirical superiority, causal learning benefit, production deployment, or complete B1 persistence-validation claim.

## Standalone build and PDF proof

- A standalone XeLaTeX proof compiled successfully to **28 pages**, US Letter (612 × 792 pt). The final two-line orphan left by the longer transition paragraph was removed; the full "Looking ahead" paragraph now stays on page 27 and the references occupy page 28.
- The proof was built in a disposable copy of the repository because TeX Gyre Termes is not installed in the local environment. Only that proof copy's preamble used Liberation Serif, Liberation Sans, and Liberation Mono substitutions for the unavailable TeX Gyre families. The monospace substitution was deliberately aligned with Chapter 20's local proof PDF. The canonical repository preamble and its pinned font configuration were not changed.
- The final LaTeX log contains no LaTeX errors, emergency stops, unresolved citations/references, or overfull horizontal/vertical boxes. It does contain underfull horizontal-box notices, a local small-caps font-shape substitution notice, and the harmless standalone glossaries notice because this chapter has no glossary entries. Visual inspection found no clipping or unreadable lines.
- All 28 rendered pages were reviewed in contact sheets. The B1/B3 comparison table, the S/C/T/P/F/L/R table, the chapter recap, the final transition, and the references page were inspected at full page size. No clipping, split words, unreadable table cells, or visible layout overflow was found.
- The PDF's diagram images are temporary Graphviz layout previews corresponding to the six authored Mermaid sources. These previews were used only for visual proofing and are not included in the source package.
- The pinned Mermaid CLI 12.2.0 was not available locally. Actual Mermaid parsing/rendering of the six new sources remains to be confirmed in the configured book CI environment. The PDF proof must therefore not be mistaken for a canonical Mermaid-rendered build.
- The full combined book build and the supply-chain application's Maven/CI build were not run as part of this chapter-only delivery.

## Repository and scope checks

- Shell syntax checks passed for the updated build and validation scripts.
- `scripts/check-diagrams.sh --sources-only` passed for all 113 Mermaid sources and chapter references through Chapter 21.
- The updated scaffold check passed; it requires the six Part III chapters (19–24) and rejects obsolete Part III placeholders 25–30.
- Six obsolete, unrelated placeholder directories `Tex/part3/chapter25` through `Tex/part3/chapter30` were removed so that the repository conforms to its six-chapter Part III plan. Their removal is listed explicitly in the delivery manifest/README because a changes-only ZIP cannot delete them automatically when extracted as an overlay.
- No application Java source, application tests, Maven configuration, database migration, application CI workflow, or deployment configuration was modified.

## Final assessment

The draft is complete and suitable for integration as Chapter 21 source. The remaining external validation item is the canonical Mermaid CLI rendering in hosted CI. The proof PDF is useful for editorial review, but it is explicitly a local substitute-font/preview build rather than a reproducible canonical book build.
