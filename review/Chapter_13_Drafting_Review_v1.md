# Chapter 13 drafting and implementation-bridge review v1

**Date:** 14 November 2026  
**Decision:** Drafted against revised outline v2 after the author explicitly asked for an implementation-bridge audit and directed that chapter writing proceed after revision.

## Why the outline was revised

The original outline already moved beyond theory by naming a five-step B2 lifecycle and a Product X example. However, it did not require the reader to leave with enough detail to build a working recovery subsystem. Compared with the B1 revision, the bridge was not yet explicit about component responsibilities, type-safe data contracts, legal state transitions, persistence and concurrency, irreversible external side effects, dependency invalidation, rule governance, and executable tests.

Outline v2 adds those elements as a dedicated section between the B2 hypothesis and the Product X walkthrough. The same additions appear in the chapter's implementation section.

## What the chapter teaches

1. The historical Soar mechanism: typed operator-selection impasses, substates, superstates, result return, elimination/regeneration, dependency tracking and chunking.
2. Fan and Lan's modern B2 hypothesis: typed diagnosis, protected child recovery, typed return and compilation of reusable recovery knowledge.
3. Modern partial baselines and their specific preserved/missing edges, keeping E/D axes separate.
4. A practical recovery subsystem design: components, records, state machine, storage/concurrency, side-effect safety, validation, learning governance, reference pseudocode, vertical-slice sequence and tests.
5. A Product X payment timeout scenario used to exercise the design, with uncertain external outcomes treated conservatively.
6. An evaluation protocol with baselines, metrics, ablations and explicit rejection criteria.

## Implementation-bridge boundary

The reference architecture is a proposed book-level engineering design. It is not presented as existing Soar behavior, a feature of a named agent runtime, or an implementation provided by Fan and Lan. Code-like pseudocode is intended to make contracts and transitions reviewable; the chapter does not claim a production library or runnable repository implementation has been built.

## Build and verification status

The chapter is integrated as LaTeX source and has a standalone entry point. The shared preamble is preserved. Five Mermaid sources have accessibility metadata and matching figure placements. Since the local pinned Mermaid CLI is unavailable, real diagram PNG generation and final illustrated-PDF inspection remain CI gates. The 43-page `Chapter_13_LAYOUT_PREVIEW_NOT_FINAL.pdf` has been compiled and visually checked at representative pages, including the reference architecture/listing boundary, Product X recovery flow, glossary, references and index. It uses conspicuously labelled temporary diagram placeholders and local font substitutes and is not a release-ready illustrated chapter. The double-sided `openright` layout inserts intentional blank verso pages before references and index.
