# Batch 4 — Chapter 13 (B2) Outline Status v1

**Date:** 14 November 2026  
**Status:** Historical checkpoint, superseded by `Batch_04_Chapter_13_Outline_Status_v2.md`. The author later instructed that the outline be audited for an explicit theory-to-implementation bridge, revised, and followed directly by chapter drafting.

## Artifacts

- `Tex/part2/chapter13/outline/Chapter_13_Outline_v1.md` — detailed editable outline.
- `Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v1.tex` — chapter-local LaTeX outline wrapper using the shared preamble and macros.
- `Tex/part2/chapter13/outline/Chapter_13_Outline_v1_body.tex` — LaTeX body generated from the Markdown outline for deterministic build.
- `Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v1.pdf` — 35-page local review proof, visually checked.
- `review/Chapter_13_Source_Review_v1.md` — source map and claim-boundary notes.

## Content scope

The outline teaches Soar's operator-selection impasse mechanism and then distinguishes it from Fan & Lan's proposed B2 modern-agent runtime hypothesis. Four residual invariants are preserved: typed diagnosis, protected substate, typed return and resolution compilation. The modern baselines are kept separate, with their individual provisional E/D labels. The proposed experiment, required traces, measures, ablations, falsifiers and adjacent-bundle dependencies are included.

## Evidence boundaries

- Soar impasses are tied to operator selection; a generic tool exception is not automatically a Soar impasse.
- A Soar superstate/substate relation and Goal Dependency Set are not literally an immutable snapshot/fork implementation. Parent freezing is Fan & Lan's proposed modern-runtime translation.
- A Soar result is a linked working-memory element or preference, not arbitrary child text.
- Chunking follows successful operator-impasse resolution and compiles dependency conditions plus the result. Elimination/regeneration are distinct outcomes.
- B2 remains a hypothesis to test, not an already validated production architecture.

## Build and repository status

The outline PDF was compiled with XeLaTeX and Biber, text-extracted and rendered to PNG for visual review. The local review proof uses temporary Nimbus OpenType substitutes; the tracked wrapper continues to use the original shared preamble. The repository build script now includes the Chapter 13 outline, and the scaffold check verifies its artifacts while confirming that `chapter13/chapter.tex` remains a placeholder.

## Historical next step (superseded)

This was the next step before the author-directed v2 revision and immediate drafting instruction. See the v2 status record for the current state.
