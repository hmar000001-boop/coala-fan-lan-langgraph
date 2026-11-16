# Phase 3 — Part I selective compression (Chapters 1–8)

## Scope

This phase applies the agreed editorial compression to Part I only. It preserves the CoALA concepts, historical explanations, distinct examples, source boundaries, safety warnings, review questions, and chapter recaps. No Part II or Part III source was changed.

## Modified files

### `Tex/part1/chapter01/chapter-body.tex`
- Combined the overlapping model-call definition and its input/output boundary explanation.
- Shortened the simple text-in/text-out explanation and repeated feedback-loop wording.
- Replaced the four detailed introductory dimension subsections with a compact preview table mapping each CoALA dimension to its architectural question and the chapters that develop it. The earlier Product X question-to-dimension mapping remains.
- Shortened the repeated list of what CoALA does not prescribe while preserving the distinction between conceptual framework and implementation/deployment choice, and the production-readiness caveat.
- Condensed the chapter hand-off without removing the historical production-systems bridge, the Soar illustration, or the Product X incident.

### `Tex/part1/chapter02/chapter.tex`
- Shortened the explanatory paragraph after the three-dimension overview table.
- Removed both takeaway boxes because their content remains in the body and chapter recap.
- Merged the repeated “Memory's place in the architecture” exposition into the structural-map memory subsections; retained its distinct warning about storage products and implementation policies.
- Recast the Product X architecture walkthrough as a concise three-dimension mapping table. It retains the active/long-term information distinction, internal and external action types, decision-cycle operations, and the explicit authorization/safety boundary.
- Reduced the common-misreadings list to architecture-specific distinctions already owned by this chapter.
- Shortened the roadmap paragraph; the chapter sequence remains clear.

### `Tex/part1/chapter03/chapter.tex`
- Removed the takeaway box that repeats the prompt-versus-working-memory distinction already explained in the surrounding prose and recap.
- Condensed the “what the taxonomy does not decide” section while preserving storage representation, physical-store separation, lifecycle/retention/privacy/deletion, retrieval design, provenance/confidence, and variable memory configurations as unresolved engineering decisions.
- Kept all four CoALA memory categories, the cooperation example, the procedural-memory warning, exercises, and recap.

### `Tex/part1/chapter04/chapter.tex`
- Integrated the point that reasoning does not automatically write to long-term memory into the reasoning explanation; removed the redundant standalone note box.
- Replaced the repetitive common-confusions list with a compact diagnostic table covering retrieval versus reasoning, reasoning versus learning, learning versus fine-tuning, and internal actions versus grounding/decision control.
- Kept the retrieval diagnostic tip, the fine-tuning/procedural-change safety warning, examples, and recap.

### `Tex/part1/chapter05/chapter.tex`
- Removed the four-part definition note box because the environment/procedure/action/observation distinctions are already explained in the body.
- Shortened the common-confusions list while retaining the distinct grounding/retrieval, environment/wrapper, action/observation, dialogue, and stateful-digital-environment distinctions.
- Removed the repeated safety caveat from the recap; the substantive safety section and warning box remain intact.
- Preserved physical, dialogue, and digital examples and exercises.

### `Tex/part1/chapter06/chapter.tex`
- Removed the standalone box that merely located proposal relative to Chapters 7–8; the chapter opening and section text already make the boundary explicit.
- Shortened the early Product X candidate preview and retained the complete unranked candidate walkthrough as the authoritative example.
- Consolidated the candidate-status tip and warning into one warning after the full walkthrough.
- Shortened common-confusion material without removing the distinctions among proposal, evaluation, selection, and execution.
- Kept the reasoning/retrieval proposal explanation, limited-set enumeration, code-structured generation, simulator discussion, and SayCan provenance boundary.

### `Tex/part1/chapter07/chapter.tex`
- Removed the takeaway box because the evaluation-versus-selection distinction is fully explained in the body and recap.
- Merged the warning about interpreting the largest illustrative value into the existing note about the absence of a universal value scale.
- Removed the standalone rejection note because the selection section already explains rejection and return to proposal.
- Shortened the common-confusions section to retain the distinct simulation-versus-observation and selection-versus-safety-architecture boundaries.
- Preserved the Phase 2 softmax equation and numerical example, all CoALA-named value sources and selection methods, the Product X walkthrough, and the simulation/observation warning.

### `Tex/part1/chapter08/chapter.tex`
- Shortened the overlapping opening account of repeated cycles and removed the takeaway that repeated the chapter recap.
- Kept one clear explanation that reasoning/retrieval are internal actions that can support proposal, evaluation, and selection; removed the duplicate note box.
- Reduced common-misreading bullets by combining repeated evaluation/selection/rejection/execution distinctions.
- Removed the separate Product X example warning and moved the source limitation into the source/example note: the hypothetical timestamp is invented and is not evidence of cause or success.
- Preserved the distinct warning against presenting an illustrative sequence as “the CoALA algorithm,” the cycle diagram, flexible-planning diagram, and full multi-cycle Product X trace.

## Added files

- `CHANGELOG_PHASE_3.md`
- `README_CHANGESET.md`
- `CHANGE_MANIFEST.csv`

## Deleted files

- None. The phase removes redundant callout environments and prose within modified chapter sources; it does not delete repository files, chapters, sections that carry distinct concepts, exercises, or source materials.

## Cumulative-source note

The modified Chapter 2, 3, 4, and 7 files are the current cumulative versions. They retain the accepted Phase 2 technical corrections in those same files. Apply this phase after Phase 2, as planned; do not replace these files with an older pre-Phase-2 snapshot.

## Build / post-check status

This change-only package contains source and change documentation. No new PDF is included. Per the requested delivery workflow, no post-delivery checks are run after the ZIP is assembled.
