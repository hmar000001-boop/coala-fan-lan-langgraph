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
- **Chapter 12 — Understanding Activation, Retrieval Latency, and Utility: B1.** Substantive chapter redraft prepared from the author's review report and the Fan & Lan source audit. Active outline v3 is retained as Markdown and has matching chapter-local LaTeX and review-PDF artifacts; v2 remains preserved as a checkpoint. The chapter includes the B1 baseline set, three Mermaid source diagrams, footnote-style citations, shared glossary/index entries, a source/example note, and an expanded standalone build.
- Chapters 1–12 each have an independent LaTeX entry point under `Tex/standalone/` and can be compiled as separate review PDFs after Mermaid rendering. Chapter 12 adds three Mermaid figures and therefore follows the same render-before-compile requirement as the rest of the book.

## Author-supplied preamble

`Tex/preamble.tex` is based on the author's supplied preamble and is loaded once by `Tex/main.tex`. It retains the `book` class, XeLaTeX/fontspec setup, 7 × 10 inch double-sided page layout, typography, colors, heading styles, headers/footers, code listings, reusable teaching boxes, and source-layout tree. It adds a shared `\BookDiagram` figure macro and balanced figure-float settings; TikZ was removed after diagrams migrated to Mermaid-rendered PNGs. Keep this file intact until the author approves a later cleanup pass.

Book-wide citation macros, glossary setup, bibliography integration, additional reusable environments, and book-level PDF metadata are layered in `Tex/shared-macros.tex`. Chapters should use these shared definitions rather than introducing chapter-local replacements.

## Build

The authoritative entry point is `Tex/main.tex`. The repository uses the author's known-working GitHub Actions route: `xu-cheng/texlive-action@v2`, `scheme: full`, XeLaTeX through `latexmk`, and a PDF artifact. Pushes and pull requests build the full book; pushes of `v*` tags also publish the compiled PDF to GitHub Releases.

The workflow compiles the combined book PDF. Individual Chapter 1–12 review PDFs can be built with `scripts/build-chapters.sh`; part entry points are available at `Tex/part0/main.tex` through `Tex/part3/main.tex`.

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

The authoritative workflow renders all 48 Mermaid sources for Chapters 1–12 to PNG before LaTeX compilation. Chapter 11 has six and Chapter 12 has three chapter-specific Mermaid sources and uses the shared renderer and figure macro. Committed `.mmd` files are editable sources; generated PNGs are build artifacts and are not committed. The real CLI render and visual figure inspection remain a required first-CI-run gate; a local Mermaid CLI install attempt during the Chapter 12 revision timed out, so no generated PNG is represented as validated in this package.

To regenerate the Chapter 3–12 outline review PDFs from their chapter-local LaTeX sources (run from the repository root):

```bash
bash scripts/build-outlines.sh
```

The outline sources deliberately load the shared production preamble; every outline artifact is stored in its corresponding chapter folder. Chapters 1–2 retain their legacy approved outline formats; Chapters 3–12 have editable LaTeX outline sources and review PDFs. Chapter 12 retains its Markdown plan as well. Chapters 9–12 have author-directed outline revisions and completed source drafts.

To build Chapters 1–12 separately:

```bash
bash scripts/build-chapters.sh
```

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

All outline artifacts are stored within their matching chapter directory. Chapters 1 and 2 retain their original approved legacy artifacts (Chapter 1 Markdown outline; Chapter 2 review PDF). Chapters 3–8 retain editable LaTeX outline sources and review PDFs in `Tex/part1/chapterNN/outline/`. Chapters 9–12 use the same convention in `Tex/part2/chapterNN/outline/`; Chapter 12 additionally preserves its Markdown outline. The scaffold check enforces the presence of the outline PDF/source pair and verifies that prose exists only after outline approval.


## Current batch status: Chapters 9–10 drafted

- Both outlines were approved by the author on 14 November 2026 after a final minor-issue review. The `.tex` sources and approval-record PDFs remain in `Tex/part2/chapter09/outline/` and `Tex/part2/chapter10/outline/`.
- Chapter 9 — *Why Feature-Level Descriptions Are Not Enough* is drafted in `Tex/part2/chapter09/chapter.tex`. It introduces the documented mechanism as the unit of analysis, feature labels versus operational mechanisms, the independence of evidence relation and migration depth, the node--edge--invariant claim test, and the review's bounded validity claims.
- Chapter 10 — *The Seven Fields of a Mechanism* is drafted in `Tex/part2/chapter10/chapter.tex`. It teaches the exact tuple `K = <S,C,T,P,F,L,R>` and applies it to the ACT-R record in Fan & Lan's Appendix A without filling undocumented fields.
- Eight Mermaid sources were added (four per chapter). The shared renderer and validator cover all 45 Mermaid sources across Chapters 1–11, and the standalone build covers Chapters 1–11 and the combined-book PDF quality checks validate all twelve chapter headings currently drafted.
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
- The next authorized writing batch is Chapter 13 (B2), but it must not begin until this revised Chapter 12 passes the actual CI render, compile, and visual-review gates.


### Chapter 11 standalone layout validation

A standalone XeLaTeX smoke build produced a 43-page, 7 × 10 inch PDF with bibliography, glossary, and index. Text extraction and page rendering completed; representative table, warning-box, recap, and end-matter pages were inspected. The local build used temporary Nimbus font substitutes and conspicuously marked placeholder PNGs only to test LaTeX integration and page layout. Those outputs are not final illustrated chapter PDFs and are excluded from the repository archive. The original author-supplied `Tex/preamble.tex` was restored and its SHA-256 verified as `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`. The actual Mermaid CLI could not run locally because `registry.npmjs.org` was not resolvable; the first GitHub Actions run must generate and visually validate the real PNG figures.
