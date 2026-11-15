# Book Writing and Production Rules

**Project:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Status:** Authoritative working specification. Read this file before outlining, drafting, revising, or packaging any chapter.

## 1. Approval and delivery workflow

1. Every chapter receives its own detailed outline and its own approval before chapter prose is written.
1a. **Author update effective 15 November 2026 (Chapter 16 onward):** the sole outline-review deliverable is one consolidated Markdown file in that chapter's local `outline/` folder. Do not generate an outline PDF, a LaTeX outline wrapper/body, or parallel review formats. Keep only the current review version: revise the canonical Markdown file in place rather than accumulating superseded outline versions. Preserve earlier chapters' historical outline artifacts unchanged unless the author explicitly requests a cleanup. After outline approval, write the chapter itself in LaTeX in `chapter.tex`; the normal chapter build/quality process applies to the authored chapter, not to the Markdown outline.
2. Select batch size dynamically from chapter scope and intellectual continuity. Use two-chapter batches when the chapters form a coherent pair; use a single-chapter batch for unusually broad or technically dense chapters; combine more only when the chapters are tightly coupled and can be reviewed without compressing either. Retain chapter-by-chapter outline approval in every case. One chapter's approval does not approve another chapter's outline.
3. For each batch: prepare one consolidated Markdown outline for each chapter in the selected batch; wait for approval of each; draft only the approved chapters in LaTeX; perform a source-fidelity and cross-chapter consistency review; build and visually inspect the authored chapter PDFs and the combined book PDF. Do not build PDFs for outline review.
4. Do not silently treat a proposed outline, a prior chapter's approval, or a request to continue as approval of an unapproved outline.
5. Deliver chapter content as individual PDFs. Do not deliver Markdown chapters, ZIP archives, or combined PDFs unless the author explicitly requests those formats. Repository source files remain in the project repository.
6. Keep a durable status entry in `README.md` and preserve approved outlines, rule versions, and delivery checkpoints in `review/`.

## 2. Source discipline and theoretical scope

The book has two formal theoretical foundations only:

- **[CoALA]** Sumers, Yao, Narasimhan, and Griffiths, *Cognitive Architectures for Language Agents*, Transactions on Machine Learning Research (2024), with the original arXiv manuscript as the earlier version.
- **[Fan & Lan]** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026).

Use only the two formal source labels `[CoALA]` and `[Fan & Lan]`. Use the shared `\CoALACite{...}` and `\FanLanCite{...}` footnote macros. Do not invent additional formal theory labels.

Part I explains CoALA on its own terms. Never use Fan & Lan to reinterpret, extend, or retroactively change what CoALA says. Part II treats Fan & Lan as a separate paper and distinguishes its explicit claims, hypotheses, analysis, and boundaries. Part III's Java systems are engineering applications, not claims that either paper prescribes those implementations.

Do not introduce Tree of Thoughts, RAP, or any other research framework as an additional theoretical foundation. Other works may be named only when they are examples explicitly discussed or cited within the primary paper being explained; do not turn those works into parallel theory chapters or claim their mechanisms as CoALA/Fan & Lan mechanisms.

For every substantive theoretical claim, identify the exact supporting paper section, figure, table, or appendix during research and preserve that trace in the prose and footnotes. If a claim is an explanation, interpretation, illustrative analogy, or engineering recommendation rather than an explicit paper statement, mark and phrase it accordingly. Do not make unsupported claims sound like quotations or direct paper statements.

## 3. Teaching style and chapter construction

- Write for a technically curious beginner with basic programming knowledge; do not assume prior knowledge of cognitive architectures or agent research.
- Use the sequence **problem first → concrete intuition → term → precise mechanism → example → boundary**. Do not dump a glossary of definitions before the reader needs the terms.
- Explain every new term at first meaningful use. Distinguish nearby concepts explicitly.
- Use complete, connected explanations, not compressed notes or lists of unexplained labels. Tables and bullets support explanations; they do not replace them.
- Develop concepts progressively. Reuse the Product X payment-service incident as the book-created running example where useful, but identify it as a **[Book example]** and never imply it comes from either paper.
- Make examples technically plausible and internally consistent. Do not add invented product details and then use them as factual evidence.
- Each chapter should have a clear chapter-at-a-glance orientation, learning outcomes, a logical section progression, selective worked examples, source/boundary notes, a recap, and review questions or exercises when pedagogically useful.
- Avoid repeating material already taught. Preview later concepts briefly and point to their chapter; do not teach later chapters prematurely.
- Keep chapters substantial enough to explain the subject properly. There is no fixed page-count ceiling; completeness, clarity, accuracy, and teaching value govern length.

## 4. Part I scope boundaries

- Chapter 1 motivates why a cognitive architecture is useful and introduces the CoALA map at a high level.
- Chapter 2 explains the architecture as a whole and the relationships among memory, action space, and the decision procedure.
- Chapter 3 explains the memory model in depth: working memory and long-term episodic, semantic, and procedural memory.
- Chapter 4 explains internal actions: retrieval, reasoning, and learning. Keep external grounding as a boundary and defer its full explanation to Chapter 5.
- Chapter 5 explains external actions and grounding.
- Chapters 6–8 develop planning, proposal/evaluation/selection, and interleaving/iteration. Do not duplicate the full decision procedure in Chapters 3 or 4.

## 5. Shared LaTeX system and preamble

- `Tex/preamble.tex` is the one shared authorial preamble. It is loaded once by `Tex/main.tex`; chapter fragments must never load it.
- The latest author-supplied preamble supersedes earlier preferences for trim size and fonts: its current specification is a 7 × 10 inch, two-sided, open-right book using TeX Gyre Termes, TeX Gyre Heros, and TeX Gyre Cursor. The author-supplied preamble is the design baseline. It may be changed only when a demonstrable improvement is needed for consistent typography, accessibility, rendering, pagination, or figure placement. Preserve existing design intent and explain nontrivial changes in the review notes.
- Use the `book` class, XeLaTeX, `fontspec`, the author's selected fonts and page layout, shared colors, heading styles, headers/footers, `listings`, `graphicx`, captions, and reusable teaching environments from the preamble.
- Use `Tex/shared-macros.tex` for book-wide commands, citations, glossary, index, and reusable macros/environments. Do not create chapter-local versions of shared commands or boxes.
- Shared environments include `learningbox`, `tipbox`, `warningbox`, `notebox`, `takeawaybox`, `chapterrecap`, and `reviewquestions`. Use them consistently and selectively. All chapters must follow the same semantic box policy. Chapters 1–4 establish the visual baseline: a chapter-at-a-glance orientation, selective learning/tip/note/warning/takeaway boxes where they serve a pedagogical purpose, a chapter recap, and review questions. Do not force boxes around ordinary prose. Boxes are for learning objectives, genuinely useful tips, important cautions, clarifications, takeaways, recaps, and questions—not decoration or wrapping ordinary paragraphs.
- Keep code examples in `listings`; use the shared language definitions and formatting. Avoid raw code screenshots.
- Use semantic macros and labels consistently. Every figure has a caption and stable label; every cross-reference resolves.

## 6. Diagrams and figures: Mermaid is authoritative

All conceptual diagrams are authored as Mermaid text and rendered to PNG by CI before LaTeX compilation.

- Store editable `.mmd` sources under `Tex/diagrams/source/partN/chapterNN/`.
- Store shared Mermaid theme and configuration in `Tex/diagrams/mermaid.config.json` (and related shared renderer configuration only when needed).
- Pin Mermaid CLI in `tools/mermaid/package.json` and its lockfile. Never use an unpinned `npx @mermaid-js/mermaid-cli@latest` in CI.
- CI uses Node.js 22.13+ (the repository currently configures Node 24), installs the exactly version-pinned Mermaid CLI from `tools/mermaid/package.json`, and renders every `.mmd` source into a high-resolution PNG under the matching path in `Tex/diagrams/generated/` before XeLaTeX starts. The direct CLI version is pinned to 12.2.0; a committed npm lockfile remains a reproducibility improvement to add once dependency resolution is available. Until then, npm resolves transitive ranges during the CI install and this limitation must be disclosed.
- The shared render script must be deterministic and recursive, handle spaces safely, fail on invalid Mermaid syntax, and generate a PNG for every source. CI validates PNG integrity, dimensions/resolution, matching LaTeX references, and missing/orphan generated files.
- Use one shared Mermaid visual theme derived from the book colors and typography. Use `accTitle` and `accDescr` in each diagram source; also provide meaningful captions and nearby explanatory prose because the book embeds PNGs.
- Use Mermaid for flowcharts, architecture maps, decision cycles, timelines, state diagrams, and other conceptual illustrations. Do not use TikZ, hand-positioned LaTeX nodes, ASCII-art diagrams, or custom LaTeX diagram libraries for book diagrams.
- LaTeX only places the generated image with `graphicx` through the shared `\BookDiagram` macro. The macro owns consistent width/height constraints, caption and label placement; Mermaid owns node arrangement, routing, spacing, and diagram layout.
- Keep diagram labels concise. If a diagram becomes too dense, split it into multiple focused diagrams rather than shrinking text until it is unreadable.
- Verify the actual CI-generated PNGs and final PDF at printed size. A mocked renderer or placeholder PNG can test the LaTeX integration layer only; it must never be reported as proof that real Mermaid output rendered correctly.
- Generated PNGs are build artifacts (not source of truth). CI uploads the generated PNG directory as a separate review artifact.

## 7. References, glossary, index, and terminology

- Bibliography is managed by `biblatex` and Biber, with footnote-style citations as selected by the author.
- Use `\CoALACite{...}` and `\FanLanCite{...}` for paper citations; do not hard-code one-off citation formats in chapter files.
- Add glossary entries to `Tex/glossary/terms.tex` and index entries consistently. Avoid duplicating terms or changing a term's meaning between chapters.
- Keep terminology stable across chapters. When a concept is revisited, deepen it rather than redefining it differently.

## 8. Quality assurance and release gates

Before delivering a chapter or batch:

1. Check all claims against the relevant primary-paper sections and figures.
2. Check no claims from one paper are attributed to the other.
3. Check the outline was explicitly approved.
4. Check chapter scope and avoid duplication with preceding/following chapters.
5. Compile with XeLaTeX through `latexmk`, using the repository's GitHub Actions TeX Live workflow.
6. Run the repository's scaffold, Mermaid, and PDF quality checks.
7. Inspect the PDF visually after rendering pages to images. Check diagrams at their printed size, box consistency, page breaks, headers, captions, references, footnotes, and overfull boxes.
8. Extract PDF text and verify chapter titles, headings, labels, metadata, and searchability.
9. Report which validation ran locally and which requires a real GitHub Actions execution. Never describe a mocked or substitute-font test as a full production build.
10. Deliver chapter PDFs individually. Include a build note for any known rendering limitation; do not claim accessibility conformance beyond the selected standard PDF target.


## 9. Part II mechanism-level writing rules

- Part II explains Fan and Lan's 2026 paper as a separate contribution. Do not use it to reinterpret CoALA or present its review as a correction to Part I.
- Chapter 9 establishes why feature labels are too coarse and why the documented mechanism is the unit of analysis. It may introduce the distinction between evidence relation and implementation depth conceptually, but must defer the precise E1–E4 and D0–D4 definitions and precedence rules to Chapter 11.
- Chapter 10 teaches the seven-field representation exactly as given in Section II-C: operative state substrate (S), control locus (C), transition trigger (T), persistence boundary (P), failure semantics (F), learning operator (L), and resource/governance policy (R). Do not rename, reorder, merge, or add fields.
- The seven-field tuple is an analytical representation, not a required software architecture, maturity score, or claim that every field must be fully populated. Unknown or undocumented fields must remain unknown; never fill them from architecture names or plausible assumptions.
- Evidence relation (E1–E4) and migration depth (D0–D4) are separate axes, not fields in the tuple and not one combined score. Full operational definitions, coding rules, and historical-to-modern ledger work belong to Chapter 11.
- For every historical or modern mechanism, keep evidence claims tied to Fan and Lan's stated source record. Repository popularity is not scientific evidence; executable implementation claims require a versioned release, tag, or commit where the paper requires it.
- Describe the paper as a bounded mechanism-level mapping review. Preserve its explicit validity boundaries: no PRISMA completeness claim, no search-recall or stable hit-count claim, no pooled/causal performance claim, and no independent inter-rater reliability claim in the submitted manuscript. Do not turn the corpus counts or highest reviewed migration depth into prevalence or universal-maximum claims.
- Distinguish explicit paper statements, the authors' analysis or hypotheses, and book-created teaching examples. Only the two formal labels `[CoALA]` and `[Fan & Lan]` may be used.
- Avoid premature mechanism deep-dives: Chapter 11 owns the historical catalog and migration mapping; Chapters 12–16 own B1, B2, B3, B4, and B6; Chapter 17 owns the closed B5/GraSP case; Chapter 18 owns the synthesis.
- Every authored chapter must use the shared preamble, macros, semantic teaching boxes, footnote citation macros, and Mermaid-to-PNG pipeline. Markdown outlines carry source anchors and proposed figure plans but do not load the preamble or require a PDF build. Planned figures belong in chapter-specific `.mmd` source directories when the chapter is drafted.

## 10. Current project state (2026-11-14)

- Chapters 1 and 2 have been drafted and integrated. Both use the shared semantic teaching-box system and Mermaid-to-PNG figure pipeline.
- Chapters 3 and 4 have now been drafted from their reviewed outlines. The author explicitly requested the additional review pass and drafting of this batch. The chapter drafts are ready for author review.
- Eight Mermaid sources were added for Chapters 3 and 4; the validator was then expanded as later chapter batches were integrated and now covers 39 sources for Chapters 1–10.
- The latest author-supplied preamble remains the shared design baseline. It has a reusable `\BookDiagram` macro; no chapter-specific drawing package is allowed.
- Chapter 5 — External Actions and Grounding: outline v1.0 explicitly approved on 14 November 2026; chapter drafted and integrated. Source-fidelity review covers CoALA §4.2, Figure 5, and the action-space safety discussion in §6.
- Chapter 6 — Planning: From a Problem to Candidate Actions: outline v1.0 explicitly approved on 14 November 2026; chapter drafted and integrated. Source-fidelity review covers CoALA §4.6, Figure 4B, and the proposal sub-stage.
- Eight Mermaid sources were added for Chapters 5 and 6; the repository later expanded to 39 sources across Chapters 1–10.
- Chapters 1–10 each have a standalone LaTeX entry point. The PDF validation script and standalone build script cover Chapters 1–10.
- Chapters 9–10 have approved outline v1.0 files in their chapter-local `outline/` folders and drafted chapter prose (approximately 4,259 and 3,921 words). Their source-fidelity and drafting reviews are recorded in `review/Batch_09-10_Source_Review.md` and `review/Batch_09-10_Drafting_Review.md`. Their individual LaTeX layout tests passed (22 and 20 pages), but use placeholder PNGs and are not final illustrated PDFs. The real Mermaid render remains a GitHub Actions gate because local npm registry resolution failed with `EAI_AGAIN`. Chapters 11–30 remain structural placeholders until their own outlines are reviewed and the author authorizes their prose.


### Chapter 7–8 status (14 November 2026)

- Chapter 7 — Evaluation and Selection: outline v1.0 was explicitly approved by the author on 14 November 2026 after a final review for minor issues. The chapter has now been drafted and integrated in `Tex/part1/chapter07/chapter.tex` (approximately 3,377 words).
- Chapter 8 — Interleaving, Iteration and the Complete CoALA Decision Process: outline v1.0 was explicitly approved by the author on 14 November 2026 after a final review for minor issues. The chapter has now been drafted and integrated in `Tex/part1/chapter08/chapter.tex` (approximately 3,493 words).
- Approved outline PDFs and editable `.tex` sources remain stored inside each corresponding chapter's `outline/` folder. Their cover pages and approval notes now record that approval was granted.
- Nine new Mermaid source files were added for Chapters 7–8 (four for Chapter 7 and five for Chapter 8). The shared renderer and validator cover all 31 Mermaid source files across Chapters 1–8. Generated PNGs remain CI build outputs and are not committed.
- The standalone build script now covers Chapters 1–8, and PDF quality checks verify the Chapter 7 and Chapter 8 headings. The scaffold check confirms that both approved chapters contain prose and retain their outline assets.
- Source and drafting review notes are recorded in `review/Batch_07-08_Source_Review.md` and `review/Batch_07-08_Drafting_Review.md`.
- Local npm installation of Mermaid CLI 12.2.0 was attempted again on 14 November 2026 and failed because `registry.npmjs.org` could not be resolved (`EAI_AGAIN`). Therefore real PNG rendering and printed-size visual inspection remain a GitHub Actions verification gate. Mock PNGs may be used only for a disposable LaTeX layout smoke test and must not be represented as actual Mermaid output.


### Part II Batch 1 — Chapters 9–10 drafted (14 November 2026)

- Chapter 9 — Why Feature-Level Descriptions Are Not Enough: outline v1.0 prepared from Fan & Lan §§I, II-A–II-B, II-D–II-E, III, and VII, including Figure 1 and Tables I–II. The chapter motivates the feature/mechanism distinction, introduces the documented mechanism as the unit of analysis, explains why evidence relationship and migration depth are separate questions, and preserves the paper's bounded-review validity disclosures.
- Chapter 10 — The Seven Fields of a Mechanism: outline v1.0 prepared from Fan & Lan §II-C, §§II-A and II-D–II-E, §III, Appendix A Tables VII–VIII, Appendix B, and §VII-C. It teaches K = <S,C,T,P,F,L,R> without adding, reordering, or renaming fields; uses the paper's ACT-R ledger entry as a worked example; and keeps E/D coding as separate axes for Chapter 11.
- Both outline PDFs and editable LaTeX sources are stored in `Tex/part2/chapter09/outline/` and `Tex/part2/chapter10/outline/`. Both outlines were approved by the author on 14 November 2026 and their approval records are synchronized. The scaffold check enforces the outline pair and completed chapter source.
- The chapter drafts use temporary local font substitutions only in disposable layout tests when TeX Gyre OpenType faces are unavailable; the repository preamble remains unchanged and is used by GitHub Actions.


## 11. Author-approved Part II batch plan and completion state (15 November 2026)

Part II uses the author's dynamic nine-batch plan, not a fixed two-chapter cadence:

1. Batch 1 — Chapters 9–10: analytical foundation (feature labels and the seven-field mechanism representation).
2. Batch 2 — Chapter 11: historical-to-modern architecture and mechanism mapping.
3. Batch 3 — Chapter 12: B1, activation, retrieval latency, utility, and maintenance cost.
4. Batch 4 — Chapter 13: B2, typed impasses, substates, and compilation.
5. Batch 5 — Chapter 14: B3, content competition, workspace, and broadcast.
6. Batch 6 — Chapter 15: B4, persistent intentions, reconsideration, and method authority.
7. Batch 7 — Chapter 16: B6, uncertainty, resources, interruption, and stopping.
8. Batch 8 — Chapter 17: B5/GraSP as the closed-candidate methodological case, not a sixth residual hypothesis.
9. Batch 9 — Chapter 18: synthesis of the mechanisms after Chapters 9–17 are complete and reviewed.

The author explicitly selected this grouping on 15 November 2026. Do not change the approved Part II table of contents, force unrelated chapters into pairs, or start Chapter 18 before Chapters 9–17 are completed and reviewed. Chapter 18 is now drafted and integrated; it closes Part II without claiming that the composed runtime has been empirically validated. Chapters 16–18 follow the Markdown-only outline review convention in §1; their authored chapter sources remain LaTeX.
