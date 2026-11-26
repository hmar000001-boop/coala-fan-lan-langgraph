# Front Matter and Technical Appendices Revision

**Date:** 26 November 2026  
**Scope:** Preface, How to Read This Book, and four balanced technical appendices (A-D).

## Scope preserved

Only the seven authoritative LaTeX files below were changed:

- `Tex/part0/frontmatter/preface.tex`
- `Tex/part0/frontmatter/reading-guide.tex`
- `Tex/appendices/content.tex`
- `Tex/appendices/appendix-a-architecture.tex` (added)
- `Tex/appendices/appendix-b-build-and-configuration.tex` (added)
- `Tex/appendices/appendix-c-persistence.tex` (added)
- `Tex/appendices/appendix-d-testing-and-evidence.tex` (added)

The canonical build entry point remains `Tex/main.tex`. The legacy root-level duplicate appendix/frontmatter directories were not altered. Parts I, II, and III were not modified. The separate Java application repository was not modified.

## What changed

### Preface

- Explains the book's motivation and the distinct intellectual roles of CoALA and Fan and Lan's mechanism review.
- Explains the three-part progression from architecture, to mechanism analysis, to a coherent Java reference application.
- States the implementation scope: selected engineering counterparts for B1, B2, B3, B4, and B6; no claim to implement B5/GraSP or reproduce every source mechanism in full.
- Distinguishes planning algorithms from LangGraph4j orchestration and the LangChain4j model adapter boundary.
- Clarifies that “production” in the title refers to production-oriented engineering concerns, not a claim of live deployment or universal production readiness.
- Separates research claims, teaching examples, engineering decisions, and test evidence.

### How to Read This Book

- Establishes a sequential learning path through Chapters 1-24.
- Defines the intended audience and prerequisites without requiring prior CoALA or Fan and Lan knowledge.
- Gives a repeatable approach for reading chapter outcomes, diagrams, code excerpts, tests, and exercises while acknowledging that chapter closing features vary.
- Explains the difference between research claims, teaching examples, engineering decisions, and test evidence.
- Distinguishes Fan and Lan's B-labels from project M0-M8 milestone/workstream labels.
- Separates planning strategies from orchestration/model frameworks.
- Explains pinned source links, QR references, and the role of appendices A-D.

### Appendix A — Application Repository and Architecture

- Maps the eleven Maven modules to their principal responsibilities.
- Provides a conceptual responsibility crosswalk and recommended code-reading path.
- Clarifies the difference between mechanism labels, project milestone labels, planning algorithms, and runtime frameworks.

### Appendix B — Build, Configuration, and Verification

- Records the Java/Maven toolchain and selected pinned dependency/plugin versions from the supplied project snapshot.
- Documents the ordinary reactor build and PostgreSQL-gated test command.
- Summarizes the CI workflow and environment settings.
- Provides a local command sequence for the configured `Phase0Application` intake smoke example.
- Explicitly distinguishes that smoke example from the complete durable cognitive-cycle host.
- Includes secret-handling and deployment-caution notes.

### Appendix C — Memory, Runtime State, and Persistence

- Distinguishes CoALA memory, planner artifacts, graph checkpoints, mechanism-specific records, action ledgers, and the simulated world.
- Maps important state categories to their owners and persistence adapters.
- Explains why a graph checkpoint is not CoALA memory.
- Preserves important implementation limits: B3 workspace snapshots are ephemeral in the durable host; B6 calibration-profile persistence is optional and distinct from assessment-revision persistence; the budget ledger is separate; PostgreSQL does not provide a general repository for the full simulated world; action reconciliation is not an atomic transaction with an external side effect.

### Appendix D — Testing, Evidence, and Source Traceability

- Distinguishes domain, simulator, unit, graph/workflow, PostgreSQL integration, durable-host end-to-end, CI, and empirical evidence.
- Identifies representative test-tree locations.
- Explains PostgreSQL-gated testing and what a green CI run does and does not establish.
- Clarifies that the REQ-09 durable-host path does not itself prove B2 child-investigation coverage; that branch has separate graph/workflow evidence.
- Records the commit pin used by the source URLs in Chapters 20-24.

## Source checks

The technical appendix content was checked against the supplied `supply-chain-agent` application archive, including its root Maven configuration, eleven module POMs, `.env.example`, CI workflow, application host/configuration classes, PostgreSQL persistence adapters, and representative test classes.

Specific repository boundaries were preserved rather than generalized:

- `Phase0Application` is a deterministic intake smoke entry point using an in-memory saver; it is not the complete durable host.
- `DurableCognitiveApplicationHost` is assembled with application-supplied ports.
- The durable host's B3 workspace snapshots use an in-memory repository, while broadcast receipts and downstream outcome evidence are stored separately.
- The optional B6 calibration-profile repository is not a general store of all uncertainty assessment revisions.
- The simulator/world adapter is supplied separately; a graph checkpoint or action ledger does not establish that the complete world state survives process restart.
- REQ-09 evidence and the separate B2 full-graph evidence are not conflated.

## Validation

| Check | Result |
|---|---|
| Repository scaffold | Passed: Parts I, II, and III count as 8, 10, and 6 chapters |
| Source QR validation | Passed: 35 QR assets match commit-pinned links |
| Mermaid source/reference validation | Passed: 131 sources/references |
| Front matter isolated XeLaTeX check | Passed: 9-page validation PDF |
| Appendices isolated XeLaTeX check | Passed: 16-page validation PDF; no overfull-box warnings after table fixes |
| Visual spot-check | Passed for the isolated front matter and appendix renders; table-column overprinting was corrected |
| Full-book build | Not completed: the build script reports that Mermaid CLI (`mmdc`) is not installed |

### Font qualification

The container does not have the book's configured TeX Gyre OpenType fonts available to XeLaTeX. For isolated syntax/layout validation only, a temporary copy of the project used Liberation Serif/Sans/Mono. The actual project's `Tex/preamble.tex` was not changed, and no substituted-font PDF is presented as the final book PDF. Final rendering with the book's configured fonts and generated Mermaid diagrams remains necessary.

## Change boundary

A checksum comparison against the cleaned baseline book archive found exactly three modified authoritative files and four new appendix files listed above. No chapter files, Parts I-II, Part III Chapters 19-24, application source, Maven configuration, tests, CI, or database migrations were changed.
