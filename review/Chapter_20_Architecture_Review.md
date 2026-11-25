# Chapter 20 — architecture and cross-chapter review

**Review status:** completed; revised manuscript and diagram sources are ready for author review.  
**Scope:** Chapter 20 prose, its chapter-local outline, its four affected Mermaid sources, and the relationships to Chapters 1–19 and the planned Chapter 21.  
**Implementation basis:** the supplied Java repository snapshot used when drafting Part III.

## 1. Review conclusions

The chapter remains a CoALA implementation chapter. It does not introduce Fan and Lan as a second explanatory framework, and it does not attempt to teach the complete runtime composition reserved for Chapter 24. The review found no need to change the chapter's top-level structure. It did find several places where the prose or figures implied stronger coupling or uniformity than the Java implementation provides. Those claims have been narrowed.

## 2. Architecture clarifications applied

### Memory scope and temporal behavior

- Working memory is scoped by `MemoryScopeId`; that scope is not necessarily identical to one graph invocation.
- Working-memory retrieval by identifier, scope, and expiry returns the current stored snapshot. It does not reconstruct a historical working-memory value as of `knownAt`.
- Episodic, semantic, and procedural retrieval have different filters. They must not be described as one uniform bitemporal retrieval engine.
- Historical eligibility can identify an episode or semantic fact as eligible at a requested time while returning the currently stored immutable object and its current lifecycle status. It does not materialize the old lifecycle state.
- Semantic retrieval in `MemoryRetrievalService` is conditional on an entity being supplied; the service does not perform an unconditional search across all semantic facts.
- Procedure predecessor retirement occurs inside the repository's replacement activation operation. There is no separate retire action in the action catalog.

### Internal actions and learning governance

- Retrieval, reasoning, working-memory updates, episodic recording, semantic proposal/review, and procedural lifecycle operations are separate typed handlers.
- The contracts do not define an automatic retrieval → reasoning → learning pipeline. Callers compose optional handoffs.
- Episodic and semantic review use separate capabilities and evidence contracts. The source does not retain the identity metadata necessary to enforce the same author-versus-reviewer comparison for those records.
- Author/validator/approver identity separation is explicitly enforced in the procedural lifecycle. Activation additionally checks separation from both author and prior validator. The chapter no longer generalizes that control to every memory type.
- Evidence-reference validation ensures a reasoning response cites only evidence supplied to the request. It does not establish source truth, model correctness, or calibrated confidence.

### Planning, evaluation, and authority

- `PlannerRouter` chooses a planning strategy; it is not a candidate-selection service.
- There is no generic candidate selector shared by all planners. Candidate ordering and retention are strategy-specific.
- `CandidateEvaluator` is distinct from planner-method routing and from strategy search ranking.
- The sequential planner receives a `SequentialDecisionProvider` port. The inspected application/runtime/planning main sources do not supply a concrete production adapter for that port; deterministic test providers are used in tests. A LangChain4j `ReasoningProvider` adapter does not automatically implement the sequential decision provider.
- The evaluator replays candidate paths against the configured model and checks represented constraints. It aggregates proposer-supplied action impact estimates; it does not independently derive or calibrate those estimates from measured simulator transitions.
- A candidate can remain feasible while `approvalRequired` is true. Feasibility, selection, human approval where required, capability authorization, dispatch, idempotency, and current-world version checks remain separate decisions.
- Structured simulator-backed planning branches are not LLM-imagined consequences and are not environmental observations. The simulator applies candidate commands to isolated branch states; the current world is changed only through the grounding/dispatch path.

## 3. Cross-chapter and duplication review

- Chapters 2–8 already establish CoALA's concepts. Chapter 20 now recalls the relevant chapter at the point of implementation and avoids reproducing the theoretical exposition.
- Chapter 19 owns the supply-chain domain, simulator boundary, module map, and dispatch/authorization/concurrency tour. Chapter 20 points back to those sections rather than repeating their detailed explanation.
- The illustrative Product X payment examples in Parts I and II are not represented as the application implemented in Part III.
- Chapter 20 stops at CoALA memory/actions/planning contracts and their code-level limits. B1 and B3 are reserved for Chapter 21; B2 for Chapter 22; B4 and B6 for Chapter 23; full graph/runtime composition for Chapter 24.
- The chapter's final transition frames Chapter 21 as the next concern: how available memory candidates are valued/selected (B1), and how heterogeneous information competes for bounded workspace admission (B3). It does not imply that these mechanisms already exist in `MemoryRetrievalService`.

## 4. Diagram corrections

The revised diagrams distinguish:

- memory retrieval from optional, caller-managed reasoning and write operations;
- strategy selection from candidate search ordering, evaluation, execution permission, and grounding;
- isolated planning-branch transitions from mutation of the current simulated world;
- candidate feasibility/approval flags from downstream authorization and dispatch.

The four revised Mermaid sources are:

- `evaluation-selection-authority.mmd`
- `four-memory-responsibilities.mmd`
- `internal-actions-memory-write.mmd`
- `planning-branch-boundary.mmd`

## 5. Validation and remaining qualifications

- `bash scripts/check-diagrams.sh --sources-only` passed: 107 Mermaid sources, accessible descriptions, sequence syntax guard, and all Chapter 1–20 figure references.
- The standalone Chapter 20 proof compiled to 23 US Letter pages; the chapter/section references and bibliography resolved in that proof.
- The chapter recap now avoids splitting the word “recording” across the page break.
- The PDF proof was generated with a temporary Liberation font substitution because the specified TeX Gyre OpenType fonts were not available in the local environment. The repository's approved font configuration was not changed.
- Local figure previews used temporary Graphviz renderings. The Mermaid `.mmd` sources are authoritative; the pinned Mermaid CLI 12.2.0 rendering has not yet been confirmed in hosted CI because installing the CLI timed out locally.
- `bash scripts/check-scaffold.sh` still exits before its normal checks because the working book snapshot lacks `Tex/standalone/chapter19.tex`. This was not repaired by changing the check script; it is a repository-level prerequisite to reconcile separately.
- The final LaTeX log includes one overfull vertical-box warning on page 10 and several underfull horizontal-box notices, mainly around tabular text. The affected pages were visually inspected; no clipping or overlap was observed. This should not be represented as a warning-free TeX build.

No Java source, Java tests, Maven configuration, application scripts, or CI workflows were modified during this review.
