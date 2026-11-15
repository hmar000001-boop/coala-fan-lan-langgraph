# Chapter 13 source-fidelity review v2

**Chapter:** Understanding Typed Impasses, Substates and Compilation: B2  
**Date:** 14 November 2026  
**Status:** Draft source review prepared alongside the chapter.

## Primary-source coverage

The chapter is grounded in Fan and Lan (2026), especially the historical Soar reconstruction, the B2 residual hypothesis, the modern system comparison, and the experiment template in Appendix D. The chapter preserves B2 as a proposed coupling of typed diagnosis, protected recovery substate, typed return and condition-safe resolution compilation. It does not claim that B2 is already implemented by a single modern system or experimentally validated.

The B2 experimental requirements are preserved: record failure type, parent hash, substate trace, returned resolution and compiled rule; measure recovery by type, repeated failure, transfer, diagnosis latency, state corruption and unsafe reuse; use matched controls; run the state-object, authoritative-control-edge and learning-update ablations; and reject or narrow the claim where simple retry is non-inferior or compilation causes harm.

## Soar historical mechanism

The Soar sections explain operator-selection preferences and the four typed impasses (tie, conflict, constraint-failure and no-change), the superstate/substate relationship, child results, resolution/elimination/regeneration and dependency tracking. The University of Michigan Soar Architecture manual is used as a historical mechanism cross-check, not as a replacement for Fan and Lan's framing.

The Goal Dependency Set is described as tracking superstate working-memory dependencies of subgoal-produced structures, so a change to a dependency can invalidate and regenerate the substate. The Procedural Knowledge Learning manual is cited for the timing nuance: chunk generation can occur as soon as a subgoal creates a result in a superstate, rather than only after the substate is finally removed. The text avoids the inaccurate universal rule that learning starts only after child closure.

## Modern baseline boundaries

PALADIN and AgentDebugX are discussed for typed failure diagnosis/recovery; Shepherd for reversible/forkable execution; AgentHER and Reflexion for later behavior changed by failed experience. Their E/D records are stated only for the particular mappings reported by Fan and Lan. The chapter does not combine those values into a B2-wide score, and does not claim any of the baselines has all four B2 invariants.

## Theory-to-practice bridge

The chapter distinguishes source-derived B2 invariants from book-level engineering proposals. Component roles, record contracts, state-machine labels, persistence and concurrency patterns, side-effect/idempotency controls, typed-return validation, dependency-aware rule compilation, promotion/quarantine/rollback, Java-like pseudocode and the vertical-slice plan are explicitly marked as engineering synthesis, not as features of Soar or Fan and Lan's paper.

Product X and its payment-timeout/unknown-settlement scenario are book-created examples. They illustrate why a timeout is not permission to repeat a non-idempotent external action and why a child recovery branch must return a verified outcome before the parent proceeds.

## Figures and production status

Five chapter-specific Mermaid `.mmd` sources are included with `accTitle` and `accDescr` and use the shared Mermaid configuration. Four figures use the shared `\\BookDiagram` macro; the reference-implementation figure uses the same shared caption and width conventions with in-place placement so it cannot split the following multi-page contract listing. The local environment does not currently have the pinned Mermaid CLI, so the PNGs have not been rendered or visually inspected. A 43-page chapter layout proof is included as `Tex/Output/Chapter_13_LAYOUT_PREVIEW_NOT_FINAL.pdf`; it uses conspicuously labelled temporary placeholders and temporary local font substitutes, not real Mermaid output. The first CI run must render the real PNGs, validate them, and inspect all five at print size before the illustrated chapter is called complete. The proof includes shared glossary entries, 25 chapter index entries, references, and the intentional verso blanks required by the double-sided `openright` book layout.
