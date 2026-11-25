# Chapter 20 drafting review — v1

**Date:** 25 November 2026  
**Status:** Draft complete; standalone PDF proof built and visually reviewed  
**Chapter:** `Tex/part3/chapter20/chapter.tex`

## Outline adherence

The draft follows the author-approved Chapter 20 outline:

1. CoALA's three dimensions mapped to application responsibilities.
2. The four memory types and their distinct lifecycle contracts.
3. Internal retrieval, reasoning, and learning actions.
4. External perception and grounding.
5. Planning requests, immutable branch state, and simulator-backed transitions.
6. Sequential, bounded alternative-search, and MCTS strategies.
7. Candidate replay/evaluation, selection, and execution-authorization boundaries.
8. A bounded trace assembled from focused component contracts and tests.

Seven accessible Mermaid figures are authored in `Tex/diagrams/source/part3/chapter20/`. Listings are limited to the contracts needed to explain behavior; full classes and boilerplate are not reproduced.

## Cross-chapter consistency

- Chapter 19 already introduced the business domain, deterministic simulator, action dispatcher, perception/grounding distinction, module boundaries, and framework technology boundaries. Chapter 20 refers back to those sections instead of repeating their full explanations.
- Chapters 2–8 are recalled through short transitions and CoALA citations. Product X is not repeated; the chapter uses actual supply-chain types and fixtures.
- Fan and Lan's mechanism review is not used as a theoretical lens for CoALA. B1/B3 are deferred to Chapter 21, B2 to Chapter 22, B4/B6 to Chapter 23, and graph composition to Chapter 24.
- The draft distinguishes exact memory lookup from B1 selection and B3 workspace admission; procedural memory from GraSP; internal planning branches from grounding; and a feasible candidate from an authorized action.

## Accuracy corrections embedded in the prose

- No claim that a concrete production `SequentialDecisionProvider` adapter exists in the supplied app/runtime main sources.
- No claim that a `LangChain4jReasoningProvider` is the sequential planner provider.
- No claim that reasoning automatically writes memory or that episode recording self-verifies.
- No claim that simulator-backed planning commits to the current world.
- No claim that supplied impact estimates are independently calibrated against simulator outcomes.
- The aggregate risk independence assumption and unsupported protected-commitment constraint are stated explicitly.
- Focused tests are not described as one end-to-end run.

## Editorial review

The chapter is deliberately implementation-led and avoids repeating the full conceptual explanations from Part I. The B1/B3 and B2/B4/B6 material is only identified as a future responsibility; it is not taught prematurely. It keeps the application's implementation choices distinct from claims made by CoALA.

## Build and rendering checks

- Standalone XeLaTeX proof built to 21 pages on US Letter using a disposable local copy with Liberation font substitutions; the repository preamble and prescribed TeX Gyre font configuration remain unchanged.
- The proof log has no LaTeX errors, unresolved references/citations, or overfull boxes.
- Rendered pages were visually inspected for diagrams, tables, code listings, recap, exercises, and references.
- The standalone wrapper omits `\printglossaries` because this chapter has no glossary entries; the combined book retains its normal global glossary. The glossaries package emits a harmless standalone notice that no glossary was requested.
- Mermaid source and repository checks pass, but actual rendering with the pinned Mermaid CLI 12.2.0 remains for hosted CI because the local CLI could not be installed. The PDF proof uses temporary Graphviz renderings corresponding to the Mermaid sources; those generated PNGs are not part of the source changes.
