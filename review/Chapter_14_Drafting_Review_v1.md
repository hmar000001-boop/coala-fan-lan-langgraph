# Chapter 14 drafting and implementation-bridge review v1.0

**Chapter:** Content Competition, Workspace and Broadcast: B3  
**Outline:** v1.0, approved by the author on 15 November 2026  
**Draft state:** Complete first chapter draft; final illustrated PDF remains dependent on the pinned Mermaid renderer in CI.

## 1. Theory-to-practice bridge

The approved outline was checked for an implementation gap before drafting. B3 is a runtime-control hypothesis with concrete implementation consequences, so the chapter includes a substantial engineering bridge rather than ending at mechanism description.

The bridge covers:

- A reference architecture separating candidate producers, validation, coalition formation, competition/admission governance, a bounded cycle workspace, immutable broadcast snapshots, consumer routing, feedback collection, outcome attribution, and versioned policy management.
- Typed Java-like contracts for candidate envelopes, content coalitions, workspace snapshots, consumer receipts, outcome attributions, and admission-policy snapshots.
- A state machine for collection, validation, formation, admission, broadcast, consumption, attribution, policy evaluation, expiry, and no-admission/delivery-failure exits.
- Persistent audit and feedback state separated from the short-lived workspace; concurrency, version checks, idempotency, and bounded resource handling.
- Safety boundaries: broadcast availability does not authorize external action; candidate provenance and privacy scope remain attached; consumer access is independently checked; low-confidence attribution does not trigger immediate policy promotion.
- A Product X payment-timeout example, vertical-slice implementation sequence, pseudocode, failure cases, tests, evaluation baselines, metrics, ablations, and falsification criteria.

These are engineering proposals developed for the book. They are not represented as schemas, scoring equations, or production components supplied by LIDA or Fan and Lan.

## 2. Source-fidelity boundaries

The draft preserves the following distinctions:

1. Fan and Lan's B3 is a residual hypothesis connecting typed-content competition, bounded shared workspace, cycle-scoped broadcast, and downstream-outcome-dependent admission.
2. LIDA's historical competitors are coalitions of specialized codelets. The chapter does not retrofit modern JSON records into LIDA's architecture.
3. GWA is treated as the closest structural workspace/broadcast baseline; its E2/D3 classification is not collapsed into an overall quality score.
4. DyLAN selects agent teams and adaptive graph pruning selects graph nodes/edges. Their E3/D4 classification does not mean they select B3-style content coalitions.
5. E (evidence relation) and D (migration depth) remain separate classification axes.
6. The chapter retains the paper's falsification logic: reject or narrow B3 if outcome-trained content admission adds no value over GWA-style selection or simpler top-k retrieval under comparable resource constraints.
7. The chapter distinguishes selected, admitted, broadcast, consumed, used, and helpful. No one event is treated as proof of the next.

## 3. Figure/source coverage

Eight Mermaid sources are stored under `Tex/diagrams/source/part2/chapter14/`. Each has `accTitle` and `accDescr` metadata and a corresponding `\BookDiagram` placement in the chapter:

- `lida-competition-broadcast-cycle.mmd`
- `modern-baseline-object-map.mmd`
- `what-competes.mmd`
- `productx-workspace-coalition.mmd`
- `b3-reference-architecture.mmd`
- `b3-workspace-state-machine.mmd`
- `b3-outcome-learning-loop.mmd`
- `b3-evaluation-and-ablation.mmd`

The local environment does not have the pinned Mermaid CLI installed and cannot currently resolve the npm registry. No placeholder or hand-drawn PNG is represented as a real Mermaid render. Actual generation, dimension/PNG validation, and print-size figure inspection remain part of the CI release gate.

## 4. Chapter 13 diagram CI fix

The reported failure named `Tex/diagrams/source/part2/chapter13/b2-reference-implementation.mmd` as not referenced by Chapters 1–13. The chapter had a direct/manual figure inclusion, but the validator intentionally recognizes the shared `\BookDiagram` macro as the authoritative source-to-chapter link. The figure is now included through `\BookDiagram` in `Tex/part2/chapter13/chapter.tex`.

The validator was not weakened. It already scans Chapters 1–14 and continues to check that every `.mmd` source is accessible, has a matching generated PNG, is referenced by a chapter, and that no generated PNG is orphaned. The chapter build loop and standalone entry now include Chapter 14.

## 5. Local validation and remaining CI gate

Source-level checks include the repository scaffold, exact Chapter 14 figure/source correspondence, bibliography-key existence, glossary-key existence, and shell syntax validation. The local environment cannot execute the full `check-diagrams.sh` success path until the pinned Mermaid CLI generates valid high-resolution PNGs for every source. GitHub Actions must run the render step before diagram validation and XeLaTeX compilation.

The local chapter PDF, if present, is explicitly a layout preview using labelled temporary placeholders and temporary Nimbus font substitutions. It is not the final illustrated chapter PDF. The shared author-supplied preamble remains unchanged.

### Local layout-proof result

A 39-page XeLaTeX layout preview was built and rendered. Cover, comparative baseline table, Java interface listing, implementation section, evaluation section, glossary, references, and index were visually checked. The final local preview log had no undefined-reference/citation messages, LaTeX errors, or overfull boxes. The preview's figure placements are visibly labelled placeholders; it must not be distributed as the final illustrated chapter. The book preamble was temporarily pointed to installed Nimbus OpenType font files solely for this proof and restored byte-for-byte afterward (SHA-256 `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`).

The repository scaffold check passes. A static parser mirroring the source-to-figure matching rule reports 61 Mermaid sources and 61 unique `\BookDiagram` references across 14 chapter files, with no orphan sources or missing source references. The full `check-diagrams.sh` still exits locally because all 61 generated PNGs are absent; the pinned Mermaid CLI is not installed here. Its output contains 61 missing-PNG errors and zero orphan/source-reference errors. CI must render before running the validator.
