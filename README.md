# From Cognitive Architectures to Production Agentic Systems

A source-disciplined technical book about CoALA, the mechanism-level analysis by Fan & Lan, and production-oriented agent engineering with Java.

## Current content status

- **Chapter 1 — Why Do Language Agents Need Cognitive Architectures?** Drafted and integrated; retains its approved manuscript content, with consistency and presentation updates.
- **Chapter 2 — The Architecture of CoALA.** Drafted and integrated from the reviewed outline.
- **Chapter 3 — Understanding Memory.** Drafted from its approved outline; source-fidelity review completed against CoALA §4.1 and Figure 4A; author review pending.
- **Chapter 4 — Internal Actions: Retrieval, Reasoning and Learning.** Drafted from its approved outline; source-fidelity review completed against CoALA §§4.3–4.5 and Figure 5 for the action boundary; author review pending.
- **Chapter 5 — External Actions and Grounding.** Drafted from its author-approved outline; source-fidelity review completed against CoALA §4.2, Figure 5, and the action-space safety discussion in §6; author review pending.
- **Chapter 6 — Planning: From a Problem to Candidate Actions.** Drafted from its author-approved outline; source-fidelity review completed against CoALA §4.6, Figure 4B, and the proposal discussion; author review pending.
- **Chapter 7 — Evaluation and Selection.** Outline v1.0 approved on 14 November 2026 and chapter drafted/integrated (approximately 3,377 words). The approved outline PDF and editable source remain in `Tex/part1/chapter07/outline/`.
- **Chapter 8 — Interleaving, Iteration and the Complete CoALA Decision Process.** Outline v1.0 approved on 14 November 2026 and chapter drafted/integrated (approximately 3,493 words). The approved outline PDF and editable source remain in `Tex/part1/chapter08/outline/`.
- Chapters 9–10 have approved outline v1.0 PDFs and editable LaTeX sources stored inside their matching chapter folders. Both chapters are drafted and integrated (approximately 4,259 and 3,921 words). Their source and drafting reviews are recorded under `review/`.
- **Chapter 12 — Understanding Activation, Retrieval Latency, and Utility: B1.** Substantive chapter redraft prepared from the author's review report and the Fan & Lan source audit. Active outline v3 is retained as Markdown with matching chapter-local LaTeX and review-PDF artifacts; v2 remains preserved as a checkpoint. The chapter includes the B1 baseline set, three Mermaid source diagrams, footnote-style citations, shared glossary/index entries, a source/example note, and an expanded standalone build.
- **Chapter 13 — Understanding Typed Impasses, Substates and Compilation: B2.** Drafted against revised outline v2.0 after an explicit theory-to-implementation bridge audit; includes typed recovery contracts, a protected recovery state machine, dependency-aware compilation governance, and a Product X walkthrough.
- **Chapter 14 — Content Competition, Workspace and Broadcast: B3.** Drafted after the author's approval of outline v1.0; includes the LIDA/GWA/DyLAN/graph-pruning comparison and a substantial implementation proposal for typed content admission, bounded workspace, broadcast, consumer receipts, outcome attribution and policy learning. Eight accessible Mermaid source diagrams are included.
- **Chapter 15 — Persistent Intentions, Reconsideration and Method Authority: B4.** Outline v1.0 was approved on 15 November 2026 after one source-fidelity/minor-issue review pass. The chapter is now drafted and integrated. It distinguishes BDI commitment-termination policies from reconsideration schedules; explains MIDCA meta-control separately from BDI commitment; compares the reviewed modern baselines; and proposes typed intention/method contracts, goal-versus-method authority, a lifecycle state machine, durable concurrency-safe transitions, bounded delegation, anti-oscillation controls, a Product X method switch, and the Appendix D evaluation protocol. Seven accessible Mermaid sources are included. The real diagram render and production-font PDF gate remain CI-dependent.
- Chapters 1–17 each have an independent LaTeX entry point under `Tex/standalone/` and can be compiled as separate review PDFs after Mermaid rendering. Chapters 12–17 use the same render-before-compile requirement as the rest of the book.

## Author-supplied preamble

`Tex/preamble.tex` is based on the author's supplied preamble and is loaded once by `Tex/main.tex`. It retains the `book` class, XeLaTeX/fontspec setup, 7 × 10 inch double-sided page layout, typography, colors, heading styles, headers/footers, code listings, reusable teaching boxes, and source-layout tree. It adds a shared `\BookDiagram` figure macro and balanced figure-float settings; TikZ was removed after diagrams migrated to Mermaid-rendered PNGs. Keep this file intact until the author approves a later cleanup pass.

Book-wide citation macros, glossary setup, bibliography integration, additional reusable environments, and book-level PDF metadata are layered in `Tex/shared-macros.tex`. Chapters should use these shared definitions rather than introducing chapter-local replacements.

## Build

The authoritative entry point is `Tex/main.tex`. The repository uses the author's known-working GitHub Actions route: `xu-cheng/texlive-action@v2`, `scheme: full`, XeLaTeX through `latexmk`, and a PDF artifact. Pushes and pull requests build the full book; pushes of `v*` tags also publish the compiled PDF to GitHub Releases.

The workflow compiles the combined book PDF. Individual Chapter 1–15 review PDFs can be built with `scripts/build-chapters.sh`; part entry points are available at `Tex/part0/main.tex` through `Tex/part3/main.tex`.

Required tools are XeLaTeX, latexmk, Biber, makeglossaries, makeindex, Node.js 22.13 or later, npm, Chromium/Puppeteer dependencies, and the TeX packages referenced by the preamble and shared macros. The GitHub workflow installs Node 24, the TeX Gyre browser fonts, the pinned Mermaid CLI, and the full TeX Live scheme.

The Mermaid CLI is pinned to version 12.2.0 in `tools/mermaid/package.json` and requires Node.js 22.13 or later. CI installs Node 24, renders all `.mmd` sources to high-resolution PNGs using the shared Mermaid theme, validates their dimensions and chapter references, and only then starts XeLaTeX. Generated PNGs are intentionally excluded from source control and are also uploaded as a separate CI artifact for visual inspection. The npm CLI package is directly version-pinned to 12.2.0. A dependency-tree lockfile is not committed yet because the build environment used for this batch could not resolve the npm registry; transitive dependencies therefore remain less reproducible than the direct CLI version.

Install the Mermaid renderer once for a local build, then render and compile:

```bash
npm install --prefix tools/mermaid --no-audit --no-fund
bash scripts/check-scaffold.sh
bash scripts/render-diagrams.sh
bash scripts/check-diagrams.sh
bash scripts/build-book.sh
```

The authoritative workflow renders all Mermaid sources referenced by Chapters 1–17 to PNG before LaTeX compilation. Chapter 11 has six, Chapter 12 has three, Chapter 13 has five, Chapter 14 has eight, Chapter 15 has seven, and Chapters 16 and 17 each have nine chapter-specific Mermaid sources; all use the shared renderer and figure macro. Committed `.mmd` files are editable sources; generated PNGs are build artifacts and are not committed. The real CLI render and visual figure inspection remain a required first-CI-run gate. Local pinned-CLI installation attempts during Chapters 12, 15, and 16 could not complete because the npm registry was unavailable, so no generated PNG is represented as validated in this package.

To regenerate the Chapter 3–15 outline review PDFs from their chapter-local LaTeX sources (run from the repository root):

```bash
bash scripts/build-outlines.sh
```

The outline sources deliberately load the shared production preamble; every outline artifact is stored in its corresponding chapter folder. Chapters 1–2 retain their legacy approved outline formats; Chapters 3–15 retain their historical editable LaTeX outline sources and review PDFs. Beginning with Chapters 16 and 17, the author changed the review format to one canonical Markdown outline only; no outline PDF or LaTeX wrapper/body is created. Chapters 9–17 have completed source drafts, with chapter-by-chapter author approval records. Chapter 15's original outline PDF remains the frozen v1.0 review snapshot; its separate approval record documents the author's approval on 15 November 2026.

To build Chapters 1–17 separately:

```bash
bash scripts/build-chapters.sh
```

## Current batch status: Batch 6 — Chapter 15 (B4) drafted

The author approved Chapter 15 Outline v1.0 on 15 November 2026 and instructed one minor-issue review pass followed immediately by drafting. The complete source repository was recovered from the Library archive and verified before modification; its original repository root is preserved in the updated delivery archive. The substantive Chapter 15 draft is integrated at `Tex/part2/chapter15/chapter.tex`, with an independent build entry at `Tex/standalone/chapter15.tex`. Approval, source-fidelity, drafting, and batch checkpoint records are stored under `Tex/part2/chapter15/outline/` and `review/`.

The chapter preserves the distinctions between commitment policy and reconsideration schedule, BDI commitment and MIDCA meta-control, and goal authority, method authority, and model proposal authority. The practical bridge covers typed contracts, intention lifecycle, reconsideration events, persistence/concurrency, external side-effect safety, delegation/suspension, anti-oscillation, implementation sequencing, tests, and source-required evaluation/ablations. The Product X example switches from a write-oriented payment flow to read-only reconciliation without changing the authorized goal.

Seven original Mermaid sources with `accTitle` and `accDescr` are included and referenced in the chapter. The pinned Mermaid CLI 12.2.0 could not be installed in the local environment because the npm installation timed out. No fabricated PNGs are committed. A separate 61-page layout preview was compiled with temporary Noto substitutes and clearly labelled layout-only cards at all seven figure positions; its full-page contact sheet and representative tables, code listings, glossary and index pages were visually inspected. It is not a final illustrated chapter PDF. Real high-resolution Mermaid rendering, PNG integrity checks, printed-size figure inspection, and the full production-font PDF remain CI release gates. The author-supplied `Tex/preamble.tex` has been restored byte-for-byte.

## Current batch status: Batch 7 — Chapter 16 (B6) drafted

Chapter 16 is the standalone Batch 7 mechanism study under the approved nine-batch Part II plan. Its sole active review outline is Markdown-only at `Tex/part2/chapter16/outline/Chapter_16_Outline_v1.md`; the conformance audit found no need to change its scope. Chapter 17 remains the separate B5/GraSP closed-candidate case, and Chapter 18 remains reserved for synthesis after Chapters 9–17 are completed and reviewed.

The B6 bridge covers EPIC and Sigma as historical foundations, the modern resource and uncertainty baselines, an uncertainty-lineage contract, typed resource vectors, scheduling, tool authorization, preemption, interruption, cancellation, stopping, Java-like contracts, persistence/concurrency, a Product X worked example, the source-required trace/outcomes/three distinct ablations, and falsification criteria. The E3 and D3 labels remain independent. Nine accessible Mermaid sources are committed.

A local 61-page layout-only PDF was compiled with temporary Noto font substitutes and watermarked placeholder panels solely to inspect typography, tables, code listings, footnotes, references, glossary, and index. The placeholders were not real diagram renders and are not retained in the repository or delivery archive. XeLaTeX, Biber, glossary and index processing completed without unresolved citations/references on the final local pass; the shared preamble was restored byte-for-byte. Real Mermaid 12.2.0 rendering, generated-PNG validation, printed-size diagram review, and production-font compilation remain CI gates. `scripts/check-diagrams.sh --sources-only` verifies source accessibility metadata and chapter references without pretending that PNG outputs exist; the normal check still requires real rendered PNGs.

## Source discipline

Part I uses the original CoALA paper as its theoretical source. Part II treats Fan & Lan as a separate contribution; it is not used to reinterpret CoALA. Book-created examples and engineering decisions are identified as such, not attributed to the papers. The two formal paper labels are `[CoALA]` and `[Fan & Lan]`.

The PDF target is standard PDF; this project does not claim PDF/UA or tagged-PDF conformance.

## Repository setup

Create the public GitHub repository named `cognitive-architectures-to-production-agents`, extract this archive, and push the repository contents manually. No remote or Git history is embedded in this archive.


## Current batch status: Chapters 5–6 drafted

The author approved both outlines on 14 November 2026. The approved outline PDFs and their LaTeX sources remain in `review/`. The source map and boundary review are recorded in `review/Batch_05-06_Source_Review.md`; drafting, source-fidelity, and consistency notes are recorded in `review/Batch_05-06_Drafting_Review.md`. Chapters 5 and 6 are integrated into Part I and have independent build entry points. Their approved outlines are stored in their matching chapter folders, with index copies under `review/`. Eight additional Mermaid sources are stored under the two chapter-specific source directories. The actual Mermaid PNG rendering and printed-size figure inspection must be verified by the first GitHub Actions run because this local environment cannot resolve the npm registry.


## Current batch status: Chapters 7–8 drafted

The author approved both outlines on 14 November 2026 after a final review for minor issues. Chapter 7 is grounded in CoALA §4.6, especially the Evaluation and Selection sub-stages (pp. 12–13). It preserves the distinction that evaluation assigns values while selection chooses or rejects; rejection and return to proposal are placed under selection. Chapter 8 is grounded in CoALA §4.6 and Figure 4B. It explains the repeated planning/execution cycle, flexible use of reasoning and retrieval, interleaving and iteration as carefully marked teaching interpretations, internal simulation and candidate improvement, selection rejection, and execution. The paper does not define one universal planning schedule. Both approved outline sources and PDFs remain inside their corresponding chapter folders, with synchronized index copies under `review/`. Nine Mermaid sources have been added; the real rendering and print-size inspection must be confirmed by GitHub Actions because the local npm registry is currently unreachable.


## Outline location convention

All outline artifacts are stored within their matching chapter directory. Chapters 1 and 2 retain their original approved legacy artifacts (Chapter 1 Markdown outline; Chapter 2 review PDF). Chapters 3–8 retain editable LaTeX outline sources and review PDFs in `Tex/part1/chapterNN/outline/`. Chapters 9–15 use the same convention in `Tex/part2/chapterNN/outline/`; Chapters 12 and 15 additionally preserve their Markdown outlines. The scaffold check enforces the presence of the outline PDF/source pair and verifies that prose exists only after outline approval.


## Earlier batch checkpoints: Chapters 9–10 drafted

- Both outlines were approved by the author on 14 November 2026 after a final minor-issue review. The `.tex` sources and approval-record PDFs remain in `Tex/part2/chapter09/outline/` and `Tex/part2/chapter10/outline/`.
- Chapter 9 — *Why Feature-Level Descriptions Are Not Enough* is drafted in `Tex/part2/chapter09/chapter.tex`. It introduces the documented mechanism as the unit of analysis, feature labels versus operational mechanisms, the independence of evidence relation and migration depth, the node--edge--invariant claim test, and the review's bounded validity claims.
- Chapter 10 — *The Seven Fields of a Mechanism* is drafted in `Tex/part2/chapter10/chapter.tex`. It teaches the exact tuple `K = <S,C,T,P,F,L,R>` and applies it to the ACT-R record in Fan & Lan's Appendix A without filling undocumented fields.
- Eight Mermaid sources were added (four per chapter). At that earlier Chapter 9–10 checkpoint, the repository contained 45 Mermaid sources across Chapters 1–11. The current repository contains 68 Mermaid sources, all referenced by Chapters 1–15; the scaffold and chapter-specific checks include Chapter 15.
- The Chapter 11 source and attribution record is in `review/Chapter_11_Source_Review.md`; drafting and quality notes are in `review/Batch_11_Drafting_Review.md`.
- The local npm registry could not be resolved during this batch, so real Mermaid PNG rendering and final figure inspection remain a first-GitHub-Actions-run gate. Disposable placeholder-image LaTeX tests are not represented as real Mermaid renders.


### Chapters 9–10 final drafting verification

Both chapters were drafted after individual outline approval and received a final source-fidelity review. Their standalone layout tests passed (22 pages for Chapter 9 and 20 pages for Chapter 10) using temporary PNG placeholders and temporary local font substitutions only. Those outputs are not final illustrated chapter PDFs. The original author-supplied preamble was restored and its SHA-256 verified against the base repository. The actual Mermaid CLI installation failed locally because `registry.npmjs.org` could not be resolved (`EAI_AGAIN`); real PNG generation and printed-size figure inspection remain mandatory in GitHub Actions.


## Current batch status: Chapter 12 revised for Part II production compliance

- Chapter 12 — *Understanding Activation, Retrieval Latency, and Utility: B1* has been redrafted under the author's instruction of 14 November 2026. The active outline is v3 and remains available as Markdown, with a matching chapter-local LaTeX outline source and review PDF; v2 is preserved as an earlier checkpoint.
- The revised source adds the full B1 comparison set named by Fan & Lan: AgeMem, Memory-R1, MemCon, DeltaMem, A-MAC, CURATOR, and DAM. It carefully distinguishes executable adaptive baselines from the conceptual comparator and identifies CURATOR as the closest value--cost comparator. The novelty boundary remains the coupling of activation/accessibility, predicted retrieval latency, downstream action utility, and maintenance cost at context assembly.
- Three accessible Mermaid source diagrams now cover the distinct memory lifecycle decisions, B1 context assembly and feedback, and the event-evidence chain. They use `accTitle` and `accDescr`, the shared Mermaid theme, and the `\\BookDiagram` placement macro. The generated PNGs are CI build artifacts and are not represented as locally rendered or validated because the local pinned-CLI installation attempt timed out.
- Comparative citations use the shared footnote-style citation route. The chapter now includes Fan & Lan source trace notes, shared glossary entries and first-use references, index entries, and glossary/index output in the standalone build.
- The source-level chapter and diagram pipeline are prepared for the GitHub Actions render/build. The only local Chapter 12 PDF in this package is explicitly named `Chapter_12_LAYOUT_PREVIEW_NOT_FINAL.pdf`; it contains visible layout placeholders, not Mermaid figures, and uses temporary font substitutions. No file is presented as the final illustrated Chapter 12 PDF. The authoritative PDF must be rebuilt after the real Mermaid CI render and all three diagrams must be inspected at print size.
- Chapter 13 — *Understanding Typed Impasses, Substates and Compilation: B2* — has been revised to outline v2.0 after an explicit theory-to-implementation bridge audit. The author then directed that writing begin after the revision. The completed chapter source, standalone build entry, outline Markdown, editable LaTeX outline wrapper/body and outline review PDF are integrated in the matching chapter folder.
- Chapter 13 preserves Soar's native operator-selection impasse semantics and Fan & Lan's B2 residual hypothesis as separate layers. Its practical bridge specifies component responsibilities, typed contracts, a guarded recovery state machine, persistence/concurrency, idempotency and side-effect controls, typed result validation, dependency-aware rule compilation/governance, a vertical-slice sequence, pseudocode and implementation tests.
- Five accessible Mermaid source diagrams are included. The local pinned Mermaid CLI is unavailable, so real PNG generation and visual inspection remain first-CI-run gates. `Tex/Output/Chapter_13_LAYOUT_PREVIEW_NOT_FINAL.pdf` is a 43-page layout proof with conspicuously labelled temporary placeholders, not the final illustrated PDF. Chapter 12's separate real-diagram release gate remains open as well.


### Chapter 11 standalone layout validation

A standalone XeLaTeX smoke build produced a 43-page, 7 × 10 inch PDF with bibliography, glossary, and index. Text extraction and page rendering completed; representative table, warning-box, recap, and end-matter pages were inspected. The local build used temporary Nimbus font substitutes and conspicuously marked placeholder PNGs only to test LaTeX integration and page layout. Those Chapter 11 smoke-build outputs are not final illustrated chapter PDFs and are not included as chapter deliverables. The original author-supplied `Tex/preamble.tex` was restored and its SHA-256 verified as `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`. The actual Mermaid CLI could not run locally because `registry.npmjs.org` was not resolvable; the first GitHub Actions run must generate and visually validate the real PNG figures.


### Part II Batch 4 — Chapter 13 (B2) drafted against revised outline v2.0

- The author requested an implementation-bridge audit and explicitly instructed that chapter writing begin after revising the outline, without a second approval pause. Outline v2.0 adds the concrete implementation architecture and is stored as Markdown with editable LaTeX wrapper/body and a review PDF in `Tex/part2/chapter13/outline/`.
- Chapter 13 is drafted in `Tex/part2/chapter13/chapter.tex` and has an independent entry point at `Tex/standalone/chapter13.tex`. The drafting review and source-fidelity review are stored in `review/`.
- Five Mermaid source diagrams have accessibility titles/descriptions and use the shared rendering theme. The local environment does not contain the pinned Mermaid CLI, so the chapter's final illustrated-PDF gate remains CI-dependent; placeholder previews, if included, are not final PDFs.
- The implementation bridge includes typed records, component contracts, state transitions, parent-state versioning, transactional/side-effect safeguards, result validation, dependency-aware rule compilation, rollback, implementation tests and an evaluation plan. These are explicitly labelled as book-level engineering proposals rather than source-paper implementations.


### Part II Batch 5 — Chapter 14 (B3) drafted after outline approval

- Chapter 14 — *Content Competition, Workspace and Broadcast: B3* — was approved by the author on 15 November 2026. The approved outline v1.0 remains in Markdown with chapter-local editable LaTeX wrapper/body and a review PDF in `Tex/part2/chapter14/outline/`.
- The theory-to-practice bridge is substantial because B3 is a runtime-control hypothesis. The chapter specifies typed candidates and coalitions, a competition governor, a bounded cycle workspace, immutable broadcast snapshots, consumer receipts, outcome attribution, admission-policy versioning, state transitions, concurrency/persistence, safety boundaries, Product X walkthrough, vertical-slice implementation plan, tests, baselines, metrics, ablations and falsification.
- Source boundaries remain explicit: LIDA's competitors are codelet coalitions; B3's proposed candidates are typed content coalitions. GWA is the bounded-workspace/broadcast structural baseline (E2/D3), while DyLAN and adaptive graph pruning demonstrate learned agent/team or communication-edge admission (E3/D4), not typed-content workspace admission. E and D remain separate axes. Engineering schemas and policies are labelled as book proposals, not as mechanisms already implemented by LIDA or Fan & Lan.
- Chapter 14 prose is drafted in `Tex/part2/chapter14/chapter.tex` and has a standalone build entry at `Tex/standalone/chapter14.tex`. Eight accessible Mermaid sources are included under `Tex/diagrams/source/part2/chapter14/`; each source has a chapter figure placement and `accTitle`/`accDescr` metadata.
- The Chapter 13 diagram CI issue was fixed at its source: `b2-reference-implementation.mmd` is included through the shared `\BookDiagram` macro, which the validator recognizes. `scripts/check-diagrams.sh` validates Chapters 1–15, and the chapter build loop includes Chapter 15. The check was not weakened.
- Local Mermaid rendering remains blocked because the pinned Mermaid CLI is not installed and the npm registry cannot currently be resolved in this environment. Generated PNGs are intentionally not fabricated or committed. GitHub Actions must render the eight Chapter 14 diagrams (and all prior sources) before the full diagram and PDF build can pass. The local chapter PDF, where included, is explicitly a layout preview with labelled placeholders, not the final illustrated PDF.
- The shared preamble is unchanged. Temporary Nimbus OpenType substitutions may be used only for a local layout proof; the repository's CI is authoritative for TeX Gyre fonts and actual Mermaid rendering.


## CI correction and current outline review — 15 November 2026

- The Batch 6 diagram-render failure was traced to `Tex/diagrams/source/part2/chapter15/productx-method-switch-sequence.mmd`. Three semicolons in sequence-message text were interpreted by Mermaid as statement separators; the messages now use ordinary punctuation while preserving their meaning.
- `scripts/check-diagrams.sh` now includes a source-level regression guard that rejects semicolons in Mermaid `sequenceDiagram` instruction lines, while allowing normal prose in `accTitle` and `accDescr`. This supplements, and does not weaken, the existing PNG integrity and chapter-reference checks.
- The repository's pinned Mermaid CLI could not be installed in the local environment because `registry.npmjs.org` DNS resolution failed. The corrected source and static checks are included, but the complete render has **not** been locally executed. GitHub Actions must be rerun to confirm all real PNGs render successfully; no placeholder PNGs were created.
- Chapter 16 — *Uncertainty, Resources, Interruption and Stopping: B6* — is Batch 7 of the author's nine-batch Part II plan. Its sole review outline is `Tex/part2/chapter16/outline/Chapter_16_Outline_v1.md` (Markdown only). The author asked for a conformance audit and immediate drafting on 15 November 2026; the outline conforms without structural change and its authorization record is updated. The complete LaTeX chapter is integrated at `Tex/part2/chapter16/chapter.tex`, with an individual build entry at `Tex/standalone/chapter16.tex`.
- Chapter 16's implementation bridge covers EPIC and Sigma, uncertainty provenance and calibration, typed resource vectors, scheduling, action authorization, preemption, interruption, cancellation, stopping, durable state, concurrent reservations, recovery, and evaluation. Nine accessible Mermaid sources are committed under `Tex/diagrams/source/part2/chapter16/`; CI is responsible for generating their PNGs.
- The Batch 6 CI failure in `productx-method-switch-sequence.mmd` was corrected by removing semicolons from sequence-message text. `scripts/check-diagrams.sh` also rejects that failure pattern. Static checks can validate this rule locally, but the pinned Mermaid 12.2.0 full rendering must be confirmed by GitHub Actions when the npm package is available.
- Chapter 17 remains the standalone Batch 8 treatment of the B5/GraSP closed candidate. Chapter 18 remains reserved for the final synthesis after Chapters 9–17 are completed and reviewed.
- The Chapter 16 outline concludes that B6 needs a substantial practical bridge: a calibrated uncertainty state must propagate across inference, memory admission, planning, tool authorization, execution monitoring, resource allocation, interruption and stopping. The chapter will distinguish the historical EPIC and Sigma mechanisms, the partial modern baselines, Fan & Lan's E3/D3 residual hypothesis, and book-proposed Java contracts and runtime controls. It preserves the source's evaluation trace, outcome metrics, three ablations and falsification conditions.

## Current batch status: Batch 8 — Chapter 17 (B5 / GraSP) drafted

Chapter 17 is the standalone Batch 8 special methodological case in the author's approved nine-batch Part II plan. Outline v1.0 was approved on 15 November 2026 after one minor-issue review pass. The single canonical outline remains Markdown-only at `Tex/part2/chapter17/outline/Chapter_17_Outline_v1.md`; the chapter itself is authored in LaTeX at `Tex/part2/chapter17/chapter.tex` and has an individual entry point at `Tex/standalone/chapter17.tex`.

The chapter explains why B5 is a closed candidate rather than a sixth residual hypothesis. It reconstructs the calibrated multi-skill routing, typed verification, bounded repair, and planner-fallback chain; explains GraSP's memory-conditioned retrieval, typed DAG compilation, node-level pre/postcondition verification, five local repair operators, escalation, confidence routing, experimental results, and stated limits; and preserves Fan & Lan's E3/D4 coding as two independent axes. Its Java contracts, graph lifecycle, patch validation, persistence assumptions, observability, tests, and vertical-slice plan are book-level engineering reconstructions, not claims that the book has reproduced GraSP's source code or experiments.

Nine accessible Mermaid sources are committed under `Tex/diagrams/source/part2/chapter17/`. The shared renderer generates PNGs in CI; no placeholder or mocked diagram is represented as a validated render. The standalone XeLaTeX/Biber build, source-level Mermaid validation, scaffold checks, and text/PDF inspection are performed locally where available. The real Mermaid 12.2.0 renderer and production-font full-book build remain authoritative CI gates. Chapter 18 remains a placeholder reserved for Batch 9 synthesis after Chapters 9–17 are complete and reviewed.


### Chapter 17 local validation checkpoint — 15 November 2026

Chapter 17's standalone 63-page layout preview was compiled with Biber, glossary, and index using temporary Noto OpenType substitutes because the local environment does not provide the production TeX Gyre OpenType files. Its PDF text extraction and representative-page visual inspection passed; the final local LaTeX log has no undefined citations/references, no LaTeX errors, and no horizontal overfull boxes. The shared production preamble was restored byte-for-byte (SHA-256 `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`). Source-only checks pass for 86 Mermaid diagrams and all Chapter 1–17 figure references. The nine temporary layout panels are not included in the source archive. Actual Mermaid 12.2.0 rendering and the production-font build remain GitHub Actions release gates; the local PDF is a layout preview, not the final illustrated PDF.
