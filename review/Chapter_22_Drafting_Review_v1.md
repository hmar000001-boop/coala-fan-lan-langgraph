# Chapter 22 drafting and source-fidelity review

**Book:** *From Cognitive Architectures to Production Agentic Systems*  
**Chapter:** 22 — Typed Impasses and Protected Recovery: B2  
**Outline:** `Tex/part3/chapter22/outline/Chapter_22_Outline_v2.md` (author-approved)  
**Implementation baseline:** accepted, CI-green supply-chain application; application repository inspected read-only  
**Scope:** book source, diagrams, standalone build entry, and book checks only

## Draft completion

- The approved ten-section outline is represented in the manuscript.
- The 7,541-word chapter uses ten main sections, sixteen subsections, five Mermaid diagrams, four tables/longtables, two focused Java listings, a chapter recap, review questions, and a practical exercise.
- The standalone entry is `Tex/standalone/chapter22.tex`; the chapter source remains a fragment and does not introduce a chapter-local preamble or typography system.
- Chapter 21's final transition was clarified to distinguish parent identity/version validation from evidence verification performed during governed procedure reuse.

## Source-fidelity checks emphasized in the prose

1. The active opening path consumes a host/domain-supplied typed `ImpasseSignal`; it is not described as an automatic classifier over raw failure text. `DeterministicImpasseDetector` consolidation is described separately from the active opening call path.
2. `ParentContextSnapshot` is described as the four-field identity/version tuple (scope, request ID, working-memory version, objective fingerprint), not a full parent-state copy or a Soar Goal Dependency Set.
3. The child capability allow-list is distinguished from the parent grant and from the per-case action-count/deadline limits.
4. B2 opening and B4 intention delegation are described as successive repository transitions with best-effort compensation, not a distributed atomic transaction.
5. Child-step receipts, lease state, fencing tokens, completed-step reuse, and unknown-outcome reconciliation are distinguished from the B2 case action budget and from graph checkpointing.
6. The four-node B2 subgraph is described as an orchestrator. The chapter does not claim a dedicated inner-B2 saver or prove full restart semantics from the receipt/case persistence tests.
7. Parent return checks case/result identity, parent request/scope/version/objective fingerprint, timestamp, and optimistic case version. It is explicitly not presented as dereferencing or proving every finding.
8. Evidence freshness/scope and registered action descriptors are checked at the procedure-draft and later governance/retrieval boundaries. Draft creation, B2 approval, staging, independent procedural validation, activation, and retrieval remain distinct transitions.
9. The untested `HYPOTHESIS_PROPOSED` disposition edge is disclosed; the prose does not imply that the current implementation safely exercises it.
10. Active runbook retrieval yields planning knowledge, not executable authority. Chapter 19's action authorization boundary remains in force.

## Continuity review

- **Chapter 19:** no repetition of the domain model, simulator, dispatcher, or broad capability architecture; only the relevant boundary is referenced.
- **Chapter 20:** no re-teaching the four CoALA memory types or the general procedural-memory model; B2's optional procedure lifecycle is the focus.
- **Chapter 21:** B1/B3 selection, workspace, receipts, and outcome-feedback mechanisms are not re-explained. Chapter 21's transition now describes the B2 return/evidence-verification seam accurately.
- **Part II Chapter 13:** B2 theory and Soar lineage are referenced rather than repeated; the Java realization is explicitly described as narrower and application-specific.
- **Chapter 23:** only the B2/B4 delegation-return seam and uncertainty refresh are introduced; full B4 intention/method authority and B6 governance are deferred.
- **Chapter 24:** full-graph composition, top-level checkpoint behavior, and end-to-end workflow remain deferred.

## Build and visual inspection

- Standalone XeLaTeX proof build: **passed**, 22 pages, US Letter (612 × 792 pt).
- `Overfull \\hbox` warnings in the final chapter log: **none**.
- Rendered pages: **22/22**; visual inspection covered contact sheets, all five figure placements, source/test tables, recap, exercises, transition, and references.
- The local proof copy substituted Liberation font families because the TeX Gyre families declared in the canonical preamble were unavailable to XeTeX in this environment. The canonical preamble was not changed.
- Diagram images used for local visual proof were temporary Graphviz previews. The five `.mmd` files are canonical; the pinned Mermaid CLI 12.2.0 render remains to be confirmed by the configured CI environment.
- The local standalone proof build is not the canonical full-book build. The original CI workflow remains the final build authority.

## Repository checks

- `bash scripts/check-scaffold.sh`: passed; Part I 8, Part II 10, Part III 6; Chapters 1–22 drafted; Chapters 23–24 outline-gated.
- `bash scripts/check-diagrams.sh --sources-only`: passed; 118 Mermaid sources, accessible descriptions, and all Chapter 1–22 figure references.
- `bash -n scripts/check-scaffold.sh scripts/check-diagrams.sh scripts/build-chapters.sh`: passed.
- No supply-chain application files, Maven files, application tests, migrations, or application CI files were changed or included.

## Remaining CI confirmation

The Mermaid sources still require rendering by the pinned Mermaid CLI 12.2.0 in the configured book CI, followed by the canonical repository/book build. No claim is made that the local Graphviz previews substitute for that CI render.
